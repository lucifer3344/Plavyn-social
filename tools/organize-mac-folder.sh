set -e
cd "$HOME/mnt/plavyn-site/instagram"
mkdir -p profile 2026-11-06/stories 2026-11-06/reels
for f in avatar.jpg hl-checks.jpg hl-drawings.jpg hl-snags.jpg hl-updates.jpg hl-widgets.jpg; do [ -f "$f" ] && mv "$f" profile/; done
[ -f captions.md ] && mv captions.md 2026-11-06/captions.md
curl -sf -o 2026-11-06/01-post-brand-intro.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/posts/2026-11-launch/p1.jpg
curl -sf -o 2026-11-06/02-post-snag-signoff.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/posts/2026-11-launch/p2.jpg
curl -sf -o 2026-11-06/03-post-widgets.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/posts/2026-11-launch/p3.jpg
curl -sf -o 2026-11-06/stories/01-story-drawings.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/h-drawings-story.jpg
curl -sf -o 2026-11-06/stories/02-story-snags.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/h-snags-story.jpg
curl -sf -o 2026-11-06/stories/03-story-checklists.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/h-checklists-story.jpg
curl -sf -o 2026-11-06/stories/04-story-widgets.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/h-widgets-story.jpg
curl -sf -o 2026-11-06/stories/05-story-updates.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/h-updates-story.jpg
curl -sf -o 2026-11-06/reels/01-reel-snag-signoff.mp4 https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/reels/out/r1-snag-signoff.mp4
curl -sf -o 2026-11-06/reels/02-reel-check-to-snag.mp4 https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/reels/out/r2-check-to-snag.mp4
curl -sf -o 2026-11-06/reels/03-reel-tasks-three-views.mp4 https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/reels/out/r3-tasks-three-views.mp4
printf %s '

## Reels (posted 6 Nov)

- 01-reel-snag-signoff.mp4 — Nothing closes until it'"'"'s fixed.
- 02-reel-check-to-snag.mp4 — A failed check becomes a snag.
- 03-reel-tasks-three-views.mp4 — One task list. Three ways to see it.
- Stories: the five highlight stories in stories/
' >> 2026-11-06/captions.md
mkdir -p 2026-11-07
curl -sf -o 2026-11-07/post-current-drawing.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d01-current-drawing-post.jpg
curl -sf -o 2026-11-07/story-current-drawing.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d01-current-drawing-story.jpg
printf %s '"Which drawing is current?" is the most expensive question on site.

In Plavyn, every revision of a sheet lives in one place and the current one always opens first, with its status beside it: sent for approval, or IFC. Nobody builds off last week'"'"'s print.

How does your site share revisions today? WhatsApp, email or a shared drive? Tell us below.

#plavyn #constructionindia #siteengineer #constructiondrawings #architecture #revisioncontrol
' > 2026-11-07/caption.txt
mkdir -p 2026-11-08
curl -sf -o 2026-11-08/post-pre-pour.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d02-pre-pour-post.jpg
curl -sf -o 2026-11-08/story-pre-pour.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d02-pre-pour-story.jpg
printf %s 'Before you pour: 6 checks.

This is the pre-pour checklist that comes with Plavyn. Mark each item Pass, Fail or N/A on your phone. A failed check becomes a snag in one tap, with the location and the person responsible.

Save this for your next slab.

#plavyn #constructionindia #siteengineer #rcc #concrete #qualitycontrol #slabcasting
' > 2026-11-08/caption.txt
mkdir -p 2026-11-09
curl -sf -o 2026-11-09/post-tasks-three-views.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d03-tasks-three-views-post.jpg
curl -sf -o 2026-11-09/story-tasks-three-views.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d03-tasks-three-views-story.jpg
printf %s 'One task list. Three ways to see it.

The site engineer works in the List. The PM drags cards across the Board. The director checks the Schedule. Same tasks, same owners, same due dates, on iPad and iPhone.

Which view would your team live in?

#plavyn #constructionindia #siteengineer #projectmanagement #constructionmanagement #ipad
' > 2026-11-09/caption.txt
mkdir -p 2026-11-10
curl -sf -o 2026-11-10/post-rfis.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d04-rfis-post.jpg
curl -sf -o 2026-11-10/story-rfis.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d04-rfis-story.jpg
printf %s 'Ask once. Answer on record.

An RFI asked on a phone call is forgotten by Friday. In Plavyn every request for information has a number, the person it'"'"'s waiting on, and the answer attached, so the next person on site can see what was decided and why.

#plavyn #constructionindia #siteengineer #rfi #structuralengineering #constructionmanagement
' > 2026-11-10/caption.txt
mkdir -p 2026-11-11
curl -sf -o 2026-11-11/post-fire-noc.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d05-fire-noc-post.jpg
curl -sf -o 2026-11-11/story-fire-noc.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d05-fire-noc-story.jpg
printf %s 'Fire NOC walkthrough: be ready.

Six things worth checking before the fire officer arrives. Requirements vary by authority and building type, so always work from your consultant'"'"'s list too.

In Plavyn, put each item on a checklist or a task with an owner and a due date, so nothing is left for the morning of the inspection.

Save this.

#plavyn #constructionindia #siteengineer #firesafety #firenoc #mumbaiconstruction
' > 2026-11-11/caption.txt
mkdir -p 2026-11-12
curl -sf -o 2026-11-12/post-diary.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d06-diary-post.jpg
curl -sf -o 2026-11-12/story-diary.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d06-diary-story.jpg
printf %s 'The site diary, kept every day.

Slab poured, consultant visited, ponding test passed, 42 labourers on site. In Plavyn the diary sits with the project, typed or written with Apple Pencil, and you can search it months later when someone asks "when did we cast that slab?"

#plavyn #constructionindia #siteengineer #sitediary #dailyreport #constructionlife
' > 2026-11-12/caption.txt
mkdir -p 2026-11-13
curl -sf -o 2026-11-13/post-submittals.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d07-submittals-post.jpg
curl -sf -o 2026-11-13/story-submittals.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d07-submittals-story.jpg
printf %s 'Shop drawings, to a decision.

Waterproofing method statements, façade glass samples, rebar shop drawings: each submittal in Plavyn shows who it'"'"'s with, when the review is due, and the decision: approved, approved as noted, or revise and resubmit.

#plavyn #constructionindia #siteengineer #submittals #shopdrawings #facade
' > 2026-11-13/caption.txt
mkdir -p 2026-11-14
curl -sf -o 2026-11-14/post-ponding-test.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d08-ponding-test-post.jpg
curl -sf -o 2026-11-14/story-ponding-test.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d08-ponding-test-story.jpg
printf %s 'Waterproofing: the 48-hour ponding test.

A terrace that leaks after handover costs far more than two days of testing. Follow your applicator'"'"'s method statement for depth and duration, and record the result so nobody has to argue about it later.

In Plavyn, a failed test becomes a snag pinned to the exact spot on the drawing.

#plavyn #constructionindia #siteengineer #waterproofing #terrace #qualitycontrol
' > 2026-11-14/caption.txt
mkdir -p 2026-11-15
curl -sf -o 2026-11-15/post-team.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d09-team-post.jpg
curl -sf -o 2026-11-15/story-team.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d09-team-story.jpg
printf %s 'Everyone on the project. The right access for each.

Developer, architect, structural, MEP, contractor. Invite them all to the project in Plavyn, assign work to anyone, and keep a contractor to the wings they'"'"'re working on.

Files stay in your team'"'"'s own OneDrive or Google Drive.

#plavyn #constructionindia #siteengineer #teamwork #constructionmanagement #architects
' > 2026-11-15/caption.txt
mkdir -p 2026-11-16
curl -sf -o 2026-11-16/post-planner.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d10-planner-post.jpg
curl -sf -o 2026-11-16/story-planner.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d10-planner-story.jpg
printf %s 'Phases and progress, against the plan.

Foundation and basement, podium, typical floor slabs, façade, MEP, finishes and handover. Plavyn'"'"'s Planner shows every phase against the original plan, so a slip is visible the week it happens, not the month after.

#plavyn #constructionindia #siteengineer #projectplanning #construction #realestateindia
' > 2026-11-16/caption.txt
mkdir -p 2026-11-17
curl -sf -o 2026-11-17/post-snag-owner.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d11-snag-owner-post.jpg
curl -sf -o 2026-11-17/story-snag-owner.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d11-snag-owner-story.jpg
printf %s 'Every snag has an owner and a date.

Fire door gap, cracked tile, waterproofing patch, misaligned switch box. In Plavyn each one is logged with a photo, assigned to one person, given a due date, and closed only when it'"'"'s verified.

No more snag lists in Excel that nobody updates.

#plavyn #constructionindia #siteengineer #snaglist #punchlist #handover
' > 2026-11-17/caption.txt
mkdir -p 2026-11-18
curl -sf -o 2026-11-18/post-pin-on-drawing.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d12-pin-on-drawing-post.jpg
curl -sf -o 2026-11-18/story-pin-on-drawing.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d12-pin-on-drawing-story.jpg
printf %s 'Mark the exact spot. On the drawing.

"Near the lift lobby, second floor" leaves room for argument. In Plavyn you tap the point on the drawing and log a snag or raise an RFI right there, so whoever fixes it knows exactly where to go.

#plavyn #constructionindia #siteengineer #constructiondrawings #snagging #architecture
' > 2026-11-18/caption.txt
mkdir -p 2026-11-19
curl -sf -o 2026-11-19/post-my-day.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d13-my-day-post.jpg
curl -sf -o 2026-11-19/story-my-day.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d13-my-day-story.jpg
printf %s 'Your day, before you unlock.

Plavyn'"'"'s My Day widget shows what'"'"'s yours today and what'"'"'s overdue. Site Day adds the weather on site and a one-tap shortcut to write the diary.

Available on the Home Screen and Lock Screen.

#plavyn #constructionindia #siteengineer #ioswidgets #productivity #projectmanager
' > 2026-11-19/caption.txt
mkdir -p 2026-11-20
curl -sf -o 2026-11-20/post-measure.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d14-measure-post.jpg
curl -sf -o 2026-11-20/story-measure.jpg https://raw.githubusercontent.com/lucifer3344/plavyn-social/main/out/d14-measure-story.jpg
printf %s 'Measure on the sheet. Feet-inches or metric.

Type one real length to set the scale, then measure anything on the drawing, right on site. No scale rule, no printout.

Which do you work in: metres or feet-inches?

#plavyn #constructionindia #siteengineer #architecture #construction #measure
' > 2026-11-20/caption.txt
printf %s '# Plavyn Instagram — by date

One folder per posting day. Each future day holds the feed post, the story and the caption that the daily 9 AM run publishes. Profile picture and highlight covers are in profile/.

| Date | Folder contents | Status |
| --- | --- | --- |
| 6 Nov 2026 | 3 launch posts, 5 highlight stories, 3 reels | Posted |
| 2026-11-07 | post-current-drawing.jpg, story-current-drawing.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-08 | post-pre-pour.jpg, story-pre-pour.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-09 | post-tasks-three-views.jpg, story-tasks-three-views.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-10 | post-rfis.jpg, story-rfis.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-11 | post-fire-noc.jpg, story-fire-noc.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-12 | post-diary.jpg, story-diary.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-13 | post-submittals.jpg, story-submittals.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-14 | post-ponding-test.jpg, story-ponding-test.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-15 | post-team.jpg, story-team.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-16 | post-planner.jpg, story-planner.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-17 | post-snag-owner.jpg, story-snag-owner.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-18 | post-pin-on-drawing.jpg, story-pin-on-drawing.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-19 | post-my-day.jpg, story-my-day.jpg, caption.txt | Scheduled, 9 AM |
| 2026-11-20 | post-measure.jpg, story-measure.jpg, caption.txt | Scheduled, 9 AM |
' > README.md
find . -type f | sort | sed "s|^./||"