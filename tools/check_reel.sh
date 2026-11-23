#!/usr/bin/env bash
# Pre-post check for a reel. Usage: tools/check_reel.sh <reel-id>
# Fails (exit 1) unless: the video has an H.264 video track and an audible audio track, is 9:16, 5-90 s,
# the cover exists, both public links return HTTP 200, and the queue entry has a non-empty caption.
set -u
id="$1"; cd "$(dirname "$0")/.."
v="reels/out/$id.mp4"; c="reels/out/$id-cover.jpg"
base="https://raw.githubusercontent.com/lucifer3344/plavyn-social/main"
fail=0; say(){ echo "$1"; }; bad(){ echo "FAIL: $1"; fail=1; }

[ -f "$v" ] || bad "missing $v"
[ -f "$c" ] || bad "missing $c"
if [ -f "$v" ]; then
  vc=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,width,height -of csv=p=0 "$v")
  ac=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of csv=p=0 "$v")
  dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$v")
  vol=$(ffmpeg -i "$v" -af volumedetect -f null - 2>&1 | grep -o 'mean_volume: [-0-9.]*' | awk '{print $2}')
  say "video: $vc | audio: ${ac:-none} | ${dur}s | mean volume ${vol:-n/a} dB"
  [[ "$vc" == h264* ]] || bad "video track not h264"
  w=$(echo "$vc" | cut -d, -f2); h=$(echo "$vc" | cut -d, -f3)
  [ -n "$w" ] && [ $((w*16)) -eq $((h*9)) ] || bad "not 9:16 (${w}x${h})"
  [ -n "$ac" ] || bad "no audio track"
  awk -v x="${vol:--91}" 'BEGIN{exit !(x > -50)}' || bad "audio is silent (mean ${vol:-n/a} dB) - mix in a sound bed (reels/audio.py) before posting"
  awk -v d="$dur" 'BEGIN{exit !(d >= 5 && d <= 90)}' || bad "duration $dur s outside 5-90 s"
fi
for u in "$base/$v" "$base/$c"; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -I "$u"); say "$code $u"; [ "$code" = 200 ] || bad "link not 200: $u"
done
cap=$(python3 -c "import json,sys;print(next((e.get('caption') or '' for e in json.load(open('reel_queue.json')) if e['id']=='$id'),''))")
[ -n "$cap" ] || bad "no caption in reel_queue.json for $id"
say "caption: ${#cap} chars, $(echo "$cap" | grep -o '#[A-Za-z0-9_]*' | wc -l) hashtags"
[ ${#cap} -le 2200 ] || bad "caption over 2200 chars"
[ $fail = 0 ] && echo "OK: $id ready to post" ; exit $fail
