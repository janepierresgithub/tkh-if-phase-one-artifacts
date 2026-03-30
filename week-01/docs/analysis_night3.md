# Week 03 — Python Scripting for Security Automation
## TKH Innovation Fellowship · Phase 1 · Week 3
**Dates:** March 23–25, 2026
**Author:** Jane G. Pierre, Teaching Assistant
**Status:** Complete

---

## Overview

Week 03 shifted the program from CLI tools to Python scripting — giving students
the ability to automate the security tasks they performed manually in Weeks 01
and 02. Three sessions built progressively: socket programming for network
reconnaissance (S07), file I/O for forensic log analysis (S08), and subprocess
automation for process auditing and structured alerting (S09).

The deliverables from this week represent the first time students wrote tools
rather than used them.

---

## Session Breakdown

### S07 · The Automation Forge — Python Port Scanner

**Concept:** Network reconnaissance using raw Python sockets. No Nmap. No
external libraries. Just the `socket` module and `connect_ex()`.

**What students built:**
```python
import socket

targets = ["127.0.0.1", "8.8.8.8", "1.1.1.1", "10.0.0.1"]

for target in targets:
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    result = sock.connect_ex((target, 22))
    if result == 0:
        print(f"[OPEN]   {target}:22")
    else:
        print(f"[CLOSED] {target}:22")
    sock.close()
```

**Why it matters:** `connect_ex()` returns 0 on success and an error code on
failure — making it the correct method for non-exception-based port scanning.
This is the underlying mechanism Nmap uses before applying its service detection
layer. Understanding the socket layer demystifies what scanning tools actually do
(Ortega, 2023).

**CIA Triad connection:**
- **Confidentiality** — Port scanning reveals exposed attack surface. Every open
  port is a potential entry point.
- **Integrity** — Automated, repeatable scanning produces consistent results.
  Manual checks introduce human error.

**Artifact:** `port_check.py`

---

### S08 · The Paper Trail — Brute Force Detector

**Concept:** File I/O and string matching for forensic log analysis. Students
parsed a simulated auth log to extract failed SSH login attempts and write a
clean brute force report.

**What students built:**
```python
log_file = "/home/jane/auth_audit.log"
report_file = "/home/jane/brute_report.txt"

with open(log_file, "r") as f:
    lines = f.readlines()

failed = [line for line in lines if "Failed password" in line]

with open(report_file, "w") as f:
    for entry in failed:
        f.write(entry)

print(f"[*] {len(failed)} failed login attempts written to {report_file}")
```

**Why it matters:** SSH brute force attacks are one of the most common initial
access techniques against internet-facing Linux servers. Automated log parsing
is how Security Operations Center (SOC) analysts triage authentication events at
scale — the manual equivalent would take hours on a busy server. The `with open()`
pattern ensures file handles are closed properly even if an exception occurs,
which is critical when processing evidence files (Python Software Foundation, 2024).

**CIA Triad connection:**
- **Integrity** — Log files are evidence. Reading them without modifying them
  (`"r"` mode only) preserves chain of custody.
- **Availability** — Detecting brute force in progress allows defenders to block
  the attacker before a successful login disrupts service.

**Artifacts:** `brute_detector.py` · `brute_report.txt`

---

### S09 · The Automation Pivot — Process Auditor & JSON Alerting

**Concept:** `subprocess` module for OS command execution from Python, combined
with the `json` module for structured alert output. Students built a script that
interrogates running processes and exports a security alert in machine-readable
format.

**What students built:**
```python
import subprocess
import json

result = subprocess.run(
    ["ps", "aux"],
    capture_output=True,
    text=True
)

processes = result.stdout.splitlines()
flagged = [p for p in processes if "unauthorized_cryptominer" in p]

alert = {
    "event": "Unauthorized Process Detected",
    "severity": "High",
    "process": "unauthorized_cryptominer",
    "count": len(flagged)
}

with open("/home/jane/security_alert.json", "w") as f:
    json.dump(alert, f, indent=4)

print("[*] Alert written to security_alert.json")
```

**Why it matters:** `subprocess` gives Python the ability to run any system
command and capture its output programmatically — replacing the need for a human
operator to run commands manually and read the screen (Python Software Foundation,
2024). Exporting alerts as JSON is standard practice in modern security tooling:
SIEMs, EDR platforms, and SOAR systems all ingest structured JSON alerts. A script
that produces machine-readable output is immediately integrable into a real
security pipeline (Ortega, 2023).

**CIA Triad connection:**
- **Integrity** — `ps aux` is a read-only operation. The script observes without
  modifying the running system.
- **Availability** — Detecting an unauthorized cryptominer before it consumes all
  CPU prevents service degradation.
- **Confidentiality** — JSON output can be forwarded to a SIEM without exposing
  raw process data to unauthorized viewers.

**Artifacts:** `system_auditor.py` · `incident_response.py` · `security_alert.json` · `handshake.txt`

---

## The Automation Stack — Week 03 in Context

Week 03 completed the foundational automation loop:
```
Week 01 → Manual CLI tools    (grep, awk, sed)
Week 02 → Network diagnostics (ip, ipcalc, tcpdump)
Week 03 → Python automation   (socket, file I/O, subprocess, json)
              ↓
         Repeatable · Scalable · Machine-readable output
```

Every script students wrote this week can be scheduled via cron, triggered by
a monitoring system, or integrated into a larger pipeline. That is the shift
from operator to developer — the point where security skills become security
tooling.

---

## Key Concepts

### socket.connect_ex() vs socket.connect()

| Method | Behavior on Failure | Use Case |
|---|---|---|
| `connect()` | Raises exception | Interactive connections |
| `connect_ex()` | Returns error code | Port scanning — no exception handling needed |

### File I/O Modes

| Mode | Read | Write | Creates File | Truncates |
|---|---|---|---|---|
| `"r"` | ✅ | ❌ | ❌ | ❌ |
| `"w"` | ❌ | ✅ | ✅ | ✅ |
| `"a"` | ❌ | ✅ | ✅ | ❌ |
| `"r+"` | ✅ | ✅ | ❌ | ❌ |

For evidence files: always open in `"r"` mode. For report files: `"w"` to
overwrite or `"a"` to append.

### subprocess.run() Key Parameters
```python
subprocess.run(
    ["ps", "aux"],       # command as list — avoids shell injection
    capture_output=True, # capture stdout and stderr
    text=True            # return strings, not bytes
)
```

Never use `shell=True` with untrusted input — it opens a shell injection
vulnerability. Always pass commands as lists (Python Software Foundation, 2024).

### JSON as a Security Output Format
```python
import json

alert = {"event": "Brute Force", "severity": "High", "count": 47}

# Serialize to string
json_string = json.dumps(alert, indent=4)

# Write to file
with open("alert.json", "w") as f:
    json.dump(alert, f, indent=4)
```

JSON is the lingua franca of security tooling. Every major SIEM — Splunk,
Elastic, Microsoft Sentinel — ingests JSON natively. Writing alerts in JSON
makes student scripts immediately compatible with enterprise security
infrastructure (Python Software Foundation, 2024).

---

## TA Observations

- Students who struggled with `connect_ex()` were often confusing it with
  `connect()`. The key distinction: `connect_ex()` is for checking, `connect()`
  is for connecting. Framing it as "ex = exit code" helps.
- The `with open()` pattern trips students who are used to other languages.
  Emphasize that `with` handles closing automatically — including on exceptions.
- `subprocess.run()` with `capture_output=True` was the most satisfying moment
  of the week for most students. Seeing Python run a terminal command and capture
  the output lands as genuinely powerful.
- JSON output is the first time students produce something that looks
  "professional." Lean into this — it's the first artifact that could go directly
  into a real workflow.

---

## References

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
https://doi.org/10.6028/NIST.SP.800-181r1

Ortega, J. M. (2023). *Python for security and networking: Leverage Python
modules and tools in securing your network and applications* (3rd ed.).
Packt Publishing.

Python Software Foundation. (2024). *json — JSON encoder and decoder*.
Python 3 documentation. https://docs.python.org/3/library/json.html

Python Software Foundation. (2024). *subprocess — Subprocess management*.
Python 3 documentation. https://docs.python.org/3/library/subprocess.html

Python Software Foundation. (2024). *socket — Low-level networking interface*.
Python 3 documentation. https://docs.python.org/3/library/socket.html

---

*TKH Innovation Fellowship 2026 · Phase 1 · Week 03 · TA Notes · Jane G. Pierre*