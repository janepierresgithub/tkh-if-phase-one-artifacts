# tkh-if-phase-one-artifacts

![Program](https://img.shields.io/badge/TKH-Innovation%20Fellowship%202026-4a6fa5?style=flat-square)
![Phase](https://img.shields.io/badge/Phase-1%20Cybersecurity-4a7c59?style=flat-square)
![Role](https://img.shields.io/badge/Role-Teaching%20Assistant-6b4c2a?style=flat-square)
![Environment](https://img.shields.io/badge/Environment-Headless%20Linux%20%7C%20Ubuntu%20Server-b5451b?style=flat-square)
![Shell](https://img.shields.io/badge/Shell-Bash-4a6fa5?style=flat-square)
![Tools](https://img.shields.io/badge/Tools-Git%20%7C%20GitHub%20CLI%20%7C%20VS%20Code%20SSH-4a7c59?style=flat-square)

---

> *Everything in this repository was built from a terminal. No GUI. No shortcuts. Just a headless Ubuntu server, VS Code Remote-SSH, and a lot of intentional practice.*

---

## What This Is

This is the professional TA operations repository for TKH Innovation Fellowship 2026, Phase 1 Cybersecurity. It documents the infrastructure, scripts, guides, and artifacts produced while supporting a live cybersecurity cohort — all built and managed from a headless Linux environment via command line.

This repository exists at the intersection of two things: technical engineering and education. Every script here was tested before it was taught. Every concept here was broken before it was explained.

---

## Technical Environment

| Component | Details |
|-----------|---------|
| OS | Ubuntu Server 24.04 LTS (headless) |
| Virtualization | VirtualBox / UTM |
| Access Method | VS Code Remote-SSH |
| Shell | Bash |
| Version Control | Git + GitHub CLI (`gh`) |
| Username | `jane@janetheta` |

---

## Repository Structure

```
tkh-if-phase-one-artifacts/
├── week-01/                    # March 9–11, 2026
│   ├── docs/
│   │   ├── NOTES.md            # TA field notes, dry run results, gap analysis
│   │   └── bootstrap_comparison.md
│   └── scripts/
│       └── setup_lab_01_ta.sh
├── week-02/                    # March 16–18, 2026
├── week-03/                    # March 23–25, 2026
└── README.md
```

---

## Week Tracker

| Week | Dates | Topics | Nights Complete |
|------|-------|--------|-----------------|
| Week 01 | Mar 9–11, 2026 | Linux CLI · FHS · File Permissions · Git/GitHub | ✅ N1 · ✅ N2 · 🔜 N3 |
| Week 02 | Mar 16–18, 2026 | File Permissions · Access Control · Hardening | ⬜ Upcoming |
| Week 03 | Mar 23–25, 2026 | Stream Editing · Log Analysis · grep/sed/awk | ⬜ Upcoming |

---

## What This Repository Demonstrates

**Linux Systems Administration**
All work is performed on a headless Ubuntu Server instance. Navigation, file management, permissions, process management, and service configuration are executed entirely via CLI — no graphical interface.

**Security Engineering Fundamentals**
Lab environments are provisioned using bash scripts that simulate real-world misconfigurations — broken `/etc/shadow` permissions, locked directories, misconfigured file ownership. Remediation follows industry-standard hardening practices aligned with the Linux Foundation's Filesystem Hierarchy Standard.

**Infrastructure as Code**
Bootstrap scripts provision reproducible lab environments from a single `curl | bash` command. This mirrors DevSecOps practices used in enterprise environments to spin up consistent, auditable server configurations at scale.

**Technical Education & Curriculum Support**
Supporting a live cybersecurity cohort requires translating dense technical concepts into accessible, accurate instruction. Every guide, every analogy, and every lab sequence in this repository was designed to meet adult learners where they are — then move them forward.

**Version Control as Professional Practice**
Every artifact is committed with descriptive, conventional commit messages. The commit history of this repository is itself a professional record of how this work was built.

---

## Certifications & Credentials

![AWS](https://img.shields.io/badge/AWS-Cloud%20Practitioner-b5451b?style=flat-square&logo=amazonaws&logoColor=white)
![TKH](https://img.shields.io/badge/TKH-Innovation%20Fellowship%20Valedictorian-4a6fa5?style=flat-square)
