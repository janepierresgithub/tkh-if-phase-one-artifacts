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
│   │   └── bootstrap_comparison.md  # Three-script analysis with APA citations
│   └── scripts/
│       └── setup_lab_01_ta.sh  # TA prep bootstrap (janepierresgithub Gist)
├── week-02/                    # March 16–18, 2026
├── week-03/                    # March 23–25, 2026
└── README.md
```

---

## Week Tracker

| Week | Dates | Topics | Nights Complete |
|------|-------|--------|-----------------|
| Week 01 | Mar 9–11, 2026 | Linux CLI · FHS · File Permissions · Git/GitHub | ✅ N1 · ✅ N2 · 🔜 N3 |
| Week 02 | Mar 16–18, 2026 | Coming soon | — |
| Week 03 | Mar 23–25, 2026 | Coming soon | — |

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

## Student-Facing Bootstrap (Night 1)

```bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

## Certifications & Credentials

![AWS](https://img.shields.io/badge/AWS-Cloud%20Practitioner-b5451b?style=flat-square&logo=amazonaws&logoColor=white)
![TKH](https://img.shields.io/badge/TKH-Innovation%20Fellowship%20Valedictorian-4a6fa5?style=flat-square)>
---

## About

Jane G. Pierre is a cybersecurity Teaching Assistant and multi-disciplinary tech professional with a background spanning cloud infrastructure, security education, and systems administration. She builds everything in the terminal first.

---

*TKH Innovation Fellowship 2026 · Phase 1 · Cybersecurity · TA Operations Repo · Jane G. Pierre# tkh-if-phase-one-artifacts

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
│   │   └── bootstrap_comparison.md  # Three-script analysis with APA citations
│   └── scripts/
│       └── setup_lab_01_ta.sh  # TA prep bootstrap (janepierresgithub Gist)
├── week-02/                    # March 16–18, 2026
├── week-03/                    # March 23–25, 2026
└── README.md
```

---

## Week Tracker

| Week | Dates | Topics | Nights Complete |
|------|-------|--------|-----------------|
| Week 01 | Mar 9–11, 2026 | Linux CLI · FHS · File Permissions · Git/GitHub | ✅ N1 · ✅ N2 · 🔜 N3 |
| Week 02 | Mar 16–18, 2026 | Coming soon | — |
| Week 03 | Mar 23–25, 2026 | Coming soon | — |

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

## Student-Facing Bootstrap (Night 1)

```bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

## Certifications & Credentials

![AWS](https://img.shields.io/badge/AWS-Cloud%20Practitioner-b5451b?style=flat-square&logo=amazonaws&logoColor=white)
![TKH](https://img.shields.io/badge/TKH-Innovation%20Fellowship%20Valedictorian-4a6fa5?style=flat-square)

---# TKH Innovation Fellowship — Phase 1 Cybersecurity
### Teaching Assistant Repository
---

> *"Security is not a product, but a process."* — Bruce Schneier

---

## # tkh-if-phase-one-artifacts

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
│   │   └── bootstrap_comparison.md  # Three-script analysis with APA citations
│   └── scripts/
│       └── setup_lab_01_ta.sh  # TA prep bootstrap (janepierresgithub Gist)
├── week-02/                    # March 16–18, 2026
├── week-03/                    # March 23–25, 2026
└── README.md
```

---

## Week Tracker

| Week | Dates | Topics | Nights Complete |
|------|-------|--------|-----------------|
| Week 01 | Mar 9–11, 2026 | Linux CLI · FHS · File Permissions · Git/GitHub | ✅ N1 · ✅ N2 · 🔜 N3 |
| Week 02 | Mar 16–18, 2026 | Coming soon | — |
| Week 03 | Mar 23–25, 2026 | Coming soon | — |

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

## Student-Facing Bootstrap (Night 1)

```bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

## Certifications & Credentials

![AWS](https://img.shields.io/badge/AWS-Cloud%20Practitioner-b5451b?style=flat-square&logo=amazonaws&logoColor=white)
![TKH](https://img.shields.io/badge/TKH-Innovation%20Fellowship%20Valedictorian-4a6fa5?style=flat-square)
![Bloomberg](https://img.shields.io/badge/Bloomberg-CTF%20First%20Place-4a7c59?style=flat-square)

---🏾‍💻 About This Repo

This is the working repository for **Phase 1: Cybersecurity** of the TKH Innovation
Fellowship, maintained by the Teaching Assistant. It contains lab scripts, reference
artifacts, concept documentation, and week-by-week resources used to support students
through the program.

**Program:** TKH Innovation Fellowship · [The Knowledge House](https://theknowledgehouse.org)  
**Phase:** 1 — Cybersecurity Foundations  
**Schedule:** Monday / Tuesday / Wednesday · 5:30–8:30 PM EST  
**Start Date:** March 9, 2026

---

## 🗂️ Repository Structure
```
tkh-if-phase-one-artifacts/
│
├── week-01/
│   ├── artifacts/       # TA reference implementations & lab files
│   ├── scripts/         # Bootstrap & automation scripts
│   └── docs/            # Concept guides, citations, TA notes
│
├── week-02/
│   ├── artifacts/
│   ├── scripts/
│   └── docs/
│
├── week-03/
│   ├── artifacts/
│   ├── scripts/
│   └── docs/
│
└── README.md            # You are here
```

---

## 📅 Week Tracker

| Week | Dates | Theme | Status |
|------|-------|-------|--------|
| Week 01 | Mar 10–12 | Linux CLI, File System, VM Setup, Git/GitHub | 🟢 Active |
| Week 02 | Mar 17–19 | File Permissions, Access Control, Hardening | ⬜ Upcoming |
| Week 03 | Mar 24–26 | Stream Editing, Log Analysis, grep/sed/awk | ⬜ Upcoming |

---

## 🧪 Week 01 — Linux Foundations & Version Control

**Nights at a glance:**

- **Night 1 (Mon)** — VM orientation, headless Linux, FHS navigation, CLI fundamentals
- **Night 2 (Tue)** — File permissions, chmod, CIA Triad mapping, access control
- **Night 3 (Wed)** — Git init, GitHub push, VS Code Remote-SSH, conventional commits

**Lab Bootstrap Script**

Students provision their lab environment using:

\`\`\`bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
\`\`\`

The script creates the lab directory structure, sets permissions, installs required tools,
and runs a verification check. Source lives in \`week-01/scripts/\`.

**Key Concepts Covered**

This program grounds students in the foundational principles that define modern cybersecurity
practice. The **CIA Triad** — Confidentiality, Integrity, and Availability — serves as the
conceptual backbone of every lab decision, from file permissions to version control. As
Chapple et al. (2021) describe, these three principles form the cornerstone of information
security and map directly to the access control decisions practitioners make daily.

Students also engage with **Git as a security tool**, not just a developer convenience.
Every commit produces a cryptographic hash that creates a tamper-evident, timestamped,
attributed record of change — functioning as an audit trail aligned with the Accounting
layer of the AAA framework. This mirrors how regulated industries use version control for
compliance (Limoncelli et al., 2016).

- CIA Triad (Confidentiality · Integrity · Availability)
- AAA Framework (Authentication · Authorization · Accounting)
- Linux Filesystem Hierarchy Standard (FHS)
- Least Privilege Principle
- Git as a cryptographic audit trail
- SSH key authentication

---

## 🔐 Security Notes for Contributors

- **Never commit secrets** — no API keys, tokens, SSH private keys, or passwords
- Always inspect scripts before running: \`cat script.sh\` before \`bash script.sh\`
- This repo uses [Conventional Commits](https://www.conventionalcommits.org/):
  - \`feat:\` — new lab material or script
  - \`fix:\` — corrections to existing content
  - \`docs:\` — documentation updates
  - \`sec:\` — security-related changes

---

## 🛠️ TA Environment

| Tool | Notes |
|------|-------|
| OS | Ubuntu Server (headless) |
| VM Platforms | VirtualBox · UTM |
| Remote Access | VS Code Remote-SSH |
| GitHub CLI | \`gh\` — authenticated via SSH |
| Certifications | AWS Cloud Practitioner |

---

## 📚 Resources

- [TKH Innovation Fellowship](https://theknowledgehouse.org/innovation-fellowship/)
- [NIST NICE Framework](https://www.nist.gov/nice)
- [GitHub Docs — SSH Keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Limoncelli, T. A., Hogan, C. J., & Chalup, S. R. (2016). *The practice of system and
network administration: DevOps and other best practices for enterprise IT* (3rd ed.).
Addison-Wesley.

---

<div align="center">

**Built with intention · Updated weekly · TKH IF 2026**

</div>
