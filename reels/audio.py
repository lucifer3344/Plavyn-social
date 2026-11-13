# Soft pad + tap clicks + whooshes on screen changes, per reel; writes out/<id>.wav
import json, numpy as np, wave
SR = 44100
def pad(dur):
    t = np.arange(int(dur*SR))/SR
    chords = [[220.0, 277.18, 329.63, 415.30], [196.0, 246.94, 293.66, 369.99]]  # Amaj7, Gmaj7
    out = np.zeros_like(t)
    seg = 3.0
    for i, c in enumerate(chords * int(dur/seg/2 + 2)):
        a, b = i*seg, (i+1)*seg + 1.0
        if a > dur: break
        m = (t >= a) & (t < b)
        env = np.sin(np.pi*np.clip((t[m]-a)/(b-a), 0, 1))**2
        for f in c:
            out[m] += env*(np.sin(2*np.pi*f*t[m]) + .3*np.sin(2*np.pi*2*f*t[m]))/len(c)
    fade = np.minimum(1, np.minimum(t/1.0, (dur-t)/1.5))
    return .16*out*fade
def click(n=int(.06*SR)):
    t = np.arange(n)/SR
    return .5*np.sin(2*np.pi*1800*t)*np.exp(-t*90) + .25*np.random.randn(n)*np.exp(-t*160)
def whoosh(n=int(.45*SR)):
    t = np.arange(n)/SR
    noise = np.convolve(np.random.randn(n), np.ones(40)/40, 'same')
    return .35*noise*np.sin(np.pi*t/t[-1])**2
import sys
ONLY = sys.argv[1:]
for r in json.load(open('reels.json')):
    if ONLY and r['id'] not in ONLY: continue
    d = r['duration']; a = pad(d)
    def add(sig, at):
        i = int(at*SR); j = min(len(a), i+len(sig)); a[i:j] += sig[:j-i]
    for k in r.get('finger', []):
        if k.get('tap'): add(click(), k['t'])
    for s in r.get('screens', [])[1:] + r.get('cards', []): add(whoosh(), s['at'])
    add(whoosh()*1.2, r['endAt'])
    a = np.clip(a, -1, 1)
    w = wave.open(f"out/{r['id']}.wav", 'wb'); w.setnchannels(1); w.setsampwidth(2); w.setframerate(SR)
    w.writeframes((a*32767).astype(np.int16).tobytes()); w.close()
