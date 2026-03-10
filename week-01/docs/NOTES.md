# 🛡️ Week 01 — Security Foundations: Navigation, Access Control & Hardening

![Week](https://img.shields.io/badge/Week-01-4a6fa5?style=flat-square)
![Dates](https://img.shields.io/badge/Dates-March%209--11%2C%202026-6b4c2a?style=flat-square)
![Status](https://img.shields.io/badge/Status-Complete-4a7c59?style=flat-square)
![Role](https://img.shields.io/badge/Role-Cybersecurity%20TA-b5451b?style=flat-square)

---

## Overview

Week 01 introduced students to the Linux headless environment through two core competencies: filesystem navigation (Night 1) and access control (Night 2). Three distinct bootstrap scripts were developed and deployed across both nights — each one purpose-built for a specific learning objective.

This document captures what was taught, why it matters professionally, and the cybersecurity concepts each lab connects to in the real world.

---

## The Three Bootstrap Scripts

### Script 1 — `setup_lab_01.sh` (Her TA Prep Version)
**Author:** Jane G. Pierre (TA) | **Gist:** janepierresgithub  
**Purpose:** TA dry run and environment validation before Night 1

This script was written independently to verify the lab environment prior to class. It builds the same scavenger hunt maze as Lead Instructor's official version but uses different directory and file names.

**What it builds:**
```bash
/opt/alpha/mission.txt          # Mission briefing file
/var/tmp/.mission_cache/        # Hidden directory (dot prefix)
/var/tmp/.mission_cache/intel.txt  # Token file inside hidden dir
/var/log/syslog                 # System log (touch)
```

**Key difference from official version:** Hidden folder is `.mission_cache` vs `.blackout`. Same skill taught — the names differ. Students who ran Lead Instructor's script look for `.blackout`.

**Cybersecurity concept:** Hidden files and directories (dot-prefix) are commonly used in Linux for configuration files and caches. Understanding how to reveal them with `ls -a` is foundational enumeration skill — used in both system administration and penetration testing.

---

### Script 2 — `setup_lab_01.sh` (Lead Instructor's Official Night 1)
**Author:** Lead Instructor | **Gist:** [lead-instructor-gist]  
**Purpose:** Official student Night 1 deployment — The Scavenger Hunt

This is the script students ran in class. It builds a more complete mission scenario with a retrievable token and secret message that students copy into their `discovery.txt` artifact.

**What it builds:**
```bash
/opt/alpha/mission.txt               # "MISSION SECURE: Operation Blackout..."
/var/tmp/.blackout/                  # Hidden directory
/var/tmp/.blackout/token.txt         # Token for students to copy
/var/log/syslog                      # System log
/var/log/auth.log                    # Auth log (added vs. her version)
```

**Expected student artifact — `discovery.txt`:**
```
Log Path: /var/log/syslog
Mission Path: /opt/alpha/mission.txt
Mission Secret: [MISSION SECURE message]
Token Path: /var/tmp/.blackout/token.txt
Token Secret: [TOKEN number]
```

**Cybersecurity concept:** This lab directly models the **Reconnaissance** phase of the Cyber Kill Chain. Analysts on unfamiliar systems enumerate what exists, where it lives, and document findings as evidence. The `discovery.txt` artifact mirrors a real **field notes document** from a security assessment.

> **Real world connection:** During a cloud security audit or incident response engagement, analysts SSH into servers they've never seen before and begin exactly this process — `ls`, `cat`, `cd` — building a mental map of the system. The Filesystem Hierarchy Standard (FHS) is the framework that makes this consistent across Linux systems (Linux Foundation, 2015).

---

### Script 3 — `setup_lab_02.sh` (Lead Instructor's Official Night 2)
**Author:** Lead Instructor | **Gist:** [lead-instructor-gist]  
**Purpose:** Official student Night 2 deployment — The Access Control Matrix

This script is architecturally different from the Night 1 scripts. Instead of hiding things for students to find, it **intentionally misconfigures the system** to simulate a real security incident. Students must diagnose and remediate.

**What it builds (and breaks):**
```bash
~/top_secret.txt       # chmod 444 — read-only for everyone
~/Vault/               # chmod 000 — completely locked directory
~/Vault/secrets.txt    # chmod 000 — completely locked file
/etc/shadow            # chmod 777, chown cyrus:cyrus — CRITICAL BREACH
~/harden.sh            # Template for students to complete
```

**Execution command:**
```bash
curl -sL https://gist.githubusercontent.com/[lead-instructor-gist]/8dea0f5a0c65b29efe0b91dd3afa6842/raw/698804520709884999cba0c54411303bff3ae6aa/setup_lab_02.sh | bash
```

**Cybersecurity concept:** This lab models a real **security incident response** workflow. The `/etc/shadow` misconfiguration is not theoretical — world-readable password hashes are a critical finding in real penetration tests and security audits.

> **Real world connection:** According to Boelen (2025), if `/etc/shadow` permissions are accidentally set to a world-readable value, it completely negates the file's security purpose, as any user on the system could then access the encrypted password hashes. This is a known attack vector for offline credential cracking using tools like Hashcat.

---

## Cybersecurity Concepts Covered — Week 01

### 1. The Filesystem Hierarchy Standard (FHS)
The FHS defines the directory structure and directory contents in Linux distributions (Linux Foundation, 2015). Understanding why `/var/log` holds logs, `/opt` holds optional software, and `/etc` holds configuration is not academic — it is how security analysts navigate unfamiliar systems quickly without getting lost.

### 2. The Principle of Least Privilege
Every file on a Linux system has a permission structure built on User, Group, and Others — each with Read (4), Write (2), and Execute (1) access. The principle of least privilege states that every user and process should have only the minimum permissions required to do their job (SUSE, 2025).

`chmod 640 /etc/shadow` is least privilege in practice:
- Root can read and write (needs to for authentication)
- Shadow group can read (needs to for login validation)
- Everyone else gets nothing

### 3. Access Control — The Octal Model
Linux permissions are expressed as three-digit octal values. Each digit represents the permission sum for one group:

| Digit | Group | Abilities | Octal Math |
|-------|-------|-----------|------------|
| 7 | Owner | Read + Write + Execute | 4+2+1 = 7 |
| 5 | Group | Read + Execute | 4+0+1 = 5 |
| 4 | Others | Read only | 4+0+0 = 4 |

### 4. The Directory Execute Bit
Unlike files, a directory requires the Execute (`x`) bit to allow traversal with `cd`. This is one of the most counterintuitive concepts in Linux permissions and a frequent source of real-world misconfiguration errors.

`chmod 600 vault` + `cd vault` = `Permission Denied`  
`chmod 700 vault` + `cd vault` = ✅

### 5. SUID — Set User ID
SUID files run with the permissions of the file owner rather than the user executing them. This is how `/usr/bin/passwd` allows standard users to update their own password hash in `/etc/shadow` without having root access (nixCraft, 2025).

SUID is a legitimate mechanism — but a malicious or misconfigured SUID binary is a critical privilege escalation vector. The audit command:
```bash
find /usr/bin -perm -4000
```
...is a standard step in both hardening procedures and penetration tests.

### 6. Security Hardening Automation
Writing `harden.sh` is not just a classroom exercise. In production environments, security teams apply permission baselines across hundreds or thousands of servers simultaneously. This is called **configuration hardening** and is a core DevSecOps practice (SUSE, 2025).

---

## Artifacts Produced — Week 01

| Night | Artifact | Location | Description |
|-------|----------|----------|-------------|
| Night 1 | `discovery.txt` | `~/tkh-p1-practice/week-01/` | Scavenger hunt field notes |
| Night 2 | `harden.sh` | `~/tkh-p1-practice/week-01/` | Security hardening script |

---

## TA Lessons Learned

- Lead Instructor's Night 1 script uses `.blackout` as the hidden directory — not `.mission_cache`. Confirm which script students ran before reviewing their `discovery.txt` paths.
- The directory execute bit is the highest-friction concept this week. Plant the seed in the opening analogy before the lab — students who hear it twice retain it.
- `sudo` is required for `/etc/shadow` operations. Students who forget will get `Operation not permitted`. Redirect to their own understanding: *"What command acts as the master key?"*
- `chmod +x` before `./harden.sh` — scripts are created as text files. Students frequently hit Permission Denied on their own script.

---

## References

Boelen, M. (2025, March 12). *File permissions of the /etc/shadow password file*. Linux Audit. https://linux-audit.com/file-permissions-of-the-etc-shadow-password-file/

DevOps Training Institute. (2025, August 16). *What is the use of the /etc/shadow file in Linux user authentication?* https://www.devopstraininginstitute.com/blog/what-is-the-use-of-the-etcshadow-file-in-linux-user-authentication

Linux Foundation. (2015). *Filesystem Hierarchy Standard, version 3.0*. https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf

nixCraft. (2025, December 19). *Understanding /etc/shadow file format on Linux*. Cyberciti. https://www.cyberciti.biz/faq/understanding-etcshadow-file/

SUSE. (2025, October 27). *Linux hardening: The complete guide to securing your systems*. SUSE Communities. https://www.suse.com/c/linux-hardeningthe-complete-guide-to-securing-your-systems/

WafaTech. (2025, March 14). *Securing /etc/shadow and /etc/passwd: Best practices for Linux server protection*. WafaTech Blogs. https://wafatech.sa/blog/linux/linux-security/securing-etc-shadow-and-etc-passwd-best-practices-for-linux-server-protection/

---

*TKH Innovation Fellowship 2026 · Phase 1 · Week 01 · TA Notes · Jane G. Pierre*
