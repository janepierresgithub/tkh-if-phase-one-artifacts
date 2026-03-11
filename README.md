# TKH Innovation Fellowship — Phase 1 Cybersecurity

### Teaching Assistant Repository · Spring 2026

---

> *"Security is not a product, but a process."* — Bruce Schneier

---

## About This Repository

This repository documents Phase 1 of the TKH Innovation Fellowship Cybersecurity
program from the perspective of the Teaching Assistant. It contains independent
lab implementations, annotated scripts, session analysis, and reference artifacts
produced week by week alongside the live curriculum.

The work here serves two purposes: supporting students in the program, and building
a personal record of how the foundational concepts of Linux security translate into
real-world practice. Every script is commented with the security principle it
demonstrates. Every analysis document explains not just what was built, but why
the decisions were made.

**Program:** TKH Innovation Fellowship · [The Knowledge House](https://theknowledgehouse.org)
**Phase:** 1 — Cybersecurity Foundations
**Schedule:** Monday / Tuesday / Wednesday · 5:30–8:30 PM EST
**Start Date:** March 9, 2026

---

## Repository Structure

```
tkh-if-phase-one-artifacts/
│
├── week-01/
│   ├── scripts/
│   │   ├── setup_lab_01_george.sh   # Lead instructor's S01 bootstrap (reference)
│   │   ├── setup_lab_01_jane.sh     # TA independent S01 implementation
│   │   └── setup_lab_03_jane.sh     # TA independent S03 log generator (Python)
│   ├── artifacts/
│   │   ├── discovery.txt            # S01 lab output — filesystem reconnaissance
│   │   ├── bash_onliners.sh         # CLI reference — command patterns
│   │   ├── harden.sh                # S02 hardening script (see also week-02)
│   │   ├── threat_ips.txt           # S03 lab output — extracted attacker IPs
│   │   └── log_interrogation_pipeline.sh  # S03 documented forensic pipeline
│   └── docs/
│       ├── comparison_night1.md     # S01 bootstrap script analysis
│       ├── analysis_night3.md       # S03 lab environment analysis
│       ├── night1_ta_notes.md       # S01 TA session notes
│       └── NOTES.md                 # Week 01 concept reference
│
├── week-02/
│   ├── scripts/
│   │   └── harden.sh                # Baseline Linux hardening — CIA annotated
│   └── docs/
│       └── NOTES.md                 # Permissions, chmod, AAA framework mapping
│
├── week-03/
│   └── docs/
│       └── NOTES.md                 # Upcoming — advanced stream editing
│
└── README.md
```

---

## Week Tracker

| Week | Dates | Theme | Status |
|---|---|---|---|
| Week 01 | Mar 10–12 | Linux CLI · Permissions · Stream Editing · Git | ✅ Complete |
| Week 02 | Mar 17–19 | Access Control · Cryptography · Network Fundamentals | ⬜ Upcoming |
| Week 03 | Mar 24–26 | Advanced Automation · Bash Scripting · Cron | ⬜ Upcoming |

---

## Week 01 — Three Sessions

### Night 1 · Terminal Genesis
VM orientation, headless Linux, FHS navigation, CLI fundamentals, and Git/GitHub setup.
Students provisioned their environments using the lead instructor's bootstrap script.
The TA implementation (`setup_lab_01_jane.sh`) mirrors FHS production conventions
and includes a five-point verification suite.

→ See: `week-01/scripts/` · `week-01/docs/comparison_night1.md`

**Lab Bootstrap (TA Reference)**
```bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

### Night 2 · The Keymaster
File permissions, `chmod`, `chown`, the SUID audit, and system hardening.
The `harden.sh` script documents each permission operation with its CIA Triad
property and NIST NICE framework mapping inline — making the script itself
a teaching artifact.

→ See: `week-02/scripts/harden.sh` · `week-02/docs/NOTES.md`

---

### Night 3 · Stream Editing & Automation
`grep`, `sed`, `awk`, pipeline construction, and log interrogation.
Students built a forensic pipeline to extract attacker IPs from a simulated
Apache access log under SQL injection attack. The TA implementation generates
a 10,000-line log with full Apache Combined Log Format and five randomized
attacker IPs shuffled throughout the noise.

→ See: `week-01/scripts/setup_lab_03_jane.sh` · `week-01/artifacts/log_interrogation_pipeline.sh` · `week-01/docs/analysis_night3.md`

**The Pipeline**
```bash
grep "UNION SELECT" ~/access.log \
    | awk '{print $1}' \
    | sort | uniq \
    > ~/threat_ips.txt
```

---

## Core Concepts Covered — Week 01

### The CIA Triad
Confidentiality, Integrity, and Availability form the conceptual backbone of every
lab decision in this program. As Chapple et al. (2021) describe, these three
principles map directly to the access control decisions practitioners make daily —
from file permissions to firewall rules.

### AAA Framework
Every permission and authentication decision maps to Authentication (proving identity),
Authorization (enforcing access rights), and Accounting (logging what happened and when).
Git itself functions as an Accounting layer — every commit produces a cryptographic
hash that creates a tamper-evident, timestamped, attributed record of change.

### The Holy Trinity — grep / sed / awk
Three text processing tools that together make the Linux terminal a forensic instrument:
- `grep` — The Scalpel. Filters rows by pattern.
- `sed` — The Laser. Mutates and replaces text on the fly.
- `awk` — The Formatter. Extracts specific columns from structured data.

### Principle of Least Privilege
Every `chmod` operation in this repository reduces permissions to the minimum required
for the resource to function correctly. This principle, formalized by Saltzer and
Schroeder (1975), underpins every hardening decision in Week 01.

---

## Security Notes

- **Never commit secrets** — no API keys, tokens, SSH private keys, or passwords
- Always inspect before executing: `cat script.sh` before `bash script.sh`
- This repository uses [Conventional Commits](https://www.conventionalcommits.org/):
  - `feat:` — new lab material or script
  - `fix:` — corrections to existing content
  - `docs:` — documentation updates
  - `sec:` — security-related changes

---

## Environment

| Tool | Notes |
|---|---|
| OS | Ubuntu Server (headless) |
| VM Platforms | VirtualBox · UTM |
| Remote Access | VS Code Remote-SSH |
| GitHub CLI | `gh` — authenticated via SSH |
| Languages | Bash · Python3 |

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Limoncelli, T. A., Hogan, C. J., & Chalup, S. R. (2016). *The practice of system and
network administration: DevOps and other best practices for enterprise IT* (3rd ed.).
Addison-Wesley.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.

---

**Built with intention · Updated weekly · TKH IF 2026**
