# Night 1 TA Field Notes
## TKH Innovation Fellowship — Phase 1, Week 1, Session 01
**Session:** T1-M1-S01 Terminal Genesis
**Date:** March 9, 2026
**TA:** Jane G. Pierre

---

## Pre-Class Dry Run Results

Ran the official bootstrap script via curl before class:
```bash
curl -s https://gist.github.com/grobbins-cell/126d5c64f5f071ae950cc18c09b391fa | bash
```

Output confirmed:
- `[*] Provisioning Session 01: Terminal Genesis...`
- `[*] Constructing the maze...`
- `[*] Environment Ready. Welcome to the Terminal.`

Verified with:
```bash
ls -la ~/maze | head -20
cat ~/maze/level_42/flag.txt
```

Result: 100 levels built, flag confirmed in `level_42`. Script is production ready.

---
## Student Experience Walkthrough

Completed the lab as a student would, using only Night 1 commands:
```bash
pwd                          # Confirmed location: /home/jane
ls                           # Saw maze directory in home
cd maze                      # Entered the maze
ls                           # 100 levels visible
find ~/maze -name "*.txt"    # Located flag instantly
cat level_42/flag.txt        # Read the flag
```

Flag contents:
`MISSION ACCOMPLISHED: +10 XP. You have learned to see in the dark.`

Created and pushed `discovery.txt` to student practice repo per assignment instructions.

---
## Gap Identified — Student Navigation Instructions

**Observation:** The lab currently does not tell students *how* to find the flag
inside the maze. With 100 levels, a pure beginner using only `cd` and `ls` would
need to check each folder manually — a tedious and discouraging experience for a
first night.

**Two realistic student paths:**

### Path 1 — Brute Force (Beginner)
```bash
cd level_1
ls
cd ..
cd level_2
ls
cd ..
# ...repeated up to 100 times
```
Builds muscle memory but risks frustration and disengagement on Night 1.

### Path 2 — Smart Search (Recommended)
```bash
find ~/maze -name "*.txt"
```
Returns the exact path instantly. Introduces the `find` command organically
and rewards students who explore beyond the minimum command set.

**Recommendation for George:** Consider adding a hint in the lab instructions
that nudges students toward `find` after they've attempted manual navigation
for a few levels. This preserves the struggle while preventing full frustration.

---
## TA Observations & Recommendations

- **Password invisibility warning is critical.** Adult learners panic when they
  type their sudo password and see nothing. Reinforce this before the bootstrap
  curl command is run.

- **Tab completion must be drilled early.** Students who don't use Tab by the
  end of Night 1 will struggle with longer paths in Nights 2 and 3.

- **`cd ~` is the universal reset.** Remind students early and often. If lost,
  type `cd ~` and start over. No harm done.

- **George's maze is pedagogically strong.** The gamified structure and level_42
  Easter egg are effective for first-night engagement. The gap identified above
  is minor and easily addressed with one line of additional instruction.

---

## Scripts Referenced

| Script | Location | Purpose |
|---|---|---|
| `setup_lab_01_george.sh` | `week-01/scripts/` | Official student-facing bootstrap |
| `setup_lab_01_jane.sh` | `week-01/scripts/` | TA reference implementation |
| `comparison_night1.md` | `week-01/docs/` | Side-by-side analysis |

---

*These notes are for TA reference only and are not shared with students.*
