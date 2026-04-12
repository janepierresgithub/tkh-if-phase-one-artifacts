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
│   ├── tlab03/
│   │   └── incident_response.py     # TLAB-03 — Operation Automated Hunt
│   └── docs/
│       └── NOTES.md                 # Week 03 — Python scripting concept reference
│
├── week-04/
│   ├── sandbox_report.txt           # S10 — VM isolation verification
│   ├── deploy_web.sh                # S11 — disposable nginx deployment script
│   ├── docker-compose.yml           # S12 — air-gapped WordPress + MySQL stack
│   ├── docker-compose-tlab4.yml     # TLAB-04 — three-tier MariaDB stack
│   └── hyperstack_audit.json        # TLAB-04 — machine-readable audit report
│
└── README.md

---

## Week Tracker

| Week | Dates | Theme | Status |
|---|---|---|---|
| Week 01 | Mar 9–11 | Linux CLI · Permissions · Stream Editing · Git | ✅ Complete |
| Week 02 | Mar 16–18 | Networking · Subnetting · Protocol Interrogation | ✅ Complete |
| Week 03 | Mar 23–25 | Python Scripting · Port Scanner · Brute Force Detector · Process Auditor | ✅ Complete |
| Week 04 | Mar 30–Apr 1 | Virtualization · Docker · Container Security · Network Segmentation | ✅ Complete |
| Week 05 | Apr 6–8 | Identity · Active Directory · Windows Server Core | ⏳ In Progress |

---

## Week 01 — Linux Foundations & Version Control

### S01 · Terminal Genesis
VM orientation, headless Linux, FHS navigation, CLI fundamentals, and Git/GitHub
setup. The TA bootstrap script was built independently as an additional practice
lab — it mirrors FHS production directory conventions and includes a five-point
environment verification suite to catch provisioning failures before they surface
as student blockers.

→ `week-01/scripts/` · `week-01/docs/ta_analysis_s01.md`
```bash
curl -s https://gist.githubusercontent.com/janepierresgithub/5c7caec85fc26d272f43df34c8dbe4f3/raw/setup_lab_01.sh | bash
```

---

### S02 · The Keymaster
File permissions, `chmod`, `chown`, SUID auditing, and baseline system hardening.
The `harden.sh` script annotates each operation with its CIA Triad property and
NIST NICE framework mapping — making the script self-documenting for anyone who
needs to run or modify it without external reference.

→ `week-01/scripts/harden.sh` · `week-01/docs/ta_analysis_s02.md`
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
sudo chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow
```

---

### S03 · Stream Editing & Automation
`grep`, `sed`, `awk`, pipeline construction, and log interrogation. Students built
a forensic pipeline to extract attacker IPs from a simulated Apache access log under
SQL injection attack. The TA log generator produces 10,000 entries in full Apache
Combined Log Format with five randomized attacker IPs — closer to production
forensic conditions than the class script's simplified format.

→ `week-01/scripts/setup_lab_03_jane.sh` · `week-01/artifacts/log_interrogation_pipeline.sh`
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
connectivity, and documented the full interface state.

→ `week-02/artifacts/network_audit.txt`
```bash
sudo ip link set enp0s3 up
sudo ip route add default via 10.0.2.2
ping -c 4 10.0.2.2
```

---

### S05 · Operation Grid Lock
Binary math, CIDR notation, network IDs, broadcast addresses, and usable host
ranges. Students calculated subnet parameters by hand before verifying with
`ipcalc`.

→ `week-02/artifacts/subnet_blueprint.txt`
```bash
ipcalc 10.50.50.1/26
# Network: 10.50.50.0 · Broadcast: 10.50.50.63 · Hosts: 62
```

---

### S06 · Operation Hidden Door
DNS poisoning, hidden services, and ports that should not be open. Students used
`ss`, `dig`, and `curl` to interrogate the protocol stack and identify anomalies.

→ `week-02/artifacts/protocol_audit.txt`
```bash
ss -tuln
dig google.com
cat /etc/hosts
```

---

### TLAB-02 · Operation Blackout
Full synthesized network remediation mission across OSI Layers 3, 4, and 7.
Restored a sabotaged subnet mask, removed a malicious `/etc/hosts` DNS entry,
and captured a TCP 3-way handshake as forensic proof of restored connectivity.

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
abstract it away. Understanding what Nmap does under the hood before ever running it.

→ `week-03/artifacts/port_check.py`
```bash
python3 port_check.py
```

---

### S08 · The Paper Trail — Brute Force Detector
Parsed a simulated auth log using Python file I/O. Extracted every failed SSH
login attempt and wrote findings to a clean report automatically. Mirrors the
triage workflow a SOC analyst runs after a credential stuffing alert fires.

→ `week-03/artifacts/brute_detector.py` · `week-03/artifacts/brute_report.txt`
```bash
python3 brute_detector.py
# Output: brute_report.txt — 4 attack signatures identified
```

---

### S09 · The Automation Pivot — Process Auditor & JSON Alerting
Gave Python the keys to the OS via `subprocess`. Enumerated running processes,
flagged an unauthorized cryptominer, and exported a structured JSON security alert
compatible with SIEM ingestion.

→ `week-03/artifacts/system_auditor.py` · `week-03/artifacts/security_alert.json`
```bash
python3 system_auditor.py
# Output: security_alert.json — severity High · process flagged
```

---

### TLAB-03 · Operation Automated Hunt
Automated incident response pipeline built entirely in Python. Used `subprocess`
to run `grep` programmatically against a simulated auth log, parsed raw output
line by line to extract attacker IPs, and exported a structured JSON alert ready
for SIEM ingestion. First full SOAR-style automation pipeline built from scratch.

**Cybersecurity principle:** SOAR — Security Orchestration, Automation and Response.
The pipeline mirrors what Splunk SOAR and Palo Alto XSOAR do at enterprise scale.

→ `week-03/tlab03/incident_response.py`
```bash
python3 incident_response.py
# Output: threat_report.json
# Attacker IPs: ['192.168.1.55', '172.16.0.4', '192.168.1.55', '10.0.0.99']
```

---

## Week 04 — Virtualization · Docker · Container Security

### S10 · Sandbox Detonation
Configured a Host-Only network adapter in VirtualBox to air-gap the VM from the
internet before detonating a simulated malware payload. Documented the isolation
verification process and explained why Bridged mode is never acceptable for malware
analysis environments. If the sandbox leaks, malware can spread to every device
on the local network.

→ `week-04/sandbox_report.txt`
```bash
ping -c 4 google.com
# Success state: Network unreachable — sandbox confirmed isolated
```

---

### S11 · The Disposable Web Server
Deployed, modified, and destroyed an nginx container using Docker. Demonstrated
the full container lifecycle — pull, run, exec, modify, log audit, stop, remove —
and automated the deployment sequence in a reusable bash script. Containers leave
no footprint once destroyed. That is the security advantage over traditional VMs.

→ `week-04/deploy_web.sh`
```bash
docker run -d --name training-web -p 8080:80 nginx
docker exec -it training-web bash
docker stop training-web && docker rm training-web
```

---

### S12 · The Air-Gapped Stack
Deployed a WordPress + MySQL multi-container stack using Docker Compose with
explicit network segmentation. WordPress connected to both `frontend` and `backend`
networks. MySQL isolated to `backend` only with `internal: true` — provably
air-gapped from the internet. Verified isolation by testing outbound connectivity
from inside each container.

**Cybersecurity principle:** Defense in Depth — if WordPress is compromised, the
attacker is trapped. The database has no route out.

→ `week-04/docker-compose.yml`
```bash
docker-compose up -d
docker-compose exec wordpress bash  # curl google.com → 301 response (internet access confirmed)
docker-compose exec db bash         # curl google.com → timeout (air-gap confirmed)
```

---

### TLAB-04 · Operation Fortified Node
Capstone of Week 4. Evicted a rogue `decoy_web` container occupying Port 80,
built a three-tier WordPress + MariaDB Docker Compose stack from scratch with
`public_net` and `private_net` segmentation, verified port isolation with nmap,
tested container-to-VM network isolation, and produced a machine-readable JSON
audit report documenting all findings with real values — no placeholders.

**Cybersecurity principle:** Security Architecture Verification — it is not enough
to configure controls. You must prove they work. An untested control is an assumption.

→ `week-04/docker-compose-tlab4.yml` · `week-04/hyperstack_audit.json`
```bash
nmap -p 80,3306 localhost
# Port 80: open · Port 3306: closed — network segmentation verified
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
| **Containers** | Docker · Docker Compose |
| **User Support Scale** | ~58 Fellows · Class of 2026 |

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

### Defense in Depth
No single security control is sufficient. The container network architecture in
Week 04 layers multiple controls — network segmentation, internal-only routing,
and port isolation — so that a breach of one layer does not mean a breach of all.

### SOAR — Security Orchestration, Automation and Response
The Python scripts in Week 03 and TLAB-03 demonstrate the foundational logic of
SOAR platforms: ingest a log source, apply a detection rule, extract indicators
of compromise, and export a structured alert. Built by hand first so the
abstraction layers of enterprise tools make sense.

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