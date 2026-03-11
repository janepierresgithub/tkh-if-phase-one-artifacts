#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Phase 1 · Week 1 · Session 03 — Stream Editing & Automation
# Bootstrap Script: setup_lab_03_jane.sh
# Author: Jane G. Pierre — TA Reference Implementation
#
# NOTE: Tonight's class used the lead instructor's provisioning
# script. This is my independent implementation, built to
# generate a more realistic forensic environment for practice.
# Both scripts produce an access.log suitable for the
# UNION SELECT pipeline exercise.
#
# Key differences from the class script:
#   - Python3 log generator (portable, no bash loops)
#   - 10,000 lines vs ~5,000 (closer to production scale)
#   - 5 attacker IPs vs 3, randomized across 250 attack entries
#   - Full Apache Combined Log Format including user agent
#   - Attacks shuffled throughout — not appended at the end
# ============================================================

set -e

echo ""
echo "============================================"
echo "  TKH Lab Environment Setup — Session 03"
echo "  Stream Editing & Automation"
echo "============================================"
echo ""

# STEP 1: Verify Python3 is available
echo "[*] Checking for Python3..."
if ! command -v python3 &>/dev/null; then
    echo "[*] Installing Python3..."
    sudo apt update -qq && sudo apt install python3 -y -qq
fi
echo "[+] Python3 ready: $(python3 --version)"

# STEP 2: Generate access.log using embedded Python
echo "[*] Generating access.log (10,000 entries)..."

python3 << 'PYEOF'
import random
import datetime
import os

# ── Configuration ─────────────────────────────────────────
LOG_PATH       = os.path.expanduser("~/access.log")
TOTAL_LINES    = 10000
ATTACK_COUNT   = 250   # UNION SELECT entries buried in noise
OUTPUT_PATH    = LOG_PATH

# ── Attacker IPs (5 threat actors) ────────────────────────
# These are the IPs students will extract with the pipeline
ATTACKER_IPS = [
    "23.236.62.147",
    "45.33.32.156",
    "104.21.45.99",
    "185.220.101.33",
    "198.20.69.74",
]

# ── Legitimate traffic pool ────────────────────────────────
LEGIT_IPS = [
    f"192.168.1.{i}" for i in range(10, 60)
] + [
    f"10.0.0.{i}" for i in range(1, 30)
] + [
    "172.16.254.1", "172.16.254.2", "172.16.254.3"
]

# ── Normal request paths ──────────────────────────────────
NORMAL_PATHS = [
    "/", "/index.html", "/about", "/contact",
    "/products", "/blog", "/login", "/static/main.css",
    "/static/app.js", "/images/logo.png", "/favicon.ico",
    "/api/v1/status", "/api/v1/users", "/search?q=help",
]

# ── SQL injection payloads ────────────────────────────────
# These are the attack signatures students grep for tonight
ATTACK_PATHS = [
    "/search?q=1' UNION SELECT user,password FROM users--",
    "/login?id=1 UNION SELECT 1,2,3--",
    "/item?id=42 UNION SELECT username,password,3 FROM admin--",
    "/page?id=1 UNION SELECT table_name,2 FROM information_schema.tables--",
    "/view?id=1' UNION SELECT null,null,null--",
]

# ── User agents ───────────────────────────────────────────
LEGIT_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15",
    "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0",
    "curl/7.88.1",
]
ATTACK_AGENTS = [
    "sqlmap/1.7.8#stable (https://sqlmap.org)",
    "python-requests/2.28.2",
    "Nikto/2.1.6",
]

# ── Status codes ──────────────────────────────────────────
NORMAL_STATUS  = [200, 200, 200, 200, 301, 304, 404]
ATTACK_STATUS  = [403, 403, 403, 500, 200]   # 403 = blocked; 200 = got through

# ── Log entry builder ─────────────────────────────────────
# Format: Apache Combined Log Format
# IP - - [timestamp] "METHOD path HTTP/1.1" status bytes "referer" "agent"
def make_entry(ip, path, is_attack=False):
    ts  = datetime.datetime(2026, 3, 11,
          random.randint(18, 22),
          random.randint(0, 59),
          random.randint(0, 59))
    ts_str = ts.strftime("%d/%b/%Y:%H:%M:%S +0000")
    method = "GET"
    http   = "HTTP/1.1"
    status = random.choice(ATTACK_STATUS if is_attack else NORMAL_STATUS)
    size   = random.randint(512, 8192)
    agent  = random.choice(ATTACK_AGENTS if is_attack else LEGIT_AGENTS)
    return f'{ip} - - [{ts_str}] "{method} {path} {http}" {status} {size} "-" "{agent}"'

# ── Build the log ─────────────────────────────────────────
entries = []

# Normal traffic
normal_count = TOTAL_LINES - ATTACK_COUNT
for _ in range(normal_count):
    ip   = random.choice(LEGIT_IPS)
    path = random.choice(NORMAL_PATHS)
    entries.append(make_entry(ip, path, is_attack=False))

# Attack traffic — 5 IPs, 50 attempts each
for _ in range(ATTACK_COUNT):
    ip   = random.choice(ATTACKER_IPS)
    path = random.choice(ATTACK_PATHS)
    entries.append(make_entry(ip, path, is_attack=True))

# Shuffle — attacks buried throughout
random.shuffle(entries)

# Write the log
with open(OUTPUT_PATH, "w") as f:
    f.write("\n".join(entries) + "\n")

# Verification summary
attack_lines = [e for e in entries if "UNION SELECT" in e]
unique_ips   = sorted(set(e.split()[0] for e in attack_lines))
print(f"[+] access.log generated: {len(entries):,} total entries")
print(f"[+] Attack entries (UNION SELECT): {len(attack_lines)}")
print(f"[+] Unique attacker IPs: {len(unique_ips)}")
for ip in unique_ips:
    print(f"    → {ip}")
PYEOF

echo ""

# STEP 3: Verify the file
echo "[*] Verifying access.log..."
if [ -f ~/access.log ]; then
    LINES=$(wc -l < ~/access.log)
    echo "[✓] ~/access.log — $LINES lines"
else
    echo "[✗] ~/access.log — NOT FOUND"
    exit 1
fi

# STEP 4: Confirm attack signatures are present
ATTACK_COUNT=$(grep -c "UNION SELECT" ~/access.log 2>/dev/null || echo "0")
echo "[✓] UNION SELECT entries found: $ATTACK_COUNT"

echo ""
echo "============================================"
echo "  Lab environment ready."
echo ""
echo "  Your mission:"
echo "  Extract the unique attacker IPs from"
echo "  ~/access.log using grep, awk, sort, uniq"
echo ""
echo "  Pipeline to build:"
echo "  grep \"UNION SELECT\" ~/access.log \\"
echo "    | awk '{print \$1}' \\"
echo "    | sort | uniq > ~/threat_ips.txt"
echo "============================================"
echo ""
