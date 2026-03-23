# TLAB-02 — Operation Blackout: Lab Analysis
## TKH Innovation Fellowship · Phase 1 · Week 2 · Synthesized Lab
**Date:** March 18, 2026
**Author:** Jane G. Pierre, Teaching Assistant

---

## Overview

Operation Blackout was the Week 2 terminal lab — a synthesized network
diagnostic scenario that required applying all three sessions of networking
fundamentals simultaneously. A student VM had been deliberately broken: the
primary network interface was down, the gateway was unreachable, and a hidden
service was running on an unexpected port. Students had to restore connectivity,
verify the network topology, calculate subnet parameters, and audit the protocol
stack — in sequence, without guidance between phases.

The deliverable was `tlab_report.txt`: a documented record of the restored
route table and captured TCP handshake evidence confirming end-to-end
connectivity.

---

## Scenario

A production server lost network connectivity. The on-call analyst has been
handed a VM and told: restore connectivity, verify the topology, and document
everything. Three problems need to be solved before the environment is clean:

1. The primary interface `enp0s3` is down — no IP, no route, no gateway
2. The subnet parameters have not been verified — no confirmation the host
   is correctly positioned in the network
3. An unknown service is listening on an unexpected port — possible indicator
   of compromise or misconfiguration

Students had to bring the interface up, verify the route table, calculate
subnet parameters, interrogate the protocol stack, and capture TCP handshake
evidence as proof of restored connectivity.

---

## Skills Synthesized

| Phase | Session | Skill Applied |
|---|---|---|
| Phase 1 — The Restoration | S04 Network Recon | `ip link set enp0s3 up`, route table verification, gateway ping |
| Phase 2 — The Calculation | S05 Subnetting Crucible | `ipcalc` subnet verification, CIDR notation, host range calculation |
| Phase 3 — The Interrogation | S06 Protocol Interrogation | `ss -tuln`, `dig`, `curl -I`, TCP handshake capture via `tcpdump` |

---

## The Full Workflow

**Phase 1 — Restore the interface**
```bash
ip addr show                      # confirm interface is down
sudo ip link set enp0s3 up        # restore the interface
ip addr show                      # verify IP assigned
ip route show                     # confirm gateway auto-restored
ping -c 4 10.0.2.2                # verify gateway reachable
```
VirtualBox NAT behavior: the default gateway route restores automatically
when the interface comes back up. Students needed to know this was expected
— seeing the gateway reappear without manually adding it is not a mistake,
it is how NAT networking works. Confirming this with `ip route show` before
proceeding prevents unnecessary troubleshooting.

---

**Phase 2 — Verify subnet parameters**
```bash
ipcalc 10.0.2.15/24
# Network:   10.0.2.0
# Broadcast: 10.0.2.255
# Hosts:     254
# Gateway:   10.0.2.2 (confirmed in route table)
```
The subnet calculation confirms the host is correctly positioned: `.15` is a
valid host address in the `10.0.2.0/24` range, the gateway `.2` is within the
same subnet, and the broadcast address `.255` is not being used as a host.
This is the verification step that separates a confirmed fix from an assumed one.

---

**Phase 3 — Interrogate the protocol stack**
```bash
ss -tuln                          # list all listening TCP/UDP ports
dig google.com                    # verify DNS resolution
curl -I localhost:8080            # probe unexpected service
cat /etc/hosts                    # check for DNS poisoning entries
sudo tcpdump -i enp0s3 -n port 53 # capture TCP handshake evidence
```
`ss -tuln` is the first tool a responder reaches for when auditing a system
after a connectivity incident. Every line in the output is a service that
has opened a socket and is waiting for a connection — each one is an attack
surface. Unexpected listeners require explanation before the system is
cleared.

---

## Output

**Route table (restored)**
```
default via 10.0.2.2 dev enp0s3
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15
```

**TCP 3-Way Handshake Evidence**
```
18:02:49.233758 IP 10.0.2.15.43092 > 192.168.1.1.53: Flags [S]
18:02:49.238589 IP 192.168.1.1.53 > 10.0.2.15.43092: Flags [S.]
18:02:49.238644 IP 10.0.2.15.43092 > 192.168.1.1.53: Flags [.]
```
SYN → SYN-ACK → ACK. Connection established. Round-trip time: ~5ms.
The handshake confirms not just that the interface is up, but that the full
network stack — IP routing, DNS, TCP — is functioning end to end.

---

## CIA Triad Mapping

| Operation | CIA Property | Why It Matters |
|---|---|---|
| `ip link set enp0s3 up` | Availability | Host unreachable until interface restored |
| `ip route show` + gateway ping | Availability | No default route = no external communication |
| `ipcalc` subnet verification | Integrity | Confirms host is correctly addressed — misconfigured subnets cause silent failures |
| `ss -tuln` port audit | Confidentiality | Identifies exposed services — each open port is an attack surface |
| `cat /etc/hosts` DNS check | Integrity | DNS poisoning entries redirect traffic silently |
| TCP handshake capture | Integrity | Tamper-evident proof of restored end-to-end connectivity |
| `> tlab_report.txt` | Integrity | Documented evidence — attributed, timestamped, pushable to Git |

---

## Infrastructure Constraint — MAC Whitelisting

A critical environmental factor shaped how this lab ran on-site: the TKH
office network uses MAC address whitelisting. Student VMs were not registered
and had no internet access from the classroom. All labs in Week 2 were
designed and executed offline — using VirtualBox NAT for local connectivity
and the VirtualBox console window as the fallback when VS Code Remote-SSH
disconnected.

This is not an edge case. Production environments frequently have network
access controls that block unregistered endpoints. Designing labs that work
within these constraints — and teaching students to diagnose connectivity
failures systematically rather than assuming internet access — is a realistic
preparation for enterprise IT environments.

---

## What This Lab Demonstrates

Operation Blackout mirrors the first twenty minutes of a real network incident
response engagement. An analyst arrives at a system with no connectivity,
works through the network stack layer by layer — interface, routing, DNS,
application — and produces documented evidence of the restored state. The
route table and TCP handshake capture in `tlab_report.txt` are the kind of
artifacts that go into a ticket, a runbook, or a post-incident report.

The fact that this workflow — restore, verify, calculate, interrogate, document
— maps directly to S04, S05, and S06 is the design principle in action. Every
session builds a diagnostic tool. The terminal lab proves you can use all the
tools together under pressure.

---

## References

Chapple, M., Stewart, J. M., & Gibson, D. (2021). *ISC2 CISSP certified information
systems security professional official study guide* (9th ed.). Sybex.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.

Tanenbaum, A. S., & Wetherall, D. J. (2011). *Computer networks* (5th ed.).
Prentice Hall.
