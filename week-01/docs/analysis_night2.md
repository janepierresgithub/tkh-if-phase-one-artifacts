# TA Session Notes — Session 02: The Access Control Matrix
## TKH Innovation Fellowship · Phase 1 · Week 1 · Night 2
**Date:** March 10, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Session 02 introduced the Linux permission model — the mechanism by which the
operating system enforces Confidentiality and Integrity at the file system level.
The class lab (The Broken Login) gave students a live misconfigured environment
to diagnose and fix. This document describes a supplemental TA implementation
— `setup_lab_02_jane.sh` — that creates an extended practice environment with
additional misconfigured targets for students who want more scenarios to work
through.

> **Class script:** `setup_lab_02.sh` (used live in session)
> **This repo:** `setup_lab_02_jane.sh` (TA supplemental implementation)

---

## The Core Scenario — The Broken Login

The class lab presented a realistic incident scenario: a junior admin ran a
recursive `chmod` on the wrong directory, leaving `/etc/shadow` world-readable
and world-writable. Students had to find the breach, fix it, verify it, and
automate the fix in a hardening script.

This is not a contrived exercise. Misconfigured `/etc/shadow` permissions are
a documented attack vector — if Others can read the shadow file, an attacker
can extract password hashes and crack them offline. The lab puts students in
the role of the responder, not the observer.

---

## Implementation Comparison

| Feature | Class Script | TA Implementation |
|---|---|---|
| **Primary target** | `/etc/shadow` | `~/SecureVault/` directory |
| **Breach type** | World-readable password hashes | World-readable sensitive config + log files |
| **SSH hardening** | Included | Included — misconfigured as 755 for practice |
| **SUID audit** | `/usr/bin` | `/usr/bin` and `/usr/sbin` |
| **Environment tone** | Incident response | Extended practice scenarios |
| **Verification** | Student-driven | Script prints current breach state on setup |

Both implementations teach the same core skill — reading and fixing file
permissions — applied to different targets.

---

## The Directory Trap

One of the most effective teaching moments in Session 02 was the execute bit
on directories. Students who understand `chmod 600` on files are often surprised
that the same value on a directory locks them out completely:

```bash
mkdir vault
chmod 600 vault
cd vault
# Permission denied — execute bit is what allows cd
```

The fix:
```bash
chmod 700 vault    # restore execute for owner
cd vault           # now works
```

This is a concrete demonstration of why execute means something different on
directories than on files — and why `chmod 700` is the standard for private
directories, not `chmod 600`.

---

## CIA Triad Mapping

Every `chmod` operation in tonight's lab maps to a CIA property:

| Operation | CIA Property | Why It Matters |
|---|---|---|
| `chmod 640 /etc/shadow` | Confidentiality | Password hashes readable only by root and shadow group |
| `sudo chown root:shadow /etc/shadow` | Integrity | Ownership ensures only root can modify |
| `chmod 700 ~/.ssh` | Confidentiality | SSH keys inaccessible to all other users |
| `chmod 600 ~/.ssh/authorized_keys` | Confidentiality | Private key material — owner read/write only |
| `chmod 700 ~/SecureVault` | Confidentiality | Sensitive directory — owner entry only |
| `chmod 600 ~/SecureVault/config.txt` | Confidentiality | Config with credentials — owner only |
| SUID audit | Integrity | Unexpected SUID binaries are privilege escalation paths |

---

## AAA Framework in Session 02

The permission system is a direct implementation of AAA:

| AAA Layer | Linux Implementation |
|---|---|
| **Authentication** | User identity established at login — uid/gid assigned by the kernel |
| **Authorization** | Permission bits (rwx) enforce what that identity can read, write, or execute |
| **Accounting** | `harden.sh` pushed to Git creates a timestamped, attributed record of every change |

Git as an accounting layer is not metaphorical here. Every `git commit` produces
a cryptographic hash that makes the hardening record tamper-evident — the same
property that makes version control a compliance tool in production environments.

---

## The harden.sh Artifact

The deliverable for tonight's lab was a hardening script that automates the fix.
The class template:

```bash
#!/bin/bash
# harden.sh — Security Hardening Script
# Author: [Your Name]
# TKH Innovation Fellowship 2026 · Phase 1 · Night 2

echo "Applying secure permissions..."
sudo chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
echo "Hardening complete."
```

Annotating each line with its CIA property — as done in the TA version — makes
the script self-documenting. A reader can understand both what it does and why
it matters without external reference.

---

## Octal Permission Quick Reference

| Code | Name | Meaning |
|---|---|---|
| `700` | Private | Owner: rwx. Group: none. Others: none. |
| `755` | Public script | Owner: rwx. Group: rx. Others: rx. |
| `644` | Standard file | Owner: rw. Group: r. Others: r. |
| `640` | Shadow file | Owner: rw. Group: r. Others: nothing. |
| `600` | Secret file | Owner: rw. No one else. |
| `777` | Open — dangerous | Everyone: rwx. Never intentional. |

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
