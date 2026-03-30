# TA Analysis — Session 02: The Access Control Matrix
## TKH Innovation Fellowship — Phase 1, Week 1, Session 02
**Date:** March 10, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Two bootstrap scripts exist for Night 2: The Access Control Matrix. The session
script was used live in class to provision a broken environment for students to
diagnose and fix. A separate TA supplemental implementation was independently
developed to create an extended practice environment with additional misconfigured
targets. Both scripts successfully demonstrate permission violations that map
directly to the CIA Triad and give students hands-on remediation experience.

> **Class script:** `setup_lab_02.sh` (used live in session)
> **This repo:** `setup_lab_02_jane.sh` (TA supplemental implementation)

---

## Side-by-Side Comparison

| Feature | Class Script | TA Implementation |
|---|---|---|
| **Primary breach target** | `/etc/shadow` | `~/SecureVault/` directory |
| **Breach type** | World-readable password hashes | World-readable sensitive config + ops log |
| **Secondary target** | `~/.ssh` | `~/.ssh` — misconfigured to 755 |
| **Files created** | Broken environment only | SecureVault with config.txt, ops.log, README.txt |
| **SUID audit scope** | `/usr/bin` | `/usr/bin` and `/usr/sbin` |
| **Breach visibility** | Student must discover it | Script prints breach state on setup |
| **CIA mapping** | Implicit | Explicit inline comments |
| **NIST annotation** | Not included | OM-ADM-001, T0484 |
| **Error handling** | Standard | `set -e` exits on any failure |
| **Best used for** | Live class incident response lab | Extended independent practice |

---

## Analysis

### Class Script — Optimized for Incident Response

The session script delivers a focused, high-impact scenario: `/etc/shadow` has
been misconfigured to world-readable and world-writable — a realistic breach that
maps directly to a documented attack vector. If Others can read `/etc/shadow`, an
attacker can extract every password hash on the system and crack them offline.

The single-target approach is intentional. On Night 2, students are encountering
`chmod` for the first time. Isolating the breach to one critical file — the most
sensitive file on a Linux system — builds clarity and confidence before complexity
is introduced. Students leave with one fix memorized: `chmod 640 /etc/shadow`.

### TA Implementation — Extended Practice Scenarios

The supplemental script creates a `~/SecureVault/` directory populated with a
realistic config file (database credentials, API keys marked REDACTED) and an
operations log showing a brute force detection event. Both files are intentionally
misconfigured to `777` — world-readable and world-writable.

This gives students additional targets to practice on after completing the class
lab. The config file scenario mirrors a common real-world finding: sensitive
application credentials stored in a file with overly permissive access. The ops
log scenario introduces the idea that log files themselves are sensitive — an
attacker with read access to logs can map the environment before launching an
attack.

---

## The Remediation Workflow

Both scripts teach the same four-step workflow:

```bash
# Step 1 — Find the breach
ls -la /etc/shadow          # class target
ls -la ~/SecureVault/       # TA target

# Step 2 — Fix the permissions
sudo chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow

chmod 700 ~/SecureVault
chmod 600 ~/SecureVault/config.txt
chmod 600 ~/SecureVault/ops.log
chmod 700 ~/.ssh

# Step 3 — Verify
ls -la /etc/shadow
ls -la ~/SecureVault/

# Step 4 — Automate the fix
nano ~/harden.sh
chmod +x ~/harden.sh
./harden.sh
```

The deliverable is the same regardless of which script provisioned the environment:
a `harden.sh` pushed to GitHub that automates the fix and serves as a portfolio
artifact.

---

## Which Script Gets Used When

| Context | Script |
|---|---|
| **Live class — student VM provisioning** | Class script (`setup_lab_02.sh`) |
| **TA dry-run before class** | TA implementation (`setup_lab_02_jane.sh`) |
| **Students wanting extra practice** | TA implementation (`setup_lab_02_jane.sh`) |
| **TA portfolio reference** | Both |
| **Student portfolio push artifact** | `harden.sh` — output of either lab |

---

## Key Takeaway

Both scripts teach the same foundational skill — reading a permission violation,
understanding why it matters, and automating the fix. The class script delivers
maximum impact in minimum time with a single high-stakes target. The TA
implementation extends the practice surface with additional scenarios that mirror
real-world findings. Together they cover the full range of what a junior analyst
or systems administrator encounters when auditing file permissions on a live system.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
