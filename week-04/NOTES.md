# Week 04 — Concept Notes
## Virtualization · Docker · Container Security · Network Segmentation
**TKH Innovation Fellowship 2026 · Phase 1 · Week 4**

---

## The Big Picture

Week 4 is about isolation. Everything this week — VM sandboxing, container
lifecycle, network segmentation — comes back to one question: how do you run
potentially dangerous things without letting them affect everything around them?

In cybersecurity, isolation is not a luxury. It is a control. A malware analyst
who detonates a sample in a Bridged VM is gambling with every device on their
network. A developer who exposes a database port to the internet is trusting
that nobody will find it. This week you learned to stop trusting and start
verifying.

---

## Core Concepts

### Virtualization & Hypervisors

A **hypervisor** is software that creates and manages virtual machines. It sits
between the physical hardware and the operating systems running on top of it.
There are two types:

- **Type 1 (Bare Metal)** — runs directly on hardware. Examples: VMware ESXi,
  Microsoft Hyper-V. Used in enterprise data centers.
- **Type 2 (Hosted)** — runs on top of an existing OS. Examples: VirtualBox, UTM,
  VMware Workstation. Used for development and lab environments.

VirtualBox is what you are running on your Mac. Your Ubuntu Server VM is a
guest OS running inside VirtualBox, which is itself running inside macOS.

**Why this matters in security:** Virtualization is the foundation of malware
analysis, penetration testing lab environments, cloud computing, and containerization.
Every AWS EC2 instance is a VM running on a Type 1 hypervisor in an Amazon data center.

---

### Network Adapter Modes in VirtualBox

The network adapter mode determines how your VM communicates with the outside world.
This is one of the most security-critical settings in your lab environment.

| Mode | What It Does | Security Implication |
|---|---|---|
| **NAT** | VM shares host's IP. Can reach internet. Host cannot reach VM directly. | Default. Safe for general lab work. |
| **Bridged** | VM gets its own IP on your local network. Fully visible to all devices. | Dangerous for malware analysis. Malware can spread to other devices. |
| **Host-Only** | VM can only talk to the host machine. No internet access. | Correct mode for sandbox/malware analysis environments. |
| **Internal** | VM can only talk to other VMs on the same internal network. No host, no internet. | Maximum isolation. Used for multi-VM attack simulations. |

**Cybersecurity principle:** Sandbox Isolation — a controlled environment where
code can be executed and observed without risk to production systems or external
networks. Host-Only mode is the minimum acceptable configuration for detonating
unknown files.

---

### Containers vs Virtual Machines

Both VMs and containers provide isolation, but they do it differently.

| | Virtual Machine | Container |
|---|---|---|
| **Isolates** | Entire OS | Process only |
| **Size** | Gigabytes | Megabytes |
| **Startup** | Minutes | Seconds |
| **Hypervisor needed** | Yes | No |
| **Attack surface** | Larger | Smaller |

A VM runs a full operating system — kernel, drivers, libraries, everything.
A container shares the host OS kernel but isolates the process and its
dependencies using Linux namespaces and cgroups.

**Real world analogy:** A VM is like renting an entire apartment. A container
is like renting a room in a co-living space — you have your own space and your
own locks, but you share the building's plumbing and electrical systems.

**Why containers matter in security:**
- Smaller attack surface — less OS to patch and harden
- Immutable by design — you destroy and redeploy rather than patch in place
- Auditable — every layer of a container image is recorded and inspectable
- Ephemeral — containers leave no footprint once destroyed

---

### Docker Core Commands

```bash
# Pull an image from Docker Hub
docker pull nginx

# Run a container in detached mode, name it, map ports
docker run -d --name training-web -p 8080:80 nginx

# List running containers
docker ps

# List all containers including stopped
docker ps -a

# Execute a command inside a running container
docker exec -it training-web bash

# View container logs
docker logs training-web

# Stop a container
docker stop training-web

# Remove a container
docker rm training-web

# Remove all unused images
docker image prune -a -f

# Remove all stopped containers, unused networks, dangling images
docker system prune -a
```

**Important:** Always run `docker compose down` and `docker image prune -a -f`
after every lab. Docker images are large. A full disk will break your next lab
before it even starts.

---

### Docker Compose & Multi-Container Stacks

Docker Compose lets you define and run multi-container applications from a single
YAML file. Instead of running multiple `docker run` commands and manually connecting
containers, Compose handles the entire stack from one file.

```yaml
version: '3.8'
services:
  web:
    image: wordpress:latest
    ports:
      - "80:80"
    networks:
      - frontend
      - backend
  db:
    image: mysql:5.7
    networks:
      - backend
networks:
  frontend:
  backend:
    internal: true
```

**Key Compose commands:**

```bash
# Start the stack in detached mode
docker compose up -d

# View running services
docker compose ps

# Execute a command inside a service container
docker compose exec web bash

# Stop and remove all containers and networks
docker compose down
```

**Cybersecurity principle:** Infrastructure as Code — defining infrastructure
in version-controlled files means your architecture is auditable, reproducible,
and reviewable. Anyone can read your `docker-compose.yml` and understand exactly
what is deployed and how it is connected.

---

### Network Segmentation in Docker

Docker Compose lets you create multiple networks and assign containers to them
selectively. This is how you implement network segmentation in containerized
environments.

```yaml
networks:
  frontend:          # External-facing — can reach the internet
  backend:
    internal: true   # Air-gapped — no external routing whatsoever
```

**The key setting is `internal: true`.** When applied to a Docker network, it
tells the Docker daemon not to create an external routing table entry for that
network. Containers on an `internal` network are physically incapable of reaching
the internet — not just firewalled, but unroutable.

**Why this matters:**

| Container | Networks | Can reach internet? | Can reach database? |
|---|---|---|---|
| WordPress | frontend + backend | Yes | Yes |
| MySQL/MariaDB | backend only | No | N/A |

If an attacker compromises the WordPress container, they are trapped. The database
has no route out. They cannot exfiltrate data, cannot download additional payloads,
cannot phone home.

**Cybersecurity principle:** Blast Radius Reduction — designing systems so that
a breach of one component does not automatically mean a breach of all components.
Network segmentation is the primary tool for limiting blast radius in containerized
environments.

---

### Port Auditing with nmap

`nmap` is a network scanner used to discover open ports and services on a host.
In a security context it is used both offensively (finding attack surfaces) and
defensively (verifying that only intended ports are exposed).

```bash
# Scan specific ports on localhost
nmap -p 80,3306 localhost

# Expected output for a correctly segmented stack:
# PORT     STATE  SERVICE
# 80/tcp   open   http       ← WordPress is reachable
# 3306/tcp closed mysql      ← Database is not exposed
```

**Cybersecurity principle:** Attack Surface Reduction — every open port is a
potential entry point. A database port exposed to the network is an invitation
for brute force attacks, credential stuffing, and direct exploitation. Confirming
that 3306 is closed is not paranoia. It is verification.

---

### JSON as a Security Artifact Format

JSON (JavaScript Object Notation) is the universal language of security tooling.
Structured JSON reports can flow directly into SIEMs, ticketing systems, dashboards,
and APIs without conversion.

```json
{
    "author": "Jane G. Pierre | TKH Innovation Fellowship 2026 | TLAB 4",
    "operator": "JP",
    "host_ip": "10.0.2.15",
    "vm_sandbox_ip": "192.168.56.1",
    "web_container_id": "388af3a7767d",
    "isolation_test": "PASSED",
    "persistence_verified": true
}
```

Every field answers a specific forensic question:
- `operator` — who ran this audit?
- `host_ip` — what system was audited?
- `isolation_test` — did the security control work?
- `persistence_verified` — is the data layer durable across container restarts?

**Cybersecurity principle:** Structured Incident Documentation — categorizing
findings in a machine-readable format means the next analyst, tool, or system
that receives your report can act on it immediately without interpretation.

---

## Key Takeaways

1. **Isolation is a control, not a convenience.** Host-Only mode, `internal: true`,
   and closed ports are all deliberate security decisions — not defaults.

2. **Verify, don't assume.** Running `nmap` and `curl` from inside containers is
   not extra credit. It is the only way to know your controls are actually working.

3. **Containers are ephemeral by design.** That is a security feature. Destroy
   and redeploy rather than patch in place. Clean environments are harder to
   persist malware in.

4. **Clean up after every Docker lab.** `docker compose down` then
   `docker image prune -a -f`. A full disk is a self-inflicted outage.

5. **JSON is the handoff format.** Any finding worth documenting is worth
   documenting in a format that other tools can consume automatically.

---

## References

Mouat, A. (2015). *Using Docker: Developing and deploying software with containers.*
O'Reilly Media.

NIST. (2022). *NICE Cybersecurity Workforce Framework* (NIST SP 800-181r1).
National Institute of Standards and Technology.

Poulton, N. (2023). *Docker deep dive.* independently published.

Saltzer, J. H., & Schroeder, M. D. (1975). The protection of information in computer
systems. *Proceedings of the IEEE, 63*(9), 1278–1308.