// node record.js preview t1,t2  |  node record.js  — renders 3 formats (video only)
const fs=require('fs'),path=require('path'),{spawn}=require('child_process'),{chromium}=require('playwright');
const F=[['vertical',1080,1920],['square',1080,1080],['landscape',1920,1080]];
const preview=process.argv[2]==='preview',DUR=15,FPS=30;
const only=process.argv[preview?4:3];
(async()=>{const b=await chromium.launch();const out=path.join(__dirname,'out');fs.mkdirSync(out,{recursive:true});
await Promise.all(F.filter(f=>!only||f[0]===only).map(async([name,w,h])=>{
 const pg=await b.newPage({viewport:{width:w,height:h}});
 await pg.goto('file://'+path.join(__dirname,'logo.html'));await pg.evaluate(()=>document.fonts.ready);
 await pg.evaluate(([w,h])=>setup(w,h),[w,h]);
 if(preview){for(const t of process.argv[3].split(',').map(Number)){await pg.evaluate(t=>render(t),t);await pg.screenshot({path:path.join(out,`${name}-t${t}.jpg`),type:'jpeg',quality:85});}return;}
 const tmp=path.join(out,`.${name}.tmp.mp4`);
 const ff=spawn('ffmpeg',['-y','-loglevel','error','-f','image2pipe','-framerate',''+FPS,'-i','-','-c:v','libx264','-crf','18','-preset','veryfast','-pix_fmt','yuv420p','-r',''+FPS,tmp]);
 for(let i=0;i<DUR*FPS;i++){await pg.evaluate(t=>render(t),i/FPS);const buf=await pg.screenshot({type:'jpeg',quality:92});if(!ff.stdin.write(buf))await new Promise(r=>ff.stdin.once('drain',r));}
 ff.stdin.end();const code=await new Promise(r=>ff.on('close',r));if(code===0)fs.renameSync(tmp,path.join(out,`${name}-video.mp4`));console.log(name,code===0?'ok':'FAILED');
}));await b.close();})();
