# Plavyn Instagram — daily posting playbook

Account: @plavyn_1 (Windsor.ai connector `instagram`, account id `17841480417097331`).
Every day: 9 AM IST one feed post (Saturdays: a carousel) and one story; 7 PM IST one reel.
Goal: grow followers. Reels reach non-followers; image posts mostly reach existing followers (in Nov 2026 images reached ~0, reels 1–31).

## Learnings (from weekly reports — follow these; the Monday report updates them)
Week to 2026-11-23: still 1 follower. **0 reels posted → total reach 0.** All 7 feed posts (incl. the c01 carousel) reached 0,
for the third week running. Account reach for the whole week: 2.
- **The evening reel run had no scheduled task until 11-23.** Before that only the 9 AM daily-post task existed, so reels only went out when run by hand
  (11-14, 11-15). Re-dated the 5 stuck reels to 11-23..11-27; the "Plavyn evening reel" scheduled task (6:42 PM IST daily) was created on 11-23.
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

## Audience & competition (added 2026-11-23 — follow for all new content)
**Who we're for:** site engineers, project managers and **architects / consultants** on Indian building projects
(residential towers, commercial, interiors), plus developers' project teams. Not DIY homeowners, not heavy-machinery fans,
not generic "construction motivation" audiences — reach from those doesn't turn into app users.

**Competition (checked 2026-11-23):**
- *Powerplay* (India's largest site app, contractor/labour/material focus) runs its Instagram as a community page,
  `@civilengineersdiary` ("Powerplay – Construction app"), posting civil-engineer content rather than product ads. That is the
  bar: engineers follow pages that teach them or speak their site life, not product pages.
- Global apps (Procore, Fieldwire, PlanRadar, Autodesk Construction Cloud) post polished product + jobsite content for US/EU
  audiences; little is India-specific or architect-facing.
- Indian "construction" creators are mostly home-builders, machinery or lifestyle pages — few speak to architects + site teams.

**How we beat them (our lane):**
1. **Drawings and design coordination** is our ground — current drawing vs superseded, RFIs to the consultant, submittals,
   snags pinned on the sheet, measure on the sheet. Powerplay owns labour/material/attendance; don't fight there.
2. **Architect-facing content every week** — at least 2 of 7 reels and 2 of 7 feed posts aimed at architects/consultants
   (e.g. "Site built off an old revision?", "5 things architects check on a site visit", "Answering RFIs without 20 calls",
   "Design intent vs what got built"). Use `#architects` on these.
3. **Teach, then show.** Lead with a site-craft tip or a pain point the viewer recognises in 1 s; the app appears only as the
   last beat. Tips must follow the "Keep it real" rules (code-cited or standard practice).
4. **Better craft than the competition:** headline on frame 0, 10–14 s, one idea per reel, clean brand look, real site clips
   from Kaushal whenever available (they beat any template), reply to every comment within the day.
5. **Built to be sent:** each reel should be something an engineer forwards to their team or their architect — checklists,
   "your site runs on WhatsApp if…", before-pour / before-plaster checks.

**Search keywords (Instagram search reads captions, on-screen text, name and bio):** put one in the first caption line and
the on-screen headline: site engineer, civil engineering, architect, construction drawings, RFI, snag list / punch list,
shop drawings, submittals, concrete / curing / slab / plaster / waterproofing, construction management, site diary.

**Hashtag sets (pick exactly 5; always `#constructionindia`; rotate, don't paste the same 5 every day):**
- Audience: `#siteengineer` `#civilengineering` `#architects` `#projectmanager` `#constructionmanagement`
- Topic: `#concrete` `#curing` `#rcc` `#plastering` `#waterproofing` `#qualitycontrol` `#snagging` `#rfi` `#shopdrawings`
  `#submittals` `#constructiondrawings` `#mep` `#structuralengineering` `#interiorfinishing` `#sitelife`
- Drop `#plavyn` (no one searches it) and generic tags (`#construction`, `#productivity`, `#iphone`, `#kanban`).

**Collab posts:** `create_image_post`, `create_carousel_post` support `collaborators` (≤3 usernames, they must accept). Only use
handles Kaushal lists in a queue entry's `collaborators` (an architect or consultant he works with). A collab carousel with an
architect is the fastest way to reach architects' followers.

**Trial Reels** (`trial_params` on `create_video_post`, shown only to non-followers) need 1,000+ followers — revisit then.

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
5. Post the feed post: `create_image_post` with `image_url` = the post link, `caption` = the entry's caption, exactly, and
   `alt_text` = the entry's `alt_text` if present (for carousels, pass it on the first item via `items`). If the entry has
   `collaborators`, pass them too (only usernames Kaushal added himself — never invite accounts on our own).
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
- Captions: hook line first (with a search keyword, see "Audience & competition"), 2–4 short sentences, one call to
  action, **exactly 5 hashtags** (Instagram's cap since Dec 2025) chosen from the hashtag sets below, always including
  `#constructionindia`. Add an `alt_text` to every new entry (one sentence, what the image shows + audience keywords).
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
3. **Pre-post check:** run `tools/check_reel.sh <id>`. It must print `OK`. It checks the mp4 has an H.264 9:16 video track
   and an *audible* audio track (silent = mean volume below −50 dB fails), the cover exists, both public links return
   HTTP 200, and the queue entry has a caption. If it fails, fix it (e.g. a silent raw clip: mix in a sound bed built with
   `reels/audio.py`'s pad, re-run `clip.js`) or post the next queued reel instead and report why. Never post a silent reel.
4. Post: `create_video_post` with `video_url`, `cover_url` = the cover link, `caption` exactly as in the queue,
   `share_to_feed: true` (always — it puts the reel on the profile grid as well as the Reels tab).
5. **Post-post check** (wait ~1 min, then `get_data`, connector `instagram`, fields `media_id`, `media_type`,
   `media_product_type`, `media_caption`, `media_url`, `media_thumbnail_url`, `media_permalink`, filtered to the new media_id
   over the last 2 days). Confirm: `media_type` = REELS, `media_url` is an mp4, `media_thumbnail_url` is set (cover attached),
   `media_caption` equals the queued caption exactly (hashtags included), and there is a permalink. The API does not report
   share-to-feed, so confirm the action was sent with `share_to_feed: true` and say so in the report. If any check fails,
   report it and send a push notification with the permalink — never delete the post to "fix" it.
6. Write `media_id` (and `permalink`), commit `Reel <date>: <id>`, push. Retry posting at most once on failure.
7. Reply to comments (below).
8. If fewer than 3 future reels are left, make 7 new ones (see "Making reels"), queue them with captions, commit and push.

### Making reels
- App-screen reels: add an entry to `reels/reels.json` and run `reels/make.sh <id>` (needs `npm i`; writes `reels/out/<id>.mp4`
  and `<id>-cover.jpg`). Two styles:
  - **demo**: `screens` + `finger` taps + `highlights` + `captions` (coordinates in source px of the 1320×2868 screenshot;
    `capTop` moves the caption pill if it covers a highlight). Preview with `node reels/record.js preview 2,5,9 <id>` and look.
  - **cards**: `cards: [{at, title, body}]` — numbered tips/pain points, no phone. Good for site-craft tips and "your site
    runs on WhatsApp if…" style hooks. Bottom line defaults to "Save this · Follow @plavyn_1" (`cta` to change).
- Mix per 7 reels: 3 demo, 3 site tips (cards), 1 site-pain (cards) (changed 2026-11-16, see Learnings); at least 2 of the 7
  aimed at architects/consultants (see "Audience & competition"). Don't reuse a reel id or repeat a
  reel topic within 14 days. Headline = hook in the first second (a question or a problem, ≤ 7 words). 12–20 s long.
- Reel captions: hook line with a search keyword, 2–3 short sentences, one call to action — prefer a **send** ask
  ("Send this to your site engineer / architect") since sends are Instagram's strongest non-follower signal; otherwise save,
  comment or tag. **Exactly 5 hashtags** from the sets below, always including `#constructionindia` (check_reel.sh fails >5).
- **Keep it real (honest content).** Every reel must be true to the app and to site practice:
  - Demo reels use only real app screenshots from `assets/screens/` / `assets/widgets/` — no mocked or edited UI, no features
    the app doesn't have, no fake data that looks like a real client or project.
  - No invented numbers, stats, results, customers, testimonials, "trusted by…", downloads or ratings. No AI features. No prices.
  - No stock footage, AI-generated site images, or footage that isn't Kaushal's own; raw clips are captioned only with what
    the clip actually shows (no implying it's a client's site unless notes.txt says so).
  - Site tips: standard practice or a named code clause; say "follow your spec / consultant" where practice varies.
  - Don't overpromise in CTAs (e.g. "a tip every day" only while a reel really posts daily).
  - If a queued reel breaks any of these, don't post it: skip to the next, and report what's wrong (fixing a caption error is allowed).
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
