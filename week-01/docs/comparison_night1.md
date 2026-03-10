# Night 1 Bootstrap Script Comparison
## TKH Innovation Fellowship — Phase 1, Week 1, Session 01
**Date:** March 9, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Two bootstrap scripts were developed for Night 1: Terminal Genesis. The official
instructor script was authored by Lead Instructor George Robbins. A separate TA
reference implementation was independently developed before access to instructor
materials was granted. Both scripts successfully provision a Night 1 lab environment
and achieve the same core learning objectives.

---
## Side-by-Side Comparison

| Feature | George's Version | Jane's Version |
|---|---|---|
| **Lab Structure** | 100-folder maze (`~/maze/level_1` to `level_100`) | `/opt/alpha/` + `/var/tmp/.mission_cache/` |
| **Hidden Artifact** | `flag.txt` in `maze/level_42` | `intel.txt` in `.mission_cache` |
| **Student Objective** | Navigate maze, find flag | Locate 3 artifacts, log absolute paths |
| **Verification Suite** | None (minimal output) | Full 5-point environment check |
| **GitHub CLI Install** | Silent install if missing | Silent install with version confirmation |
| **git Install** | Not included | Included as failsafe |
| **Error Handling** | Standard | `set -e` exits on any failure |
| **Tone** | Gamified ("Welcome to the Terminal") | Operational ("Good luck, operator") |
| **Best Used For** | Student-facing Night 1 lab | TA dry-run and reference |

---
## Pedagogical Analysis

### George's Approach — Optimized for Student Engagement

The instructor script prioritizes first-night confidence building. The 100-folder
maze is a deliberate pedagogical choice: it gives students a clear, achievable
objective (find the flag) using exactly the commands taught in Phase 1 — cd, ls,
and absolute vs. relative paths. The level_42 placement is a classic hacker culture
reference that rewards curious students who know the joke, while remaining invisible
to those who don't.

This aligns with research on motivation in adult learning: when learners can see a
clear path to a concrete goal, engagement and retention both increase (Ambrose et
al., 2010). The gamified structure lowers the psychological barrier of the CLI for
career-changers encountering a headless terminal for the first time.

### Jane's Approach — Optimized for Real-World Fidelity

The TA reference implementation mirrors directory structures found in actual Linux
production environments. /opt/alpha follows the FHS convention for optional
third-party software, and /var/tmp is a real system directory students will
encounter in security operations. The three-artifact discovery task maps directly
to the kind of reconnaissance a junior analyst performs when first accessing an
unfamiliar system.

The full verification suite reflects the "trust but verify" principle central to
security operations. Validating system state after any configuration change is a
foundational sysadmin discipline — making it visible in the bootstrap script itself
is an intentional teaching moment for the TA context (Chapple et al., 2021).

---
## Which Script Gets Used When

| Context | Script |
|---|---|
| **Live class — student VM provisioning** | George's (`setup_lab_01_george.sh`) |
| **TA dry-run before class** | Jane's (`setup_lab_01_jane.sh`) |
| **TA portfolio reference** | Both |
| **Student portfolio push artifact** | Output of George's (the flag) |

---

## Key Takeaway

These scripts are complementary, not competing. George's version is the right tool
for the classroom — it is clean, fast, and pedagogically intentional. Jane's version
documents the TA's independent understanding of the same objectives and serves as a
reference for environment validation. Having both in this repository demonstrates
the TA's ability to read instructor intent, build on it independently, and document
the relationship between the two implementations clearly.

---

## References

Ambrose, S. A., Bridges, M. W., DiPietro, M., Lovett, M. C., & Norman, M. K. (2010).
*How learning works: Seven research-based principles for smart teaching.* Jossey-Bass.

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.
