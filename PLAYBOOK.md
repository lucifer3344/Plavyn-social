# Plavyn Instagram — daily posting playbook

Account: @plavyn_1 (Windsor.ai connector `instagram`, account id `17841480417097331`).
Every day: 9 AM IST one feed post (Saturdays: a carousel) and one story; 7 PM IST one reel.
Goal: grow followers. Reels reach non-followers; image posts mostly reach existing followers (in Nov 2026 images reached ~0, reels 1–31).

## Learnings (from weekly reports — follow these; the Monday report updates them)
Week to 2026-11-23: still 1 follower. **0 reels posted → total reach 0.** All 7 feed posts (incl. the c01 carousel) reached 0,
for the third week running. Account reach for the whole week: 2.
- **The evening reel run had no scheduled task until 11-23.** Only the 9 AM daily-post task exists, so reels only went out when run by hand
  (11-14, 11-15). Until a 7 PM task exists, nothing in `reel_queue.json` posts. Re-dated the 5 stuck reels to 11-23..11-27; the "Plavyn evening reel" scheduled task (6:42 PM IST daily) was created on 11-23.
- **Daily run check:** after posting, look at `reel_queue.json`. If the newest reel with a `media_id` is more than 2 days old,
  or any reel dated before today has `media_id: null`, say so in the report and send a push notification
  ("reels stalled since <date>") — don't stay silent.
- **Image posts and carousels don't reach anyone yet** (0 reach across ~20 posts). Keep them for profile credibility, but
  any new effort (new specs, new formats) goes to reels first. A carousel reach of 0 means carousels are not an exception.
- Stale reels: when re-dating, put a cards reel first and alternate cards/demo; never place a reel on the same topic as that
  day's feed post (e.g. r8 whatsapp moved off 11-23, the d16 whatsapp post day).

Week to 2026-11-16: 1 follower. 13 image posts across two weeks reached 0 accounts; every account reached came from reels (all non-followers).
- **Reels are the growth channel.** Never skip or delay the 7 PM reel. If a queued reel can't post, re-date it to the next free
  day instead of leaving it stuck in the past (r4 sat unposted for 3 days).
- **Cards beat app demos.** Best reel: r6-cover-blocks (cards tip, reach 23, skip 82%). Worst: r5-pin-a-snag (demo, reach 18,
  skip 100%, avg watch 1.6 s). When making 7 new reels use 4 cards (tips / site pain) + 3 demo instead of 3 demo + 3 cards + 1.
- **The first 3 s are losing almost everyone** (skip 82–100%, avg watch 1.5–2.5 s on 12–20 s reels). For new reels:
  frame 0 must already show the headline (no fade-in, no logo first); demo reels open on the problem as a card for ~1 s
  before the phone appears; aim for 10–14 s; put a number in the hook ("5 checks", "7 days") when the topic allows.
- **Saves, shares, comments and follows are all 0 so far** — keep one clear ask per reel ("Save this", "Tag your site engineer");
  don't stack two asks.
- Order upcoming reels so a cards reel runs before a demo reel when both are queued close together.

## Daily run

1. Work from a clone of this repo (`lucifer3344/plavyn-social`), branch `main`.
2. Open `queue.json`. Take the entry whose `date` is today (IST) and whose `post_media_id` is null.
   - None for today but older entries are unposted? Post the oldest unposted one instead (catch-up, one per day).
   - Queue empty for today and after? Go to "Refilling the queue" first, then post.
3. Check that the images exist in `out/` and are pushed: the public links are
   `https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/<path>`.
   Check each link returns HTTP 200 before posting. If a file is missing, render it:
   `npm i && node render.js content/<id>.json`, commit and push, then check again.
4. Post the story: `create_story` with `image_url` = the story link.
5. Post the feed post: `create_image_post` with `image_url` = the post link and `caption` = the entry's caption, exactly.
   If the entry has `"type": "carousel"`, use `create_carousel_post` with `image_urls` = the links of `slides` (in order) instead.
6. Write both media ids into the entry (`story_media_id`, `post_media_id`), commit
   `Posted <date>: <id>` and push.
7. If a post fails, do not retry more than once. Leave the ids null so tomorrow's run catches up, and report the error.
8. Reply to comments (see "Comments" below), commit `replied.json` with the posting commit.

## Refilling the queue (when fewer than 3 future entries are left)

Make 7 new days in the same style, then add them to `queue.json`:
- One spec per day in `content/<dNN-slug>.json`, same fields as the existing ones
  (`kind`: `device`, `list` or `widgets`; `headline` with `*teal part*` and `\n`; `sub`; `media` crop in source pixels;
  `storyMark: "NEW POST"`, `storyFoot: "NEW ON THE FEED · @PLAVYN_1"`).
- Screens are in `assets/screens/` and `assets/widgets/`. Rotate pillars: product in use (40%), site pain (25%),
  Indian site craft tips (20%), build in public (15%). Don't repeat a screen used in the last 7 days.
- Only claim features shown in the screens or listed in the app description (drawings, compare, measure, pins,
  snags with verified close, RFIs, tasks list/board/schedule, checklists, submittals, team access, diary,
  planner, widgets, Microsoft sign-in, files in OneDrive/Google Drive). Never claim AI features, customers,
  pricing or numbers that aren't in the app.
- Captions: hook line first, 2–4 short sentences, one call to action, 5–8 specific hashtags ending with
  `#plavyn #constructionindia #siteengineer`.
- Render with `node render.js content/<id>.json`, look at every image before queueing it (text must not
  overlap the screen, nothing cut off), commit and push.

## Evening reel run (7 PM IST)

1. Pull `main`. Open `reel_queue.json`. Take the entry whose `date` is today (IST) and whose `media_id` is null
   (none today but older ones unposted → post the oldest; one reel per day).
2. **Fresh footage first:** if `reels/raw/` has a video not yet listed as `raw` in `reels/clips.json`, use it instead of
   the queued reel and leave the queued one for a later day (push its date and later dates back by one):
   - Look at 3–4 frames (`ffmpeg -ss <t> -i <file> -frames:v 1 x.jpg`) to see what it shows; read `reels/raw/notes.txt` if present.
   - Skip (and report) footage that shows faces close up, client names/boards, or anything unsafe on site.
   - Add a spec to `reels/clips.json` (`id: rc<NN>-<slug>`, `raw`, `mark`, `headline` with `<br><span class="t">…</span>`, `end`,
     optional `start`/`max` seconds), run `node reels/clip.js <id>`, look at frames of the output, write a caption, and insert
     the entry for today in `reel_queue.json`.
3. Check the video and cover links return HTTP 200 (`https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/reels/out/<id>.mp4`).
4. Post: `create_video_post` with `video_url`, `cover_url` = the cover link, `caption` exactly, `share_to_feed: true`.
5. Write `media_id`, commit `Reel <date>: <id>`, push. Retry at most once on failure.
6. Reply to comments (below).
7. If fewer than 3 future reels are left, make 7 new ones (see "Making reels"), queue them with captions, commit and push.

### Making reels
- App-screen reels: add an entry to `reels/reels.json` and run `reels/make.sh <id>` (needs `npm i`; writes `reels/out/<id>.mp4`
  and `<id>-cover.jpg`). Two styles:
  - **demo**: `screens` + `finger` taps + `highlights` + `captions` (coordinates in source px of the 1320×2868 screenshot;
    `capTop` moves the caption pill if it covers a highlight). Preview with `node reels/record.js preview 2,5,9 <id>` and look.
  - **cards**: `cards: [{at, title, body}]` — numbered tips/pain points, no phone. Good for site-craft tips and "your site
    runs on WhatsApp if…" style hooks. Bottom line defaults to "Save this · Follow @plavyn_1" (`cta` to change).
- Mix per 7 reels: 3 demo, 3 site tips (cards), 1 site-pain (cards) (changed 2026-11-16, see Learnings). Don't reuse a reel id or repeat a
  reel topic within 14 days. Headline = hook in the first second (a question or a problem, ≤ 7 words). 12–20 s long.
- Reel captions: hook line, 2–3 short sentences, one call to action that asks for a follow, save, comment or tag,
  4–6 specific hashtags ending with `#plavyn #constructionindia #siteengineer`.
- Facts in tips must be standard practice or quoted from a named code (e.g. IS 456); when unsure, leave it out.
- Look at preview frames of every new reel before queueing: text inside the frame, nothing hidden by the caption pill,
  and nothing important in the bottom 400 px (Instagram's caption covers it).

## Weekly carousel
Every Saturday the feed entry is a carousel (`"type": "carousel"`, `slides` = 5–8 post images, `post` = first slide,
`story` = first slide's story). Make slides with `kind: "text"` specs (`headline` like `"*01*\nTitle"`, `sub` = one or two
sentences, `formats: ["post"]`), a cover with formats post+story, and a last slide that shows the relevant app screen
(`kind: "device"`). Topics: checklists people will save (handover snags, pre-pour, waterproofing, monsoon prep…).
When refilling the image queue, make the Saturday day a carousel.

## Comments
- Read comments on our media from the last 14 days (`get_data`, connector `instagram`, fields `comment_id`,
  `comment_text`, `comment_username`, `comment_parent_id`, `media_id`, `comment_timestamp`).
- Reply (`reply_to_comment`) once to each comment from someone else that isn't in `replied.json` and isn't itself a reply
  from us. Keep it short, specific and human: answer the question, thank them, or ask what they use on site.
  Only claim playbook features; for pricing, accounts or bugs say "DM us and we'll help" — never quote prices.
- Skip spam, abuse and bots (record them as skipped). Never hide or delete comments.
- Record every handled comment id in `replied.json` (`{"<comment_id>": "replied" | "skipped"}`).

## Raw clips from Kaushal
Kaushal drops site videos / screen recordings in `reels/raw/` (see its README). Use each once, newest first.

## Brand
Ink #1D1F1F · paper #F3F3F1 · teal #80BCC5 · Inter + Barlow Condensed · blueprint grid · teal datum bar on the left.
Tagline: Every drawing. One version. Everywhere.
