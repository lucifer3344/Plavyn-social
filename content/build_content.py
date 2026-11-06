"""Writes content/<id>.json specs and queue.json for the first two weeks.
Run once from the repo root: python3 content/build_content.py
Later runs add new specs and queue entries by hand (see PLAYBOOK.md)."""
import json, os, datetime

S = "assets/screens/"
W = "assets/widgets/"
TAGS = "#plavyn #constructionindia #siteengineer"

highlights = [
    dict(id="h-drawings", kind="device", formats=["story"], storyMark="HIGHLIGHT · DRAWINGS",
         headline="Every sheet.\n*The current one.*",
         sub="Drawing sets by floor, every revision kept together, the latest always on top.",
         media=dict(img=S+"03-drawings.png", y0=0, y1=1150, width=820)),
    dict(id="h-snags", kind="device", formats=["story"], storyMark="HIGHLIGHT · SNAGS",
         headline="Nothing closes\n*until it's fixed.*",
         sub="The person who raised the snag verifies the fix. Not fixed? It reopens.",
         media=dict(img=S+"16-snag-signoff.png", y0=930, width=760)),
    dict(id="h-checklists", kind="device", formats=["story"], storyMark="HIGHLIGHT · CHECKLISTS",
         headline="Pass. Fail. N/A.\n*Then a snag.*",
         sub="Pre-pour, waterproofing, fire safety and handover checklists. A failed check raises a snag in one tap.",
         media=dict(img=S+"checklist-detail-prepour.png", y0=150, width=760)),
    dict(id="h-widgets", kind="widgets", formats=["story"], storyMark="HIGHLIGHT · WIDGETS",
         headline="Your site,\n*at a glance.*",
         sub="Snags to verify, failed checks and what's due next, on your Home Screen.",
         media=[dict(img=W+"08-project-summary-large.png", x0=72, x1=1086, y0=72, y1=1134, width=820, radius=52)]),
    dict(id="h-updates", kind="list", formats=["story"], storyMark="HIGHLIGHT · UPDATES",
         headline="What's new\n*in Plavyn.*",
         sub="The latest release, in short.",
         items=["Home Screen and Lock Screen widgets",
                "Sign in with your Microsoft account",
                "One tap to log a snag or a task",
                "Compare two revisions in Overlay or Slide view",
                "Measure on the sheet in feet-inches or metric"]),
]

days = [
    dict(id="d01-current-drawing", kind="device", mark="DRAWINGS · REV C",
         headline="Which drawing\nis current?\n*The one on top.*", headlineSize=96,
         sub="Every revision stays together. The current one opens first, marked with its status.",
         media=dict(img=S+"03-drawings.png", y0=0, y1=1150, width=820),
         caption="\"Which drawing is current?\" is the most expensive question on site.\n\nIn Plavyn, every revision of a sheet lives in one place and the current one always opens first, with its status beside it: sent for approval, or IFC. Nobody builds off last week's print.\n\nHow does your site share revisions today? WhatsApp, email or a shared drive? Tell us below.\n\n" + TAGS + " #constructiondrawings #architecture #revisioncontrol"),
    dict(id="d02-pre-pour", kind="list", mark="CHECKLIST · PRE-POUR",
         headline="Before you pour:\n*6 checks.*",
         items=["Shuttering aligned, level and braced",
                "Reinforcement matches the drawing: bar size, spacing, laps",
                "Cover blocks in place",
                "Conduits, sleeves and inserts fixed",
                "Shuttering clean, no debris or standing water",
                "Concrete grade and slump match the batching ticket"],
         caption="Before you pour: 6 checks.\n\nThis is the pre-pour checklist that comes with Plavyn. Mark each item Pass, Fail or N/A on your phone. A failed check becomes a snag in one tap, with the location and the person responsible.\n\nSave this for your next slab.\n\n" + TAGS + " #rcc #concrete #qualitycontrol #slabcasting"),
    dict(id="d03-tasks-three-views", kind="device", mark="TASKS · iPAD",
         headline="One task list.\n*Three ways to see it.*", headlineSize=96,
         sub="List, Board and Schedule views of the same tasks, shared with the whole team.",
         media=dict(img=S+"ipad-tasks-board.png", x0=0, x1=1900, y0=0, y1=1350, width=900, radius=36),
         caption="One task list. Three ways to see it.\n\nThe site engineer works in the List. The PM drags cards across the Board. The director checks the Schedule. Same tasks, same owners, same due dates, on iPad and iPhone.\n\nWhich view would your team live in?\n\n" + TAGS + " #projectmanagement #constructionmanagement #ipad"),
    dict(id="d04-rfis", kind="device", mark="SITE · RFIs",
         headline="Ask once.\n*Answer on record.*",
         sub="Raise an RFI, send it to the consultant, and track it until it's answered.",
         media=dict(img=S+"05-rfis.png", y0=0, y1=1300, width=820),
         caption="Ask once. Answer on record.\n\nAn RFI asked on a phone call is forgotten by Friday. In Plavyn every request for information has a number, the person it's waiting on, and the answer attached, so the next person on site can see what was decided and why.\n\n" + TAGS + " #rfi #structuralengineering #constructionmanagement"),
    dict(id="d05-fire-noc", kind="list", mark="FIRE NOC · WALKTHROUGH",
         headline="Fire NOC walkthrough:\n*be ready.*", headlineSize=92,
         items=["Fire doors self-close and latch",
                "Refuge floor clear and signed",
                "Staircases and exits free of material",
                "Hydrant, sprinkler and riser test records on hand",
                "Exit signs and emergency lighting working",
                "Fire lift and its switch tested"],
         caption="Fire NOC walkthrough: be ready.\n\nSix things worth checking before the fire officer arrives. Requirements vary by authority and building type, so always work from your consultant's list too.\n\nIn Plavyn, put each item on a checklist or a task with an owner and a due date, so nothing is left for the morning of the inspection.\n\nSave this.\n\n" + TAGS + " #firesafety #firenoc #mumbaiconstruction"),
    dict(id="d06-diary", kind="device", mark="DIARY · DAILY",
         headline="The site diary,\n*kept every day.*",
         sub="What was poured, who visited, what was inspected. Typed or handwritten, and searchable later.",
         media=dict(img=S+"12-diary.png", y0=0, width=720),
         caption="The site diary, kept every day.\n\nSlab poured, consultant visited, ponding test passed, 42 labourers on site. In Plavyn the diary sits with the project, typed or written with Apple Pencil, and you can search it months later when someone asks \"when did we cast that slab?\"\n\n" + TAGS + " #sitediary #dailyreport #constructionlife"),
    dict(id="d07-submittals", kind="device", mark="SITE · SUBMITTALS",
         headline="Shop drawings,\n*to a decision.*",
         sub="Follow every submittal, sample and method statement from sent to approved.",
         media=dict(img=S+"10-submittals.png", y0=0, y1=1720, width=760),
         caption="Shop drawings, to a decision.\n\nWaterproofing method statements, façade glass samples, rebar shop drawings: each submittal in Plavyn shows who it's with, when the review is due, and the decision: approved, approved as noted, or revise and resubmit.\n\n" + TAGS + " #submittals #shopdrawings #facade"),
    dict(id="d08-ponding-test", kind="list", mark="WATERPROOFING · TERRACE",
         headline="Waterproofing:\n*the 48-hour\nponding test.*", headlineSize=96,
         items=["Plug the drain outlets",
                "Flood the area to a marked depth",
                "Leave it for 48 hours",
                "Check the mark and the ceiling below",
                "Record the result with photos",
                "Failed? Raise a snag on the spot"],
         caption="Waterproofing: the 48-hour ponding test.\n\nA terrace that leaks after handover costs far more than two days of testing. Follow your applicator's method statement for depth and duration, and record the result so nobody has to argue about it later.\n\nIn Plavyn, a failed test becomes a snag pinned to the exact spot on the drawing.\n\n" + TAGS + " #waterproofing #terrace #qualitycontrol"),
    dict(id="d09-team", kind="device", mark="TEAM · ACCESS",
         headline="Everyone on the project.\n*The right access for each.*", headlineSize=76,
         sub="Invite your team and consultants, assign work to anyone, and limit a contractor to specific wings.",
         media=dict(img=S+"11-team.png", y0=0, width=720),
         caption="Everyone on the project. The right access for each.\n\nDeveloper, architect, structural, MEP, contractor. Invite them all to the project in Plavyn, assign work to anyone, and keep a contractor to the wings they're working on.\n\nFiles stay in your team's own OneDrive or Google Drive.\n\n" + TAGS + " #teamwork #constructionmanagement #architects"),
    dict(id="d10-planner", kind="device", mark="PLANNER · PHASES",
         headline="Phases and progress,\n*against the plan.*", headlineSize=84,
         sub="Foundations to handover, with an owner for every phase.",
         media=dict(img=S+"ipad-planner.png", x0=0, x1=2000, y0=0, y1=1100, width=900, radius=36),
         caption="Phases and progress, against the plan.\n\nFoundation and basement, podium, typical floor slabs, façade, MEP, finishes and handover. Plavyn's Planner shows every phase against the original plan, so a slip is visible the week it happens, not the month after.\n\n" + TAGS + " #projectplanning #construction #realestateindia"),
    dict(id="d11-snag-owner", kind="device", mark="SITE · SNAGS",
         headline="Every snag has\n*an owner and a date.*", headlineSize=96,
         sub="Logged with a photo, assigned to one person, and tracked until it's verified.",
         media=dict(img=S+"04-snags.png", y0=0, y1=1450, width=760),
         caption="Every snag has an owner and a date.\n\nFire door gap, cracked tile, waterproofing patch, misaligned switch box. In Plavyn each one is logged with a photo, assigned to one person, given a due date, and closed only when it's verified.\n\nNo more snag lists in Excel that nobody updates.\n\n" + TAGS + " #snaglist #punchlist #handover"),
    dict(id="d12-pin-on-drawing", kind="device", mark="DRAWINGS · PINS",
         headline="Mark the exact spot.\n*On the drawing.*", headlineSize=96,
         sub="Tap a point on the sheet to log a snag or raise an RFI right where the problem is.",
         media=dict(img=S+"pin-chooser.png", y0=60, y1=1990, width=640),
         caption="Mark the exact spot. On the drawing.\n\n\"Near the lift lobby, second floor\" leaves room for argument. In Plavyn you tap the point on the drawing and log a snag or raise an RFI right there, so whoever fixes it knows exactly where to go.\n\n" + TAGS + " #constructiondrawings #snagging #architecture"),
    dict(id="d13-my-day", kind="widgets", mark="WIDGETS · MY DAY",
         headline="Your day,\n*before you unlock.*",
         sub="What's yours today, and the weather on site, right on your Home Screen.",
         media=[dict(img=W+"02-my-day-medium.png", x0=72, x1=1086, y0=72, y1=546, width=840, radius=54),
                dict(img=W+"11-site-day-medium.png", x0=72, x1=1086, y0=72, y1=546, width=840, radius=54)],
         caption="Your day, before you unlock.\n\nPlavyn's My Day widget shows what's yours today and what's overdue. Site Day adds the weather on site and a one-tap shortcut to write the diary.\n\nAvailable on the Home Screen and Lock Screen.\n\n" + TAGS + " #ioswidgets #productivity #projectmanager"),
    dict(id="d14-measure", kind="device", mark="DRAWINGS · MEASURE",
         headline="Measure on the sheet.\n*Feet-inches or metric.*", headlineSize=80,
         sub="Set the scale by typing one real length, then measure anything on the drawing.",
         media=dict(img=S+"measure.png", y0=150, y1=2760, width=600),
         caption="Measure on the sheet. Feet-inches or metric.\n\nType one real length to set the scale, then measure anything on the drawing, right on site. No scale rule, no printout.\n\nWhich do you work in: metres or feet-inches?\n\n" + TAGS + " #architecture #construction #measure"),
]

STORY_FOOT = "NEW ON THE FEED · @PLAVYN_1"
os.makedirs("content", exist_ok=True)
for s in highlights:
    json.dump(s, open(f"content/{s['id']}.json", "w"), indent=2)
queue = []
start = datetime.date(2026, 11, 7)
for i, s in enumerate(days):
    s = dict(s)
    caption = s.pop("caption")
    s["storyMark"] = "NEW POST"
    s["storyFoot"] = STORY_FOOT
    json.dump(s, open(f"content/{s['id']}.json", "w"), indent=2)
    queue.append(dict(date=str(start + datetime.timedelta(days=i)), id=s["id"],
                      post=f"out/{s['id']}-post.jpg", story=f"out/{s['id']}-story.jpg",
                      caption=caption, post_media_id=None, story_media_id=None))
json.dump(queue, open("queue.json", "w"), indent=2, ensure_ascii=False)
print(len(highlights), "highlight specs,", len(queue), "queued days")
