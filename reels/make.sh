#!/usr/bin/env bash
# Usage: reels/make.sh <reel-id> [...]  — records video, builds audio, muxes to out/<id>.mp4
# and writes out/<id>-cover.jpg (frame at 2.2 s). Run from anywhere.
set -euo pipefail
cd "$(dirname "$0")"
for id in "$@"; do
  node record.js "$id"
  python3 audio.py "$id"
  ffmpeg -y -loglevel error -i "out/$id-video.mp4" -i "out/$id.wav" -c:v copy -c:a aac -b:a 160k -shortest -movflags +faststart "out/$id.mp4"
  ffmpeg -y -loglevel error -ss 2.2 -i "out/$id.mp4" -frames:v 1 -q:v 3 "out/$id-cover.jpg"
  rm -f "out/$id-video.mp4" "out/$id.wav"
  echo "built out/$id.mp4"
done
