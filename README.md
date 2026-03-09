# TKH Innovation Fellowship — Phase 1 Cybersecurity
### Teaching Assistant Repository · Spring 2026

---

> *"Security is not a product, but a process."* — Bruce Schneier

---

## 👩🏾‍💻 About This Repo

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
