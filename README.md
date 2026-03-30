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
approximately 59 students across Phase 1.

The work here spans environment provisioning, automation scripting, live
troubleshooting, user support, and technical documentation. Every script is
annotated with the security principle it demonstrates. Every analysis document
explains not just what was built, but the reasoning behind the implementation
decisions — the same reasoning a technician applies when diagnosing an unfamiliar
system or writing a runbook for a team.

**Program:** TKH Innovation Fellowship · [The Knowledge House](https://theknowledgehouse.org)
**Phase:** 1 — Cybersecurity Foundations
**Cohort Size:** ~59 students · Class of 2026
**Schedule:** Monday / Tuesday / Wednesday · 5:30–8:30 PM EST
**Start Date:** March 9, 2026
**End Date:** August 27, 2026

---

## What This Role Actually Involved

This was not a grading role. The day-to-day technical work included:

- **Environment provisioning** — scripting and validating lab environments across
  student VMs running Ubuntu Server (headless) on VirtualBox and UTM
- **Live troubleshooting** — diagnosing SSH connection failures, Git authentication
  errors, broken file permissions, misconfigured paths, and failed bootstrap scripts
  in real time during sessions
- **User support at scale** — first-line technical support for ~59 users with varying
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
│   │   ├── setup_lab_01_george.sh   # S01 class bootstrap (reference copy)
│   │   ├── setup_lab_01_jane.sh     # Independent S01 implementation (TA)
│   │   ├── setup_lab_02_jane.sh     # S02 — supplemental lab environment
│   │   ├── setup_lab_03_jane.sh     # S03 — supplemental log generator (Python3)
│   │   └── harden.sh                # S02 — hardening script (CIA annotated)
│   ├── artifacts/
│   │   ├── discovery.txt            # S01 output — filesystem reconnaissance
│   │   ├── bash_onliners.sh         # CLI reference — command patterns
│   │   ├── threat_ips.txt           # S03 output — extracted attacker IPs
│   │   ├── final_threat_report.txt  # TLAB-01 — Operation Clean Sweep output
│   │   └── log_interrogation_pipeline.sh  # S03 documented forensic pipeline
│   └── docs/
│       ├── ta_analysis_s01.md       # S01 bootstrap analysis
│       ├── ta_analysis_s02.md       # S02 bootstrap analysis
│       ├── ta_analysis_s03.md       # S03 bootstrap analysis
│       ├── analysis_tlab01.md       # TLAB-01 — Operation Clean Sweep analysis
│       ├── analysis_night2.md       # S02 lab environment analysis
│       ├── analysis_night3.md       # S03 lab environment analysis
│       ├── night1_ta_notes.md       # S01 session field notes
│       ├── NOTES.md                 # Week 01 concept reference
│       └── NOTES_night2.md          # S02 — permissions, chmod, AAA mapping
│
├── week-02/
│   ├── scripts/                     # Session bootstrap scripts
│   ├── artifacts/
│   │   ├── network_audit.txt        # S04 — interface & gateway restoration
│   │   ├── subnet_blueprint.txt     # S05 — subnetting calculations
│   │   ├── protocol_audit.txt       # S06 — port & protocol interrogation
│   │   └── tlab_report.txt          # TLAB-02 — Operation Blackout
│   └── docs/
│       └── analysis_tlab02.md       # TLAB-02 — Operation Blackout analysis
│
├── week-03/
│   ├── artifacts/
│   │   ├── port_check.py            # S07 — TCP port scanner
│   │   ├── brute_detector.py        # S08 — auth log brute force detector
│   │   ├── brute_report.txt         # S08 — brute force findings
│   │   ├── system_auditor.py        # S09 — automated process auditor
│   │   ├── incident_response.py     # S09 — threat response script
│   │   ├── security_alert.json      # S09 — structured JSON alert
│   │   └── handshake.txt            # S09 — tcpdump capture
│   └── docs/
│       └── NOTES.md                 # Week 03 — Python scripting concept reference
│
└── README.md
```

---

## Week Tracker

| Week | Dates | Theme | Status |
|---|---|---|---|
| Week 01 | Mar 9–11 | Linux CLI · Permissions · Stream Editing · Git | ✅ Complete |
| Week 02 | Mar 16–18 | Networking · Subnetting · Protocol Interrogation | ✅ Complete |
| Week 03 | Mar 23–25 | Python Scripting · Port Scanner · Brute Force Detector · Process Auditor | ✅ Complete |
| Week 04 | Mar 30–Apr 1 | Virtualization · Docker · Container Security | ⏳ Upcoming |

---

## Week 01 — Three Sessions

### S01 · Terminal Genesis
VM orientation, headless Linux, FHS navigation, CLI fundamentals, and Git/GitHub
setup. The TA bootstrap script (`setup_lab_01_jane.sh`) was built independently
as an additional practice lab — it mirrors FHS production directory conventions
and includes a five-point environment verification suite to catch provisioning
failures before they surface as student blockers.

→ `week-01/scripts/` · `week-01/docs/ta_analysis_s01.md`
```bash
# TA Reference Bootstrap
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

### S02 · The Keymaster
File permissions, `chmod`, `chown`, SUID auditing, and baseline system hardening.
The `harden.sh` script annotates each operation with its CIA Triad property and
NIST NICE framework mapping — making the script self-documenting for anyone who
needs to run or modify it without external reference.

→ `week-01/scripts/harden.sh` · `week-01/scripts/setup_lab_02_jane.sh` · `week-01/docs/ta_analysis_s02.md`
```bash
curl -sL https://gist.githubusercontent.com/grobbins-cell/8dea0f5a0c65b29efe0b91dd3afa6842/raw/698804520709884999cba0c54411303bff3ae6aa/setup_lab_02.sh | bash
```

---

### S03 · Stream Editing & Automation
`grep`, `sed`, `awk`, pipeline construction, and log interrogation. Students built
a forensic pipeline to extract attacker IPs from a simulated Apache access log under
SQL injection attack. The TA log generator produces 10,000 entries in full Apache
Combined Log Format with five randomized attacker IPs shuffled throughout — closer
to production forensic conditions than the class script's simplified format.

→ `week-01/scripts/setup_lab_03_jane.sh` · `week-01/artifacts/log_interrogation_pipeline.sh` · `week-01/docs/ta_analysis_s03.md`
```bash
grep "UNION SELECT" ~/access.log \
    | awk '{print $1}' \
    | sort | uniq \
    > ~/threat_ips.txt
```

---

### TLAB-01 · Operation Clean Sweep
Full synthesized incident response mission. Navigated a locked evidence directory,
repaired permissions, and extracted attacker IPs from a corrupted log file using a
multi-stage forensic pipeline. Deliverable: `final_threat_report.txt`.

→ `week-01/artifacts/final_threat_report.txt` · `week-01/docs/analysis_tlab01.md`

---

## Week 02 — Networking · Subnetting · Protocol Interrogation

### S04 · Operation Broken Link
Interface restoration and gateway diagnostics on a deliberately broken network
environment. Students restored a downed network interface, verified gateway
connectivity, and documented the full interface state. Key infrastructure
constraint: TKH office network uses MAC address whitelisting — VM internet
access blocked on-site. Lab designed offline-first as a result.

→ `week-02/artifacts/network_audit.txt`
```bash
ip addr show
sudo ip link set enp0s3 up
ip route show
ping -c 4 10.0.2.2
```

---

### S05 · Operation Grid Lock
Binary math, CIDR notation, network IDs, broadcast addresses, and usable host
ranges. Students calculated subnet parameters by hand before verifying with
`ipcalc`. The group chat analogy — a subnet as a boundary that determines who
can message whom directly — was the conceptual anchor for the session.

→ `week-02/artifacts/subnet_blueprint.txt`
```bash
ipcalc 10.50.50.1/26
# Network:   10.50.50.0
# Broadcast: 10.50.50.63
# Hosts:     62
```

---

### S06 · Operation Hidden Door
DNS poisoning, hidden services, and ports that should not be open. Students
used `ss`, `dig`, and `curl` to interrogate the protocol stack and identify
anomalies. Lab artifact captures the full port and protocol state of the VM
at the time of the audit.

→ `week-02/artifacts/protocol_audit.txt`
```bash
ss -tuln
dig google.com
curl -I localhost:8080
cat /etc/hosts
```

---

### TLAB-02 · Operation Blackout
Full synthesized network remediation mission across OSI Layers 3, 4, and 7.
Restored a sabotaged subnet mask, removed a malicious `/etc/hosts` DNS entry,
and captured a TCP 3-way handshake as forensic proof of restored connectivity.
Deliverable: `tlab_report.txt`.

→ `week-02/artifacts/tlab_report.txt` · `week-02/docs/analysis_tlab02.md`
```bash
sudo ip addr add 192.168.10.150/24 dev enp0s3
sudo ip route add default via 192.168.10.1
sudo tcpdump -i enp0s3 host 192.168.10.193 -n -c 10
```

---

## Week 03 — Python Scripting for Security Automation

### S07 · The Automation Forge — Port Scanner
No Nmap. Students wrote a TCP port scanner from scratch using Python's `socket`
module — building the capability from first principles before using tools that
abstract it away.

→ `week-03/artifacts/port_check.py`
```bash
python3 port_check.py
```

---

### S08 · The Paper Trail — Brute Force Detector
Parsed a simulated auth log using Python file I/O. Extracted every failed SSH
login attempt and wrote findings to a clean report automatically. Mirrors the
triage workflow a SOC analyst runs after a credential stuffing alert.

→ `week-03/artifacts/brute_detector.py` · `week-03/artifacts/brute_report.txt`
```bash
python3 brute_detector.py
```

---

### S09 · The Automation Pivot — Process Auditor & JSON Alerting
Gave Python the keys to the OS via `subprocess`. Enumerated running processes,
flagged an unauthorized cryptominer, and exported a structured JSON security
alert compatible with SIEM ingestion.

→ `week-03/artifacts/system_auditor.py` · `week-03/artifacts/incident_response.py` · `week-03/artifacts/security_alert.json`
```bash
python3 system_auditor.py
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
| **User Support Scale** | ~59 students · Class of 2026 |

---

## Core Concepts

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
- Commit message format: `edited: [filename]`

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Limoncelli, T. A., Hogan, C. J., & Chalup, S. R. (2016). *The practice of system and
network administration: DevOps and other best practices for enterprise IT* (3rd ed.).
Addison-Wesley.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.

Ortega, J. M. (2023). *Python for security and networking: Leverage Python modules
and tools in securing your network and applications* (3rd ed.). Packt Publishing.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.

---

**Built intentionally · Current Status: Updated Frequently · TKH IF 2026**