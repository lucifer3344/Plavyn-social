// Renders Plavyn social images from a spec file.
// Usage: node render.js content/<id>.json [more.json ...]
// Writes out/<id>-post.jpg (1080x1350) and out/<id>-story.jpg (1080x1920)
// unless the spec sets "formats" to a subset of ["post","story"].
// kind "text" = headline + sub only (used for carousel slides).
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');

const ROOT = __dirname;
const F = p => 'file://' + path.join(ROOT, p);

const LOGO = '<svg viewBox="0 0 100 100"><rect width="100" height="100" rx="22" fill="#1b1e1d" stroke="#3a3f3e" stroke-width="2"/><path d="M30 78 V22 H58 C68 22 76 29 76 39 C76 49 68 56 58 56 H30" fill="none" stroke="#f3f4f1" stroke-width="7" stroke-linecap="square"/><path d="M30 22 V78" fill="none" stroke="#7cbcc4" stroke-width="7" stroke-linecap="square"/></svg>';

const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
// "*text*" turns teal, "\n" breaks the line
const rich = s => esc(s).replace(/\*([^*]+)\*/g, '<span class="t">$1</span>').replace(/\n/g, '<br>');

function css(H, story) {
  return `
@font-face{font-family:Inter;font-weight:500;src:url(${F('node_modules/@fontsource/inter/files/inter-latin-500-normal.woff2')})}
@font-face{font-family:Inter;font-weight:600;src:url(${F('node_modules/@fontsource/inter/files/inter-latin-600-normal.woff2')})}
@font-face{font-family:Inter;font-weight:800;src:url(${F('node_modules/@fontsource/inter/files/inter-latin-800-normal.woff2')})}
@font-face{font-family:Cond;font-weight:500;src:url(${F('node_modules/@fontsource/barlow-condensed/files/barlow-condensed-latin-500-normal.woff2')})}
@font-face{font-family:Cond;font-weight:600;src:url(${F('node_modules/@fontsource/barlow-condensed/files/barlow-condensed-latin-600-normal.woff2')})}
:root{--ink:#1D1F1F;--paper:#F3F3F1;--teal:#80BCC5;--muted:#A9B4B6}
*{box-sizing:border-box;margin:0;padding:0}
body{width:1080px;height:${H}px;overflow:hidden;background:var(--ink);color:var(--paper);font-family:Inter,sans-serif;-webkit-font-smoothing:antialiased;position:relative}
.grid{position:absolute;inset:0;background-image:linear-gradient(rgba(128,188,197,.15) 1px,transparent 1px),linear-gradient(90deg,rgba(128,188,197,.15) 1px,transparent 1px),linear-gradient(rgba(128,188,197,.075) 1px,transparent 1px),linear-gradient(90deg,rgba(128,188,197,.075) 1px,transparent 1px);background-size:180px 180px,180px 180px,36px 36px,36px 36px;background-position:-1px -1px}
.vig{position:absolute;inset:0;background:radial-gradient(ellipse at 60% 60%,rgba(29,31,31,0) 0%,rgba(29,31,31,.6) 100%)}
.datum{position:absolute;top:0;bottom:0;left:64px;width:8px;background:var(--teal)}
.col{position:absolute;left:0;right:0;top:${story ? 210 : 72}px;bottom:0;display:flex;flex-direction:column;padding:0 64px 0 112px}
.top{display:flex;align-items:center;justify-content:space-between}
.brand{display:flex;align-items:center;gap:16px}.brand svg{width:56px;height:56px}.brand span{font-size:30px;font-weight:600}
.mark{font-family:Cond;font-weight:500;letter-spacing:.16em;color:var(--teal);font-size:24px;text-transform:uppercase;white-space:nowrap}
h1{margin-top:${story ? 110 : 90}px;margin-left:-4px;font-weight:800;letter-spacing:-.045em;line-height:.98}
h1 .t{color:var(--teal)}
.sub{margin-top:${story ? 44 : 36}px;color:var(--muted);font-weight:500;font-size:${story ? 34 : 30}px;line-height:1.32;max-width:880px}
.media{position:relative;flex:1;margin-top:${story ? 72 : 60}px;margin-left:-48px;display:flex;justify-content:center${story ? ';overflow:hidden;margin-bottom:300px;padding:2px;-webkit-mask-image:linear-gradient(#000 78%,transparent)' : ''}}
.card{position:relative;overflow:hidden;border-radius:48px;background:#f2f2f7;box-shadow:0 0 0 2px #34393a,0 40px 90px rgba(0,0,0,.6);flex:none}
.card img{position:absolute;left:0;display:block}
.stack{display:flex;flex-direction:column;gap:32px}
.list{margin-left:48px;width:100%;display:flex;flex-direction:column}
.li{display:flex;gap:28px;align-items:baseline;padding:${story ? 30 : 22}px 0;border-top:2px solid rgba(128,188,197,.28)}
.li:last-child{border-bottom:2px solid rgba(128,188,197,.28)}
.li b{font-family:Cond;font-weight:600;color:var(--teal);font-size:40px;letter-spacing:.06em;width:56px;flex:none}
.li span{font-size:${story ? 38 : 34}px;font-weight:500;line-height:1.25}
.foot{position:absolute;left:112px;bottom:${story ? 230 : 64}px}
`;
}

function cardHTML(m, W, maxH) {
  // m: {img, y0, y1, x0, x1} crop in source pixels; W: shown width
  const { w: iw, h: ih } = m._size;
  const x0 = m.x0 || 0, x1 = m.x1 || iw;
  const scale = W / (x1 - x0);
  const y0 = m.y0 || 0;
  const h = m.y1 ? (m.y1 - y0) * scale : Math.min((ih - y0) * scale, maxH);
  const r = m.radius != null ? m.radius : 48;
  return `<div class="card" style="width:${W}px;height:${Math.round(h)}px;border-radius:${r}px"><img src="${F(m.img)}" style="width:${iw * scale}px;top:${-y0 * scale}px;left:${-x0 * scale}px"></div>`;
}

function html(spec, fmt) {
  const story = fmt === 'story';
  const H = story ? 1920 : 1350;
  const size = (story && spec.storyHeadlineSize) || spec.headlineSize || (story ? 112 : 104);
  let media = '';
  if (spec.kind === 'device') {
    media = cardHTML(spec.media, (story && spec.media.storyWidth) || spec.media.width || 760, 3000);
  } else if (spec.kind === 'widgets') {
    media = '<div class="stack">' + spec.media.map(m => cardHTML(m, m.width || 820, 3000)).join('') + '</div>';
  } else if (spec.kind === 'list') {
    media = '<div class="list">' + spec.items.map((t, i) => `<div class="li"><b>${String(i + 1).padStart(2, '0')}</b><span>${esc(t)}</span></div>`).join('') + '</div>';
  }
  const mark = story && spec.storyMark ? spec.storyMark : spec.mark;
  const foot = story ? `<div class="mark foot">${esc(spec.storyFoot || 'PLAVYN.COM')}</div>` : '';
  return `<!doctype html><html><head><meta charset="utf-8"><style>${css(H, story)}h1{font-size:${size}px}${spec.kind === 'text' ? `h1{margin-top:${story ? 420 : 300}px}.sub{font-size:${story ? 42 : 40}px;max-width:860px}` : ''}</style></head><body>
<div class="grid"></div><div class="vig"></div><div class="datum"></div>
<div class="col"><div class="top"><div class="brand">${LOGO}<span>Plavyn</span></div><div class="mark">${esc(mark || '')}</div></div>
<h1>${rich(spec.headline)}</h1>${spec.sub ? `<div class="sub">${rich(spec.sub)}</div>` : ''}
<div class="media">${media}</div></div>${foot}</body></html>`;
}

async function sizeOf(page, p) {
  return page.evaluate(src => new Promise(r => { const i = new Image(); i.onload = () => r({ w: i.naturalWidth, h: i.naturalHeight }); i.src = src; }), F(p));
}

(async () => {
  const files = process.argv.slice(2);
  if (!files.length) { console.error('usage: node render.js content/<id>.json ...'); process.exit(1); }
  fs.mkdirSync(path.join(ROOT, 'out'), { recursive: true });
  const b = await chromium.launch();
  for (const f of files) {
    const spec = JSON.parse(fs.readFileSync(f, 'utf8'));
    const page = await b.newPage({ viewport: { width: 1080, height: 1920 } });
    await page.goto(F('render.js'));
    const ms = spec.kind === 'device' ? [spec.media] : spec.kind === 'widgets' ? spec.media : [];
    for (const m of ms) m._size = await sizeOf(page, m.img);
    for (const fmt of spec.formats || ['post', 'story']) {
      const H = fmt === 'story' ? 1920 : 1350;
      await page.setViewportSize({ width: 1080, height: H });
      const tmp = path.join(ROOT, 'out', `.${spec.id}-${fmt}.html`);
      fs.writeFileSync(tmp, html(spec, fmt));
      await page.goto('file://' + tmp);
      await page.evaluate(() => document.fonts.ready);
      await page.waitForTimeout(250);
      const out = path.join(ROOT, 'out', `${spec.id}-${fmt}.jpg`);
      await page.screenshot({ path: out, type: 'jpeg', quality: 90 });
      fs.unlinkSync(tmp);
      console.log(out);
    }
    await page.close();
  }
  await b.close();
})();
