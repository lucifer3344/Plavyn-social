// node reels/clip.js <id>  — turns a raw clip (site video or screen recording) into a branded reel.
// Spec: reels/clips.json entry {id, raw: "reels/raw/<file>", mark, headline, end, start?, max?}
// Output: reels/out/<id>.mp4 (1080x1920, raw audio kept, <= max s + 2.5 s end card) and <id>-cover.jpg
const fs=require('fs'),path=require('path'),{execFileSync}=require('child_process'),{chromium}=require('playwright');
const D=__dirname,id=process.argv[2];
const c=JSON.parse(fs.readFileSync(path.join(D,'clips.json'))).find(x=>x.id===id);
if(!c) throw new Error('no clip spec '+id);
const raw=path.join(D,'..',c.raw),tmp=path.join(D,'out','.'+id);fs.mkdirSync(tmp,{recursive:true});
const ff=a=>execFileSync('ffmpeg',['-y','-loglevel','error',...a],{stdio:'inherit'});
(async()=>{
 const b=await chromium.launch(),p=await b.newPage({viewport:{width:1080,height:1920}});
 await p.goto('file://'+path.join(D,'clip.html'));
 await p.evaluate(c=>setup(c,false),c);await p.evaluate(()=>document.fonts.ready);
 await p.screenshot({path:tmp+'/ov.png',omitBackground:true});
 await p.evaluate(c=>setup(c,true),c);await p.screenshot({path:tmp+'/end.png'});await b.close();
 const hasAudio=execFileSync('ffprobe',['-v','error','-select_streams','a','-show_entries','stream=index','-of','csv=p=0',raw]).toString().trim()!=='';
 const vf='[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,format=yuv420p[v];[v][1:v]overlay=0:0[o]';
 ff(['-ss',String(c.start||0),'-t',String(c.max||25),'-i',raw,'-i',tmp+'/ov.png',...(hasAudio?[]:['-f','lavfi','-i','anullsrc=r=44100:cl=stereo']),
     '-filter_complex',vf,'-map','[o]','-map',hasAudio?'0:a':'2:a','-shortest','-c:v','libx264','-crf','20','-preset','veryfast','-c:a','aac','-ar','44100','-ac','2',tmp+'/main.mp4']);
 ff(['-loop','1','-t','2.5','-i',tmp+'/end.png','-f','lavfi','-t','2.5','-i','anullsrc=r=44100:cl=stereo','-vf','fps=30,format=yuv420p','-c:v','libx264','-crf','20','-c:a','aac','-ar','44100','-ac','2','-shortest',tmp+'/end.mp4']);
 ff(['-i',tmp+'/main.mp4','-i',tmp+'/end.mp4','-filter_complex','[0:v]setsar=1[a0];[1:v]setsar=1[b0];[a0][0:a][b0][1:a]concat=n=2:v=1:a=1[v][a]','-map','[v]','-map','[a]','-c:v','libx264','-crf','20','-preset','veryfast','-c:a','aac','-movflags','+faststart',path.join(D,'out',id+'.mp4')]);
 ff(['-ss','1.5','-i',path.join(D,'out',id+'.mp4'),'-frames:v','1','-q:v','3',path.join(D,'out',id+'-cover.jpg')]);
 fs.rmSync(tmp,{recursive:true});console.log('built reels/out/'+id+'.mp4');
})();
