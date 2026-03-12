# Night 3 Bootstrap Script Comparison
## TKH Innovation Fellowship — Phase 1, Week 1, Session 03
**Date:** March 11, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Two bootstrap scripts exist for Night 3: Stream Editing & Automation. The session
script was used live in class to generate a simulated Apache web server access log
for the Log Interrogation lab. A separate TA supplemental implementation was
independently developed to create a larger, more realistic forensic environment
for extended practice. Both scripts produce an `access.log` file containing
embedded SQL injection attack signatures suitable for the UNION SELECT pipeline
exercise.

> **Class script:** `setup_lab_03.sh` (used live in session)
> **This repo:** `setup_lab_03_jane.sh` (TA supplemental implementation)

---

## Side-by-Side Comparison

| Feature | Class Script | TA Implementation |
|---|---|---|
| **Language** | Bash | Python3 embedded in bash |
| **Log volume** | ~5,000 lines | 10,000 lines |
| **Attacker IPs** | 3 hardcoded IPs | 5 IPs, randomized selection |
| **Attack entries** | ~50 entries | 250 entries |
| **Log format** | Streamlined for classroom speed | Full Apache Combined Log Format |
| **User agent field** | Not included | Included — sqlmap, Nikto signatures |
| **Attack distribution** | Grouped at end of file | Shuffled throughout the log |
| **Verification** | Completion message | Python prints totals + unique IP summary |
| **Error handling** | Standard | `set -e` exits on any failure |
| **Best used for** | Live class pipeline exercise | Extended forensic practice |

---

## Analysis

### Class Script — Optimized for Live Instruction

The session script delivers a focused log file that students can immediately
interrogate with the pipeline built in class. The 3-IP, ~5,000 line format is
intentional — it keeps the exercise achievable within the session window and
produces a clean, verifiable output that students can push to GitHub as a
portfolio artifact.

The streamlined format also makes the pipeline easier to reason about. When
students run `grep "UNION SELECT"` and see results, then `awk '{print $1}'`
and see IPs, the signal is clear and the feedback loop is tight. That clarity
is what makes the exercise effective on a first pass.

### TA Implementation — Extended Forensic Practice

The supplemental script generates a 10,000 line log in full Apache Combined
Log Format — the actual format found in production web server environments.
Each entry includes an IP address, timestamp, HTTP method, request path, status
code, response size, referrer, and user agent string.

The attack entries use realistic user agent strings associated with known
scanning tools — `sqlmap/1.7.8` and `Nikto/2.1.6` — giving students practice
identifying tool signatures alongside the SQL injection payloads. Attacks are
shuffled throughout the log rather than grouped at the end, which more accurately
reflects how attack traffic appears in real server logs.

The 5-IP, 250-entry scale also gives students more data to work with when
practicing the ranked pipeline variant:

```bash
grep "UNION SELECT" ~/access.log \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -nr
```

This extended version surfaces which attacker hit the server most frequently —
a triage step a real analyst would run before deciding where to focus.

---

## The Holy Trinity — Tonight's Pipeline

Both scripts produce a log that the same pipeline can interrogate:

```bash
# Stage 1 — grep: The Scalpel
# Filter 9,750+ legitimate lines, keep only attack lines
grep "UNION SELECT" ~/access.log

# Stage 2 — awk: The Formatter
# Extract column 1 (IP address) from each attack line
grep "UNION SELECT" ~/access.log | awk '{print $1}'

# Stage 3 — sort | uniq: The Refiner
# Alphabetize and deduplicate — clean threat intelligence
grep "UNION SELECT" ~/access.log | awk '{print $1}' | sort | uniq

# Stage 4 — redirect: Evidence Preservation
# Save the artifact to file
grep "UNION SELECT" ~/access.log | awk '{print $1}' | sort | uniq > ~/threat_ips.txt
```

| Stage | Tool | CIA Property | Security Concept |
|---|---|---|---|
| Filter | `grep` | Integrity | IOC identification — only verified attack lines |
| Extract | `awk '{print $1}'` | Confidentiality | Data reduction — only what's needed |
| Refine | `sort \| uniq` | Integrity | Deduplication — clean, attributable list |
| Save | `>` | Integrity | Evidence preservation — tamper-evident file |

---

## Which Script Gets Used When

| Context | Script |
|---|---|
| **Live class — log interrogation lab** | Class script (`setup_lab_03.sh`) |
| **TA dry-run before class** | TA implementation (`setup_lab_03_jane.sh`) |
| **Students wanting extended practice** | TA implementation (`setup_lab_03_jane.sh`) |
| **TA portfolio reference** | Both |
| **Student portfolio push artifact** | `threat_ips.txt` — output of either lab |

---

## Key Takeaway

Both scripts teach the same foundational skill — building a forensic pipeline
that extracts actionable threat intelligence from raw log data. The class script
delivers that skill clearly and efficiently in a live session. The TA
implementation extends the practice surface with a larger, more realistic dataset
that mirrors what analysts encounter in production environments. Together they
cover the full range of the Log Interrogation exercise from first exposure to
production-scale practice.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
