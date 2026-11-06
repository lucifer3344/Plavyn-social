// node record.js [preview t1,t2,...] — records each reel in reels.json to out/<id>.mp4 (video only)
const fs=require('fs'),path=require('path'),{spawn}=require('child_process'),{chromium}=require('playwright');
const reels=JSON.parse(fs.readFileSync(path.join(__dirname,'reels.json')));
const preview=process.argv[2]==='preview';const only=process.argv[preview?4:2];
(async()=>{const b=await chromium.launch();fs.mkdirSync(path.join(__dirname,'out'),{recursive:true});
for(const r of reels){ if(only&&r.id!==only) continue;
 const p=await b.newPage({viewport:{width:1080,height:1920}});
 await p.goto('file://'+path.join(__dirname,'reel.html'));await p.evaluate(r=>setup(r),r);await p.evaluate(()=>document.fonts.ready);
 if(preview){for(const t of process.argv[3].split(',').map(Number)){await p.evaluate(t=>render(t),t);await p.screenshot({path:path.join(__dirname,'out',`${r.id}-t${t}.jpg`),type:'jpeg',quality:85});}await p.close();continue;}
 const tmp=path.join(__dirname,'out',`.${r.id}.tmp.mp4`),out=path.join(__dirname,'out',`${r.id}-video.mp4`);
 const ff=spawn('ffmpeg',['-y','-loglevel','error','-f','image2pipe','-framerate','30','-i','-','-c:v','libx264','-crf','18','-preset','veryfast','-pix_fmt','yuv420p','-r','30',tmp]);
 const N=Math.round(r.duration*30);
 for(let i=0;i<N;i++){await p.evaluate(t=>render(t),i/30);const buf=await p.screenshot({type:'jpeg',quality:92});if(!ff.stdin.write(buf))await new Promise(res=>ff.stdin.once('drain',res));}
 ff.stdin.end();const code=await new Promise(res=>ff.on('close',res));if(code===0)fs.renameSync(tmp,out);console.log(r.id,code===0?'ok':'FAILED');await p.close();}
await b.close();})();
