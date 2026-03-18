# TLAB-01 — Operation Clean Sweep: Lab Analysis
## TKH Innovation Fellowship · Phase 1 · Week 1 · Synthesized Lab
**Date:** March 11, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Operation Clean Sweep was the Week 1 terminal lab — a synthesized incident
response scenario that required applying all three sessions of foundational
Linux work simultaneously. Unlike the individual session labs, this exercise
did not scaffold skills in isolation. Students had to navigate a non-standard
directory structure, repair broken permissions, and extract forensic evidence
from a corrupted log file — in sequence, without guidance between phases.

The deliverable was `final_threat_report.txt`: a deduplicated list of attacker
IP addresses extracted from a 5,000 line log file after navigating a locked
directory and repairing its permissions.

---

## Scenario

A server in the network was compromised. The attacker was removed but left
behind two problems before leaving:

1. A hidden directory at `/var/tmp/.evidence_cache` with permissions set to
   `000` — no access for anyone, including root-level users without `sudo`
2. A log file `raw_incident.log` inside that directory containing 5,000 lines
   of mixed traffic with `CRITICAL` entries buried throughout

Students had to find the directory, unlock it, take ownership of the log file,
and run a forensic pipeline to extract the attacker IPs — then save the result
as `final_threat_report.txt`.

---

## Skills Synthesized

| Phase | Session | Skill Applied |
|---|---|---|
| Phase 1 — The Maze | S01 Terminal Genesis | `ls /var/tmp/` to locate the hidden directory without entering it |
| Phase 2 — The Locksmith | S02 The Keymaster | `sudo chmod 500` on directory, `sudo chmod 400` on file, `sudo chown` to take ownership |
| Phase 3 — The Surgery | S03 Stream Editing | `grep`, `sed`, `awk`, `sort`, `uniq` pipeline to extract clean attacker IPs |

---

## The Full Workflow

**Phase 1 — Navigate to the evidence**
```bash
ls /var/tmp/
ls -la /var/tmp/.evidence_cache
```
The directory is visible but inaccessible — `000` permissions mean no read,
write, or execute for anyone. `ls` works from outside because the parent
directory `/var/tmp/` is readable. `cd` fails because execute on a directory
means the ability to enter it.

---

**Phase 2 — Repair the permissions**
```bash
# Grant execute (enter) + read on the directory
sudo chmod 500 /var/tmp/.evidence_cache

# Grant read-only on the log file
sudo chmod 400 /var/tmp/.evidence_cache/raw_incident.log

# Take ownership so the pipeline can process it
sudo chown jane /var/tmp/.evidence_cache/raw_incident.log
```

`chmod 500` = `r-x------` — owner can read and enter, nobody else can do
anything. This is the Principle of Least Privilege applied to evidence
handling: minimum access required to complete the task, nothing more.

---

**Phase 3 — Extract the forensic evidence**
```bash
grep "CRITICAL" /var/tmp/.evidence_cache/raw_incident.log \
    | sed 's/UserAgent: MalwareBot\/1.0//g' \
    | awk '{print $1}' \
    | sort | uniq \
    > ~/final_threat_report.txt
```

Each stage of the pipeline maps to a concept:

| Stage | Tool | What It Does |
|---|---|---|
| Filter | `grep "CRITICAL"` | Isolates attack entries from 5,000 lines of noise |
| Cleanse | `sed 's/UserAgent: MalwareBot\/1.0//g'` | Removes malware signature string from output |
| Extract | `awk '{print $1}'` | Pulls column 1 — the attacker IP address |
| Refine | `sort \| uniq` | Deduplicates — produces clean threat intelligence |
| Save | `>` | Redirects stdout to file — evidence preserved |

---

## Output

```
10.99.88.77
45.33.22.11
```

Two unique attacker IPs extracted from 5,000 lines of log data. The output
is suitable for input to a firewall rule, Fail2Ban, or a SIEM alert.

---

## CIA Triad Mapping

| Operation | CIA Property | Why It Matters |
|---|---|---|
| `ls` from outside locked directory | Integrity | Observe before touching — preserve evidence state |
| `chmod 500` on directory | Confidentiality | Minimum access — only what's needed to complete the task |
| `chmod 400` on log file | Confidentiality | Read-only — prevents accidental modification of evidence |
| `chown jane` | Integrity | Establishes clear chain of custody — attributed access |
| `grep \| sed \| awk \| sort \| uniq` | Integrity | Deterministic pipeline — same input always produces same output |
| `> final_threat_report.txt` | Integrity | Tamper-evident artifact — verifiable against the raw log |

---

## What This Lab Demonstrates

Operation Clean Sweep mirrors the first fifteen minutes of a real incident
response engagement. A junior analyst arrives at an unfamiliar system, finds
evidence locked behind broken permissions, repairs access carefully to avoid
disturbing the evidence, and extracts actionable intelligence from raw log
data. The deliverable goes directly to the team lead or into the ticket system.

The fact that this workflow — navigate, repair, extract, report — maps directly
to S01, S02, and S03 is not coincidental. It is the design principle behind
the TKH Phase 1 curriculum: every session builds a tool, and the terminal lab
proves you can use all the tools together.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.
