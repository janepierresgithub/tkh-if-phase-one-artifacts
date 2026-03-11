# TKH Innovation Fellowship — Phase 1 Cybersecurity

### Technical Operations & Lab Infrastructure · Spring 2026

---

> *"Security is not a product, but a process."* — Bruce Schneier

---

## About This Repository

This repository documents the technical work produced during Phase 1 of the TKH
Innovation Fellowship Cybersecurity program. It was built and maintained in the
role of Teaching Assistant — a position that in practice functioned as embedded
IT support, systems administration, and technical infrastructure for a cohort of
approximately 70 students across Foundations and Phase 1 cohorts.

The work here spans environment provisioning, automation scripting, live
troubleshooting, user support, and technical documentation. Every script is
annotated with the security principle it demonstrates. Every analysis document
explains not just what was built, but the reasoning behind the implementation
decisions — the same reasoning a technician applies when diagnosing an unfamiliar
system or writing a runbook for a team.

**Program:** TKH Innovation Fellowship · [The Knowledge House](https://theknowledgehouse.org)
**Phase:** 1 — Cybersecurity Foundations
**Cohort Size:** ~70 students across Foundations & Phase 1
**Schedule:** Monday / Tuesday / Wednesday · 5:30–8:30 PM EST
**Start Date:** March 9, 2026

---

## What This Role Actually Involved

This was not a grading role. The day-to-day technical work included:

- **Environment provisioning** — scripting and validating lab environments across
  70 student VMs running Ubuntu Server (headless) on VirtualBox and UTM
- **Live troubleshooting** — diagnosing SSH connection failures, Git authentication
  errors, broken file permissions, misconfigured paths, and failed bootstrap scripts
  in real time during sessions
- **User support at scale** — first-line technical support for ~70 users with varying
  skill levels across macOS, Windows, and Linux environments
- **Documentation** — writing and maintaining technical guides, session notes, and
  reference scripts that students and future TAs could follow independently
- **Systems validation** — running pre-session environment checks to catch
  provisioning failures before they became classroom blockers
- **Script development** — building independent implementations of lab environments
  in bash and Python3, with inline annotations mapping each operation to its
  underlying security concept

---

## Repository Structure

```
tkh-if-phase-one-artifacts/
│
├── week-01/
│   ├── scripts/
│   │   ├── setup_lab_01_george.sh   # Lead instructor's S01 bootstrap (reference)
│   │   ├── setup_lab_01_jane.sh     # Independent S01 implementation (TA)
│   │   └── setup_lab_03_jane.sh     # Independent S03 log generator — Python3
│   ├── artifacts/
│   │   ├── discovery.txt            # S01 output — filesystem reconnaissance
│   │   ├── bash_onliners.sh         # CLI reference — command patterns
│   │   ├── threat_ips.txt           # S03 output — extracted attacker IPs
│   │   └── log_interrogation_pipeline.sh  # S03 documented forensic pipeline
│   └── docs/
│       ├── comparison_night1.md     # S01 bootstrap analysis
│       ├── analysis_night3.md       # S03 lab environment analysis
│       ├── night1_ta_notes.md       # S01 session notes
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
VM orientation, headless Linux, FHS navigation, CLI fundamentals, and Git/GitHub
setup across 70 student environments. The TA bootstrap script (`setup_lab_01_jane.sh`)
was built independently alongside the Lead Instructor's materials. It mirrors FHS
production directory conventions and includes a five-point environment verification
suite to catch provisioning failures before they surface as student blockers.

→ `week-01/scripts/` · `week-01/docs/comparison_night1.md`

```bash
# TA Reference Bootstrap
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

### Night 2 · The Keymaster
File permissions, `chmod`, `chown`, SUID auditing, and baseline system hardening.
The `harden.sh` script annotates each operation with its CIA Triad property and
NIST NICE framework mapping — making the script self-documenting for anyone who
needs to run or modify it without external reference.

→ `week-02/scripts/harden.sh` · `week-02/docs/NOTES.md`

---

### Night 3 · Stream Editing & Automation
`grep`, `sed`, `awk`, pipeline construction, and log interrogation. Students built
a forensic pipeline to extract attacker IPs from a simulated Apache access log under
SQL injection attack. The TA log generator produces 10,000 entries in full Apache
Combined Log Format with five randomized attacker IPs shuffled throughout — closer
to production forensic conditions than the class script's simplified format.

→ `week-01/scripts/setup_lab_03_jane.sh` · `week-01/artifacts/log_interrogation_pipeline.sh` · `week-01/docs/analysis_night3.md`

```bash
# The forensic pipeline — built live with 70 students
grep "UNION SELECT" ~/access.log \
    | awk '{print $1}' \
    | sort | uniq \
    > ~/threat_ips.txt
```

---

## Technical Environment

| Area | Tools & Platforms |
|---|---|
| **Operating Systems** | Ubuntu Server (headless) · macOS · Windows |
| **Virtualization** | VirtualBox · UTM |
| **Remote Access** | VS Code Remote-SSH · SSH key authentication |
| **Version Control** | Git · GitHub CLI (`gh`) · Conventional Commits |
| **Languages** | Bash · Python3 |
| **User Support Scale** | ~70 students across Foundations & Phase 1 |

---

## Core Concepts — Week 01

### CIA Triad
Confidentiality, Integrity, and Availability are the conceptual backbone of every
decision in this program — from file permissions to firewall rules to forensic
pipeline design. Every script in this repository maps its operations to one or more
of these properties explicitly (Chapple et al., 2021).

### AAA Framework
Authentication, Authorization, and Accounting map directly to the Linux permission
model. Git functions as an Accounting layer — every commit produces a cryptographic
hash that creates a tamper-evident, timestamped, attributed record of change.

### The Holy Trinity — grep / sed / awk
Three tools that together make the terminal a forensic instrument:
- `grep` — filters rows by pattern (The Scalpel)
- `sed` — mutates and replaces text on the fly (The Laser)
- `awk` — extracts specific columns from structured data (The Formatter)

### Principle of Least Privilege
Every `chmod` operation in this repository reduces permissions to the minimum
required for correct function — formalized by Saltzer and Schroeder (1975) and
applied here at the file system level.

---

## Security Notes

- **Never commit secrets** — no API keys, tokens, SSH private keys, or passwords
- Always inspect before executing: `cat script.sh` before `bash script.sh`
- Conventional Commits in use:
  - `feat:` — new lab material or script
  - `fix:` — corrections to existing content
  - `docs:` — documentation updates
  - `sec:` — security-related changes

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
