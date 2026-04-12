# TKH Innovation Fellowship — Phase 1 Cybersecurity
### Technical Operations & Lab Infrastructure · Spring 2026

> *"Security is not a product, but a process."* — Bruce Schneier

---

## About This Repository

This repository documents the technical work produced during Phase 1 of the TKH Innovation Fellowship Cybersecurity program, maintained in the role of Teaching Assistant — a position that in practice functioned as embedded IT support, systems administration, and technical infrastructure for a cohort of approximately 59 students.

**Program:** TKH Innovation Fellowship · [The Knowledge House](https://theknowledgehouse.org)

**Phase:** 1 — Cybersecurity Foundations

**Cohort Size:** ~58 students · Class of 2026

**Schedule:** Monday / Tuesday / Wednesday · 5:30–8:30 PM EST

**Start Date:** March 9, 2026

**End Date:** August 27, 2026

---

## What This Role Actually Involved

- **Environment provisioning** — scripting and validating lab environments across student VMs running Ubuntu Server on VirtualBox and UTM
- **Live troubleshooting** — diagnosing SSH failures, Git authentication errors, broken permissions, and failed bootstrap scripts in real time during sessions
- **User support at scale** — first-line technical support for ~59 users across macOS, Windows, and Linux
- **Documentation** — writing and maintaining technical guides, session notes, and reference scripts that students and future TAs could follow independently
- **Script development** — building independent lab implementations in Bash and Python3 with inline security annotations mapping each operation to its underlying concept

---

## Repository Structure

```
tkh-if-phase-one-artifacts/
├── week-01/
│   ├── scripts/
│   │   ├── setup_lab_01_george.sh
│   │   ├── setup_lab_01_jane.sh
│   │   ├── setup_lab_02_jane.sh
│   │   ├── setup_lab_03_jane.sh
│   │   └── harden.sh
│   ├── artifacts/
│   │   ├── discovery.txt
│   │   ├── bash_onliners.sh
│   │   └── log_interrogation_pipeline.sh
│   ├── tlab01/
│   │   └── final_threat_report.txt
│   └── docs/
│       ├── ta_analysis_s01.md
│       ├── ta_analysis_s02.md
│       ├── ta_analysis_s03.md
│       ├── analysis_tlab01.md
│       └── NOTES.md
├── week-02/
│   ├── artifacts/
│   │   ├── network_audit.txt
│   │   ├── subnet_blueprint.txt
│   │   └── protocol_audit.txt
│   ├── tlab02/
│   │   └── tlab_report.txt
│   └── docs/
│       └── analysis_tlab02.md
├── week-03/
│   ├── artifacts/
│   │   ├── port_check.py
│   │   ├── brute_detector.py
│   │   ├── brute_report.txt
│   │   ├── system_auditor.py
│   │   ├── system_auditor.py
│   │   ├── security_alert.json
│   │   └── handshake.txt
│   ├── tlab03/
│   │   └── incident_response.py
│   └── docs/
│       └── NOTES.md
├── week-04/
│   ├── artifacts/
│   │   ├── sandbox_report.txt
│   │   ├── deploy_web.sh
│   │   └── docker-compose.yml
│   ├── tlab04/
│   │   ├── docker-compose-tlab4.yml
│   │   └── hyperstack_audit.json
│   └── NOTES.md
└── README.md
```

---

## Week Tracker

| Week | Dates | Theme | Status |
|---|---|---|---|
| Week 01 | Mar 9-11 | Linux CLI · Permissions · Stream Editing · Git | ✅ Complete |
| Week 02 | Mar 16-18 | Networking · Subnetting · Protocol Interrogation | ✅ Complete |
| Week 03 | Mar 23-25 | Python Scripting · Port Scanner · Brute Force Detector · Process Auditor | ✅ Complete |
| Week 04 | Mar 30-Apr 1 | Virtualization · Docker · Container Security · Network Segmentation | ✅ Complete |
| Week 05 | Apr 6-8 | Identity · Active Directory · Windows Server Core |  ✅ Complete  |
| Week 06 | Apr 13-15 | Forge Capstone · Hybrid Architecture · Secure Deployment | ⏳ Upcoming |
---

## Week 01 — Linux Foundations and Version Control

### S01 · Terminal Genesis
VM orientation, headless Linux, FHS navigation, CLI fundamentals, and Git/GitHub setup. The TA bootstrap script was built independently as an additional practice lab — it mirrors FHS production directory conventions and includes a five-point environment verification suite to catch provisioning failures before they surface as student blockers.

### S02 · The Keymaster
File permissions, chmod, chown, SUID auditing, and baseline system hardening. The harden.sh script annotates each operation with its CIA Triad property and NIST NICE framework mapping — making it self-documenting for anyone who needs to run or modify it without external reference.

### S03 · Stream Editing and Automation
grep, sed, awk, pipeline construction, and log interrogation. Students built a forensic pipeline to extract attacker IPs from a simulated Apache access log under SQL injection attack. The TA log generator produces 10,000 entries in full Apache Combined Log Format with five randomized attacker IPs shuffled throughout.

### TLAB-01 · Operation Clean Sweep
Full synthesized incident response mission. Navigated a locked evidence directory, repaired permissions, and extracted attacker IPs from a corrupted log file using a multi-stage forensic pipeline. Deliverable: final_threat_report.txt.

---

## Week 02 — Networking · Subnetting · Protocol Interrogation

### S04 · Operation Broken Link
Interface restoration and gateway diagnostics on a deliberately broken network environment. Students restored a downed network interface, verified gateway connectivity, and documented the full interface state.

### S05 · Operation Grid Lock
Binary math, CIDR notation, network IDs, broadcast addresses, and usable host ranges. Students calculated subnet parameters by hand before verifying with ipcalc.

### S06 · Operation Hidden Door
DNS poisoning, hidden services, and ports that should not be open. Students used ss, dig, and curl to interrogate the protocol stack and identify anomalies.

### TLAB-02 · Operation Blackout
Full synthesized network remediation mission across OSI Layers 3, 4, and 7. Restored a sabotaged subnet mask, removed a malicious /etc/hosts DNS entry, and captured a TCP 3-way handshake as forensic proof of restored connectivity. Deliverable: tlab_report.txt.

---

## Week 03 — Python Scripting for Security Automation

### S07 · The Automation Forge — Port Scanner
No Nmap. Students wrote a TCP port scanner from scratch using Python's socket module — building the capability from first principles before using tools that abstract it away.

### S08 · The Paper Trail — Brute Force Detector
Parsed a simulated auth log using Python file I/O. Extracted every failed SSH login attempt and wrote findings to a clean report automatically. Mirrors the triage workflow a SOC analyst runs after a credential stuffing alert fires.

### S09 · The Automation Pivot — Process Auditor and JSON Alerting
Used subprocess to enumerate running processes, flag an unauthorized cryptominer, and export a structured JSON security alert compatible with SIEM ingestion.

### TLAB-03 · Operation Automated Hunt
Automated incident response pipeline built entirely in Python. Used subprocess to run grep programmatically against a simulated auth log, parsed raw output line by line to extract attacker IPs, and exported a structured JSON alert ready for SIEM ingestion. First full SOAR-style automation pipeline built from scratch.

---

## Week 04 — Virtualization · Docker · Container Security

### S10 · Sandbox Detonation
Configured a Host-Only network adapter in VirtualBox to air-gap the VM from the internet before detonating a simulated malware payload. Documented the isolation verification process and explained why Bridged mode is never acceptable for malware analysis environments.

### S11 · The Disposable Web Server
Deployed, modified, and destroyed an nginx container using Docker. Demonstrated the full container lifecycle — pull, run, exec, modify, log audit, stop, remove — and automated the deployment sequence in a reusable bash script.

### S12 · The Air-Gapped Stack
Deployed a WordPress and MySQL multi-container stack using Docker Compose with explicit network segmentation. MySQL isolated to backend only with internal: true — provably air-gapped from the internet. Verified isolation by testing outbound connectivity from inside each container.

**Cybersecurity principle:** Defense in Depth — if WordPress is compromised, the attacker is trapped. The database has no route out.

### TLAB-04 · Operation Fortified Node
Capstone of Week 4. Evicted a rogue decoy_web container occupying Port 80, built a three-tier WordPress and MariaDB Docker Compose stack from scratch with public_net and private_net segmentation, verified port isolation with nmap, tested container-to-VM network isolation, and produced a machine-readable JSON audit report documenting all findings with real values.

**Cybersecurity principle:** Security Architecture Verification — it is not enough to configure controls. You must prove they work. An untested control is an assumption.

See week-04/NOTES.md for full concept reference covering virtualization, container security, network segmentation, and Docker Compose architecture.

---

## Technical Environment

| Area | Tools |
|---|---|
| Operating Systems | Ubuntu Server headless · macOS · Windows |
| Virtualization | VirtualBox · UTM |
| Remote Access | VS Code Remote-SSH · SSH key authentication |
| Version Control | Git · GitHub CLI |
| Languages | Bash · Python3 |
| Containers | Docker · Docker Compose |
| User Support Scale | ~59 students · Class of 2026 |

---

## Core Concepts

### CIA Triad
Confidentiality, Integrity, and Availability are the conceptual backbone of every decision in this program — from file permissions to firewall rules to forensic pipeline design. Every script in this repository maps its operations to one or more of these properties explicitly.

### AAA Framework
Authentication, Authorization, and Accounting map directly to the Linux permission model. Git functions as an Accounting layer — every commit produces a cryptographic hash that creates a tamper-evident, timestamped, attributed record of change.

### Principle of Least Privilege
Every chmod operation in this repository reduces permissions to the minimum required for correct function — no more access than necessary, applied consistently across every artifact.

### Defense in Depth
No single security control is sufficient. The container network architecture in Week 04 layers multiple controls — network segmentation, internal-only routing, and port isolation — so that a breach of one layer does not mean a breach of all.

### SOAR — Security Orchestration, Automation and Response
The Python scripts in Week 03 and TLAB-03 demonstrate the foundational logic of SOAR platforms — ingest a log source, apply a detection rule, extract indicators of compromise, and export a structured alert. Built by hand first so the abstraction layers of enterprise tools make sense.

---

## Security Notes

- Never commit secrets — no API keys, tokens, SSH private keys, or passwords
- Always inspect before executing: cat script.sh before bash script.sh
- Commit message format: edited: filename

---

## References

Chapple, M., Stewart, J. M., and Gibson, D. (2021). ISC2 CISSP certified information systems security professional official study guide (9th ed.). Sybex.

Limoncelli, T. A., Hogan, C. J., and Chalup, S. R. (2016). The practice of system and network administration (3rd ed.). Addison-Wesley.

NIST. (2022). NICE Cybersecurity Workforce Framework (NIST SP 800-181r1). National Institute of Standards and Technology.

Ortega, J. M. (2023). Python for security and networking (3rd ed.). Packt Publishing.

Saltzer, J. H., and Schroeder, M. D. (1975). The protection of information in computer systems. Proceedings of the IEEE, 63(9), 1278-1308.

---

Built intentionally · Current Status: Updated Frequently · TKH IF 2026

---