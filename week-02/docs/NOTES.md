# Week 02 — Networking · Subnetting · Protocol Interrogation
## TKH Innovation Fellowship · Phase 1 · Week 2
**Dates:** March 16–18, 2026
**Author:** Jane G. Pierre, Teaching Assistant
**Status:** Complete

---

## Overview

Week 02 moved students from the file system into the network stack. Three
sessions built progressively: interface restoration and gateway diagnostics
(S04), subnet mathematics and CIDR notation (S05), and DNS interrogation
with hidden service discovery (S06). The terminal lab synthesized all three
into a full network remediation mission under simulated attack conditions.

The OSI model was the conceptual backbone of the week — each session targeted
a specific layer and the terminal lab required students to work across all
three simultaneously.

---

## Session Breakdown

### S04 · Operation Broken Link — Network Interface Restoration

**OSI Layer:** Layer 1 (Physical) and Layer 3 (Network)

**Scenario:** The primary network interface is down. The VM has no IP, no
route, and no gateway. Restore connectivity layer by layer.

**What students did:**
```bash
# Verify the void
ping -c 4 8.8.8.8           # connect: Network is unreachable

# Layer 1 — bring the interface up
ip link show                 # find the interface, check state
sudo ip link set enp0s3 up  # open the pipe

# Layer 3 — verify addressing and routing
ip addr show                 # confirm IP assigned
ip route show                # confirm default gateway
ping -c 4 10.0.2.2          # verify gateway reachable

# Document the state
ip route > ~/network_audit.txt
```

**Why it matters:** Network interface failures are one of the most common
causes of server unreachability in production environments. A VM that appears
"dead" is often simply disconnected at Layer 1 or missing a default route at
Layer 3. Working through the stack systematically — physical first, then
logical — is the diagnostic methodology that separates experienced operators
from those who guess (Tanenbaum & Wetherall, 2011).

**CIA Triad connection:**
- **Availability** — A downed interface means the host is unreachable. Restoring
  it restores service availability — the third pillar of the CIA Triad.
- **Integrity** — Documenting the restored state in `network_audit.txt` creates
  a verifiable record of the configuration at the time of remediation.

**Artifact:** `network_audit.txt`

---

### S05 · Operation Grid Lock — Subnetting & CIDR

**OSI Layer:** Layer 3 (Network)

**Scenario:** The interface is up but the gateway is unreachable. The subnet
mask has mathematically isolated the host from its gateway.

**What students did:**
```bash
# Identify the problem
ip addr show                     # current: 10.50.50.150/26
ipcalc 10.50.50.150/26          # HostMin: .129, HostMax: .190
                                 # gateway .1 is NOT in this range

# Binary conversion to understand the /26 boundary
python3 -c "print(bin(150))"    # 0b10010110
                                 # /26 locks first two bits: 10xxxxxx
                                 # .1 = 00000001 — outside the fence

# Fix — expand the subnet to include the gateway
sudo ip addr del 10.50.50.150/26 dev enp0s3
sudo ip addr add 10.50.50.150/24 dev enp0s3
ping -c 4 10.50.50.1            # gateway now reachable
```

**Why it matters:** Subnet misconfiguration is a silent failure mode — the
interface shows UP, the IP looks correct, but hosts on the same physical
network cannot communicate because the mathematical fence excludes them. CIDR
notation encodes both the address and the boundary in a single value, making
it essential for anyone configuring or diagnosing network interfaces
(Tanenbaum & Wetherall, 2011).

**The group chat analogy:** A subnet is a group chat. A `/26` is a small
group chat — only 62 members. If the gateway isn't in the chat, you can't
reach it. Widening to `/24` adds 254 members — including the gateway at `.1`.

**Subnet Quick Reference:**

| CIDR | Subnet Mask | Usable Hosts | Use Case |
|---|---|---|---|
| `/24` | 255.255.255.0 | 254 | Standard LAN |
| `/26` | 255.255.255.192 | 62 | Small segment |
| `/27` | 255.255.255.224 | 30 | Very small segment |
| `/30` | 255.255.255.252 | 2 | Point-to-point link |

**CIA Triad connection:**
- **Availability** — Correct subnetting ensures hosts can reach their gateway
  and communicate beyond their local segment.
- **Integrity** — `ipcalc` provides mathematical verification of subnet
  parameters — no guessing, no assumptions.

**Artifact:** `subnet_blueprint.txt`

---

### S06 · Operation Hidden Door — Protocol Interrogation

**OSI Layer:** Layer 7 (Application)

**Scenario:** Connectivity is restored. Now deal with the deception layer.
An adversary has poisoned DNS and hidden a local service on an unexpected port.

**What students did:**
```bash
# Phase 1 — The Lying Phonebook
curl -I google.com              # Server: nginx — Google doesn't run nginx
cat /etc/hosts                  # found: 127.0.0.1 google.com
sudo nano /etc/hosts            # remove the malicious entry
dig google.com                  # verify real public IPs now returned

# Phase 2 — The Hidden Door
ss -tuln                        # list all listening TCP/UDP sockets
                                 # found: tcp LISTEN 0.0.0.0:8080
curl -I localhost:8080          # Server: nginx/1.24.0 (Ubuntu)
```

**Why it matters:** DNS poisoning via `/etc/hosts` is one of the simplest
and most effective host-based attacks. Because `/etc/hosts` is checked before
DNS, a single malicious line can silently redirect any hostname to an
attacker-controlled server — no network access required once the attacker
has local access (Chapple et al., 2021). `ss -tuln` is the first command a
responder runs when auditing a system after a compromise — every listening
socket is an exposed attack surface that requires explanation.

**CIA Triad connection:**
- **Integrity** — A poisoned `/etc/hosts` silently corrupts name resolution.
  Removing it restores the integrity of the system's lookup chain.
- **Confidentiality** — An unknown listener on port 8080 is an unexplained
  attack surface. Identifying and documenting it is the first step toward
  understanding what data it may be exposing.

**Artifact:** `protocol_audit.txt`

---

### TLAB-02 · Operation Blackout — Full Stack Remediation

**OSI Layers:** 3 (Network) · 4 (Transport) · 7 (Application)

**Scenario:** A sophisticated actor has sabotaged the VM at multiple OSI
layers simultaneously. The primary SSH connection drops. Students must pivot
to Out-of-Band (OOB) access and restore the environment layer by layer.

**What the sabotage script did:**
- Replaced the correct `/24` subnet mask with a restrictive `/26` — cutting
  off the gateway at Layer 3
- Poisoned `/etc/hosts` with a malicious entry redirecting
  `secure.titancorp.com` to `10.99.99.99` — corrupting DNS at Layer 7

**The remediation workflow:**
```bash
# Layer 3 — Subnet Remediation
ipcalc 192.168.10.150/26        # verify boundary excludes gateway
sudo ip addr del 192.168.10.150/26 dev enp0s3
sudo ip addr add 192.168.10.150/24 dev enp0s3
sudo ip route add default via 192.168.10.1
ip route show                    # confirm: default via 192.168.10.1

# Layer 7 — DNS Remediation
cat /etc/hosts                   # locate: 10.99.99.99 secure.titancorp.com
sudo nano /etc/hosts             # remove the malicious entry
grep "titancorp" /etc/hosts      # verify: no output = clean

# Layer 4 — Handshake Proof
sudo tcpdump -i enp0s3 host 192.168.10.193 -n -c 10 &
curl http://secure.titancorp.com
# Evidence: Flags [S] → Flags [S.] → Flags [.]
```

**Why it matters:** Real incident response rarely involves a single broken
thing. Attackers layer their sabotage — fixing one layer while another remains
broken can make diagnosis harder because symptoms from multiple failures
overlap. Working through the OSI model in order — physical, network,
transport, application — is the systematic approach that prevents chasing
symptoms instead of causes (Tanenbaum & Wetherall, 2011).

**Out-of-Band (OOB) Access:** When the primary SSH connection drops, the
VirtualBox console window becomes the OOB management interface — equivalent
to iDRAC (Dell) or iLO (HP) in enterprise environments. It bypasses the
network entirely, connecting directly to the VM through the hypervisor.

**CIA Triad connection:**

| Operation | CIA Property | Why It Matters |
|---|---|---|
| Subnet mask restoration | Availability | Host unreachable until gateway is reachable |
| `/etc/hosts` remediation | Integrity | Poisoned DNS silently corrupts name resolution |
| TCP handshake capture | Integrity | Tamper-evident forensic proof of restored connectivity |
| `tlab_report.txt` → Git | Integrity | Timestamped, attributed evidence artifact |

**Artifact:** `tlab_report.txt`

---

## The OSI Model — Week 02 in Context
```
Layer 7 — Application   S06 · DNS poisoning · /etc/hosts · curl · dig
Layer 4 — Transport     TLAB · tcpdump · TCP 3-way handshake · [S][S.][.]
Layer 3 — Network       S04 · ip addr · ip route · S05 · ipcalc · CIDR
Layer 1 — Physical      S04 · ip link · interface state · UP/DOWN
```

Week 02 touched four of the seven OSI layers. Each session added a diagnostic
tool that targets a specific layer — and the terminal lab proved students could
use all the tools together when the failure spans multiple layers simultaneously.

---

## Key Commands Reference
```bash
# Layer 1/2 — Interface management
ip link show                          # list interfaces and state
sudo ip link set enp0s3 up           # bring interface up

# Layer 3 — IP addressing and routing
ip addr show                          # show IP addresses
sudo ip addr add 10.0.0.1/24 dev enp0s3   # assign IP
sudo ip addr del 10.0.0.1/26 dev enp0s3   # remove IP
ip route show                         # show routing table
sudo ip route add default via 10.0.2.2    # add default gateway
ipcalc 10.50.50.150/26               # calculate subnet parameters

# Layer 4 — Transport layer inspection
sudo tcpdump -i enp0s3 -n -c 10      # capture 10 packets
sudo tcpdump -i enp0s3 host 8.8.8.8  # filter by host

# Layer 7 — Application layer interrogation
cat /etc/hosts                        # view local DNS overrides
dig google.com                        # DNS lookup
curl -I localhost:8080                # probe HTTP service header
ss -tuln                              # list all listening sockets
```

---

## TCP 3-Way Handshake

The handshake is the foundation of every TCP connection. Before any data
transfers, both sides must agree to communicate:
```
Client                    Server
  │                          │
  │──── SYN [S] ────────────►│  "I want to connect"
  │                          │
  │◄─── SYN-ACK [S.] ────────│  "I'm ready, you?"
  │                          │
  │──── ACK [.] ────────────►│  "Let's go"
  │                          │
  │         [DATA]           │  Connection established
```

`tcpdump` captures each step as a timestamped packet with flag annotations.
The `[S]`, `[S.]`, and `[.]` flags are the forensic signature of a successful
connection establishment — proof that the full network stack is functioning
end to end (Tanenbaum & Wetherall, 2011).

---

## TA Observations

- The subnet trap (`/26` excluding the gateway) is the highest-friction concept
  of the week. Students who understand it intellectually still struggle to see
  why `.1` is excluded until they run `ipcalc` and look at the HostMin/HostMax
  range. Always run `ipcalc` before explaining — the output makes the boundary
  visible.
- The group chat analogy for subnets lands better than binary explanation for
  most students. Lead with the analogy, then show the math.
- `/etc/hosts` poisoning is the most alarming moment for students who haven't
  considered host-based attacks before. The realization that a single line in a
  text file can silently redirect any hostname — no network access needed — is
  a genuine security awakening.
- OOB access via the VirtualBox console was unfamiliar to most students. Framing
  it as "the physical keyboard plugged into the server" lands immediately.
- `ss -tuln` is a command students forget the flags for. Mnemonic: **t**cp,
  **u**dp, **l**istening, **n**umeric. Say it out loud once and it sticks.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified
information systems security professional official study guide* (9th ed.).
Sybex.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.
https://doi.org/10.6028/NIST.SP.800-181r1

Tanenbaum, A. S., & Wetherall, D. J. (2011). *Computer networks* (5th ed.).
Prentice Hall.

---

*TKH Innovation Fellowship 2026 · Phase 1 · Week 02 · TA Notes · Jane G. Pierre*