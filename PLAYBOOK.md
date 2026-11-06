# Plavyn Instagram — daily posting playbook

Account: @plavyn_1 (Windsor.ai connector `instagram`, account id `17841480417097331`).
Every day at 9 AM IST: one feed post and one story.

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
6. Write both media ids into the entry (`story_media_id`, `post_media_id`), commit
   `Posted <date>: <id>` and push.
7. If a post fails, do not retry more than once. Leave the ids null so tomorrow's run catches up, and report the error.

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

## Brand
Ink #1D1F1F · paper #F3F3F1 · teal #80BCC5 · Inter + Barlow Condensed · blueprint grid · teal datum bar on the left.
Tagline: Every drawing. One version. Everywhere.
