# Session 02 — Permissions & Hardening
## TKH Innovation Fellowship · Phase 1 · Week 1 · Night 2
**Date:** March 10, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Session Context

Session 02 built on the CLI navigation foundation from Night 1 and introduced
the Linux permission model — the mechanism by which the operating system enforces
the Confidentiality and Integrity pillars of the CIA Triad at the file system level.
Students moved from navigating a system to controlling who can access it.

---

## The Permission Model

Every file and directory in Linux has three permission sets — user, group, and other —
each with three bits: read (r), write (w), and execute (x).

```
-rwxrw-r--
 ↑↑↑↑↑↑↑↑↑
 │└──┘└──┘└──┘
 │ user group other
 └ file type (- = regular file, d = directory)
```

Reading permissions in octal notation:
- `700` = rwx------ = owner only
- `600` = rw------- = owner read/write only
- `640` = rw-r----- = owner read/write, group read only
- `644` = rw-r--r-- = owner read/write, everyone else read only

---

## CIA Triad Mapping

| Operation | CIA Property | Why It Matters |
|---|---|---|
| `chmod 700 ~/.ssh` | Confidentiality | SSH ignores keys in world-readable directories |
| `chmod 600 authorized_keys` | Confidentiality | Prevents attackers from adding their own key |
| `chmod 640 /etc/shadow` | Confidentiality + Integrity | Password hashes must not be readable or writable by regular users |
| SUID audit | Integrity | Unexpected SUID binaries are privilege escalation paths |
| `chmod 700 ~/Vault` | Confidentiality | Least privilege — sensitive data accessible only to owner |

---

## AAA Framework in Session 02

The permission system is a direct implementation of AAA:

- **Authentication** — User identity established at login (uid/gid assigned)
- **Authorization** — File permission bits (rwx) determine what that identity can do
- **Accounting** — `logger -t harden.sh` writes hardening events to syslog for audit trail

Making these mappings explicit in `harden.sh` comments is an intentional
instructional choice — it bridges the gap between the command and the concept.

---

## Key Commands Reference

```bash
# View permissions
ls -la ~/

# Change permissions (symbolic)
chmod u+x script.sh          # add execute for owner
chmod o-rwx sensitive.txt    # remove all access for others

# Change permissions (octal)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# Change ownership
sudo chown root:shadow /etc/shadow

# Find SUID binaries (audit, read-only)
find /usr/bin -perm -4000 2>/dev/null

# Log a hardening run to syslog
logger -t harden.sh "Hardening script executed by $USER"
```

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.
