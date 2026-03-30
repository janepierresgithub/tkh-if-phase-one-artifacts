# Night 1 TA Field Notes
## TKH Innovation Fellowship — Phase 1, Week 1, Session 01
**Session:** T1-M1-S01 Terminal Genesis
**Date:** March 9, 2026
**TA:** Jane G. Pierre

---

## Pre-Class Dry Run Results

Ran the session bootstrap script via curl before class:
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

Result: 100 levels built, flag confirmed in `level_42`. Environment ready for class.

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

Two realistic student navigation paths:

**Path 1 — Manual navigation**
```bash
cd level_1 && ls && cd ..
cd level_2 && ls && cd ..
# repeated across levels
```
Builds foundational `cd` and `ls` muscle memory through repetition.

**Path 2 — Search command**
```bash
find ~/maze -name "*.txt"
```
Returns the exact path instantly. Demonstrates the power of `find` for students
who explore beyond the minimum command set — a natural reward for curiosity.

Created and pushed `discovery.txt` to student practice repo per assignment instructions.

---

## TA Observations — Live Support Notes

- **Password invisibility warning is critical.** Adult learners panic when they
  type their sudo password and see nothing. Reinforce this before the bootstrap
  curl command is run.

- **Tab completion must be drilled early.** Students who don't use Tab by the
  end of Night 1 will struggle with longer paths in Nights 2 and 3.

- **`cd ~` is the universal reset.** Remind students early and often. If lost,
  type `cd ~` and start over. No harm done.

- **The gamified maze structure is highly effective for first-night engagement.**
  The level_42 Easter egg rewards students familiar with hacker culture while
  remaining invisible to those who aren't — a clean design choice that serves
  both audiences simultaneously.

---

## Scripts Referenced

| Script | Location | Purpose |
|---|---|---|
| `setup_lab_01_george.sh` | `week-01/scripts/` | Session bootstrap — used live in class |
| `setup_lab_01_jane.sh` | `week-01/scripts/` | TA supplemental implementation |
| `ta_analysis_s01.md` | `week-01/docs/` | Side-by-side analysis |

---

*These notes are for TA reference and portfolio documentation.*
