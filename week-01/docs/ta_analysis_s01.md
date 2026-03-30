# Night 1 Bootstrap Script Comparison
## TKH Innovation Fellowship — Phase 1, Week 1, Session 01
**Date:** March 9, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Two bootstrap scripts exist for Night 1: Terminal Genesis. The session script
was used live in class to provision student environments. A separate TA
supplemental implementation was independently developed as a reference artifact
and additional practice resource. Both scripts successfully provision a Night 1
lab environment and achieve the same core learning objectives.

---

## Side-by-Side Comparison

| Feature | Class Script | TA Implementation |
|---|---|---|
| **Lab Structure** | 100-folder maze (`~/maze/level_1` to `level_100`) | `/opt/alpha/` + `/var/tmp/.mission_cache/` |
| **Hidden Artifact** | `flag.txt` in `maze/level_42` | `intel.txt` in `.mission_cache` |
| **Student Objective** | Navigate maze, find flag | Locate 3 artifacts, log absolute paths |
| **Verification Suite** | Completion message | Full 5-point environment check |
| **GitHub CLI Install** | Silent install if missing | Silent install with version confirmation |
| **git Install** | Not included | Included as failsafe |
| **Error Handling** | Standard | `set -e` exits on any failure |
| **Tone** | Gamified ("Welcome to the Terminal") | Operational ("Good luck, operator") |
| **Best Used For** | Live class — student VM provisioning | TA dry-run and reference |

---

## Analysis

### Class Script — Optimized for Student Engagement

The session script prioritizes first-night confidence building. The 100-folder
maze gives students a clear, achievable objective using exactly the commands
taught in Session 01 — `cd`, `ls`, and absolute vs. relative paths. The `level_42`
placement is a classic hacker culture reference that rewards curious students who
recognize it, while remaining invisible to those who don't.

This aligns with research on motivation in adult learning: when learners can see a
clear path to a concrete goal, engagement and retention both increase (Ambrose et
al., 2010). The gamified structure lowers the psychological barrier of the CLI for
career-changers encountering a headless terminal for the first time.

### TA Implementation — Optimized for Real-World Fidelity

The supplemental implementation mirrors directory structures found in actual Linux
production environments. `/opt/alpha/` follows the FHS convention for optional
third-party software, and `/var/tmp/` is a real system directory encountered
regularly in security operations. The three-artifact discovery task maps directly
to the kind of reconnaissance a junior analyst performs when first accessing an
unfamiliar system.

The full verification suite reflects the "trust but verify" principle central to
security operations. Validating system state after any configuration change is a
foundational sysadmin discipline — making it visible in the bootstrap script itself
is an intentional documentation choice (Chapple et al., 2021).

---

## Which Script Gets Used When

| Context | Script |
|---|---|
| **Live class — student VM provisioning** | Class script (`setup_lab_01_george.sh`) |
| **TA dry-run before class** | TA implementation (`setup_lab_01_jane.sh`) |
| **TA portfolio reference** | Both |
| **Student portfolio push artifact** | Output of class script (the flag) |

---

## Key Takeaway

These scripts are complementary, not competing. The class script is the right
tool for the classroom — clean, fast, and pedagogically intentional. The TA
implementation documents an independent understanding of the same objectives
and serves as a reference for environment validation and additional student
practice. Having both in this repository demonstrates the ability to read
instructional intent, build on it independently, and document the relationship
between two implementations clearly.

---

## References

Ambrose, S. A., Bridges, M. W., DiPietro, M., Lovett, M. C., & Norman, M. K. (2010).
*How learning works: Seven research-based principles for smart teaching.* Jossey-Bass.

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.
