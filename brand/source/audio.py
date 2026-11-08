import numpy as np, wave
SR=44100; D=15.0; rng=np.random.default_rng(7)
t=np.arange(int(D*SR))/SR
L=np.zeros_like(t); R=np.zeros_like(t)
def add(sig,at,pan=0.0,g=1.0):
    i=int(at*SR); j=min(len(t),i+len(sig)); s=sig[:j-i]*g
    L[i:j]+=s*np.sqrt((1-pan)/2); R[i:j]+=s*np.sqrt((1+pan)/2)
def lp(x,n): return np.convolve(x,np.ones(n)/n,'same')
def env(n,a,r):
    k=np.arange(n)/SR; return np.minimum(1,k/a)*np.exp(-np.maximum(0,k-a)/r)
# pad: Dmaj9-ish, swells in, lifts at wordmark
pad=np.zeros_like(t)
for f,w in [(146.83,1),(220.0,.8),(277.18,.6),(329.63,.5),(440.0,.25)]:
    pad+=w*(np.sin(2*np.pi*f*t+np.sin(2*np.pi*.15*t))+.2*np.sin(2*np.pi*2.003*f*t))
padenv=np.clip(t/3,0,1)*(0.55+0.45*np.clip((t-8)/1.5,0,1))*np.clip((15-t)/1.2,0,1)
pad*=0.045*padenv; L+=pad; R+=pad
def whoosh(dur,up=True):
    n=int(dur*SR); x=lp(rng.standard_normal(n),30); k=np.arange(n)/n
    e=(k**2 if up else np.sin(np.pi*k)**2)*(1 if up else 1); e*=np.minimum(1,(1-k)*12)
    return x*e
def tick(f=2400,dur=.05):
    n=int(dur*SR); k=np.arange(n)/SR
    return np.sin(2*np.pi*f*k)*np.exp(-k*110)+.3*lp(rng.standard_normal(n),3)*np.exp(-k*200)
def chime(f,dur=2.5):
    n=int(dur*SR); k=np.arange(n)/SR; s=np.zeros(n)
    for m,a,d in [(1,1,1.6),(2.76,.35,.6),(5.4,.15,.3),(2,.25,1.0)]:
        s+=a*np.sin(2*np.pi*f*m*k)*np.exp(-k/d)
    return s*np.minimum(1,k/.004)
def thump(dur=.6):
    n=int(dur*SR); k=np.arange(n)/SR; f=90*np.exp(-k*6)+45
    return np.sin(2*np.pi*np.cumsum(f)/SR)*np.exp(-k*7)
def pencil(dur):
    n=int(dur*SR); x=rng.standard_normal(n); x=x-lp(x,6); k=np.arange(n)/n
    return x*np.sin(np.pi*k)**.5*(0.6+0.4*np.sin(2*np.pi*13*k*dur))
add(whoosh(1.2,False),0.2,0,.10)          # bar + grid
add(tick(1500),1.4,-.4,.18)               # bar lands
add(pencil(1.2),1.4,-.2,.035)             # frame drawn
add(pencil(1.2),2.6,.2,.04)               # P drawn
add(tick(1800,.08),4.25,0,.30); add(thump(),4.25,0,.25)   # stem locks
for i,a in enumerate([4.5,5.0,5.5]): add(tick(2600+i*200),a,.5,.16)  # revs
add(chime(880),6.0,.4,.10)                # Current
add(whoosh(1.0,True),7.2,0,.12)           # move
for i in range(6): add(tick(3200,.03),8.0+i*.09,-.3+i*.12,.06)
add(chime(587.33,3.5),8.55,-.1,.12); add(chime(880,3),8.6,.15,.07); add(thump(.8),8.55,0,.22)
for i,a in enumerate([10.0,10.55,11.1]): add(tick(2000,.05),a,0,.12)
add(chime(1174.66,2.5),11.1,.2,.06)
m=np.stack([L,R],1); fo=np.clip((15-t)/0.6,0,1)[:,None]; m*=fo
m/=np.max(np.abs(m))/0.7
w=wave.open('out/logo-sound.wav','wb'); w.setnchannels(2); w.setsampwidth(2); w.setframerate(SR)
w.writeframes((m*32767).astype(np.int16).tobytes()); w.close(); print('ok')
