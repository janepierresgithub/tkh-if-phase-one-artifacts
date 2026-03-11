# Session 03 — Lab Environment Analysis
## TKH Innovation Fellowship · Phase 1 · Week 1 · Night 3
**Date:** March 11, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Tonight's class used the lead instructor's provisioning script to generate a simulated
web server access log for the Log Interrogation lab. This document describes an
independent TA implementation — `setup_lab_03_jane.sh` — built separately as a
reference artifact. Both scripts produce an `access.log` file suitable for the
`UNION SELECT` pipeline exercise and achieve the same learning objectives.

> **Class script:** `setup_lab_03_george.sh` (instructor-authored, used live)
> **This repo:** `setup_lab_03_jane.sh` (TA independent implementation)

---

## Implementation Decisions

| Design Decision | Instructor Approach | TA Implementation |
|---|---|---|
| **Language** | Pure bash with loop expansion | Python3 embedded in bash — portable |
| **Log volume** | ~5,000 lines | 10,000 lines — closer to production scale |
| **Attacker IPs** | 3 hardcoded IPs | 5 IPs, randomized across 250 attack entries |
| **Log format** | Simplified (IP, timestamp, status) | Full Apache Combined Log Format + user agent |
| **Attack distribution** | Appended at end of file | Shuffled throughout — buried in noise |
| **Verification** | Echo on completion | Python prints totals + unique IP summary |

These choices reflect what a TA would build when designing a more realistic forensic
environment for independent practice — not a critique of the class script, which is
intentionally minimal for speed and clarity in a live classroom.

---

## The Holy Trinity — Tonight's Pipeline

```bash
# The Scalpel (grep) — filter attack lines
grep "UNION SELECT" ~/access.log

# The Formatter (awk) — extract column 1 (IP address)
grep "UNION SELECT" ~/access.log | awk '{print $1}'

# The Refiner (sort + uniq) — deduplicate
grep "UNION SELECT" ~/access.log | awk '{print $1}' | sort | uniq

# Save the artifact
grep "UNION SELECT" ~/access.log | awk '{print $1}' | sort | uniq > ~/threat_ips.txt
```

Each stage maps to a concept:

| Stage | Tool | What It Does | Security Concept |
|---|---|---|---|
| Filter | `grep` | Discards all non-attack lines | IOC identification |
| Extract | `awk '{print $1}'` | Pulls IP address from column 1 | Data reduction |
| Refine | `sort \| uniq` | Deduplicates the IP list | Threat intelligence formatting |
| Save | `> threat_ips.txt` | Redirects stdout to file | Evidence preservation |

---

## CIA Triad Mapping

The lab environment itself demonstrates CIA principles through its design:

- **Confidentiality** — Attack IPs are buried in 10,000 lines of noise. Without
  targeted filtering, they are invisible. This mirrors how threat actors blend
  malicious traffic with legitimate users.

- **Integrity** — Log entries are immutable once generated. `grep` finds exact
  strings — no ambiguity, no interpretation. This mirrors chain-of-custody
  requirements in forensic evidence.

- **Availability** — 10,000 lines simulates a live server under sustained load.
  Production servers generate millions of log entries daily. The pipeline must
  be efficient enough to handle that scale.

---

## Analyst Workflow

The pipeline students built tonight is one full cycle of the forensic analyst loop:

```
Filter (grep) → Extract (awk) → Refine (sort/uniq) → Defend (iptables/Fail2Ban)
     ↑                                                          ↓
     └──────────────── New logs, new threats ──────────────────┘
```

`threat_ips.txt` is the output of this cycle. In production, it becomes the input
to a firewall rule or intrusion detection system — completing the loop.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
