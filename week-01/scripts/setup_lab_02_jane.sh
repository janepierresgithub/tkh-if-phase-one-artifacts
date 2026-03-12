#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Phase 1 · Week 1 · Session 02 — The Access Control Matrix
# Script: setup_lab_02_jane.sh
# Author: Jane G. Pierre — TA Supplemental Implementation
#
# PURPOSE:
#   This is a supplemental TA implementation of the Night 2
#   lab environment. The class script (setup_lab_02.sh)
#   intentionally misconfigures /etc/shadow for students to
#   find and fix. This implementation creates an extended
#   practice environment with additional misconfigured targets
#   for students who want more access control scenarios to
#   work through.
#
# TARGETS (differ from class script):
#   - ~/SecureVault/          — private data directory
#   - ~/SecureVault/config.txt — sensitive config file
#   - ~/SecureVault/ops.log   — operations log
#   - /etc/crontab            — scheduled tasks file
#   - SUID audit on /usr/bin AND /usr/sbin
#
# CIA TRIAD MAPPING:
#   chmod 700 ~/SecureVault   → CONFIDENTIALITY
#   chmod 600 config.txt      → CONFIDENTIALITY
#   chmod 644 /etc/crontab    → INTEGRITY
#   SUID audit                → INTEGRITY
#
# NIST NICE FRAMEWORK:
#   Work Role: Systems Administrator (OM-ADM-001)
#   Task: Implement system security measures (T0484)
# ============================================================

set -e

echo ""
echo "============================================"
echo "  TKH Lab Environment Setup — Session 02"
echo "  The Access Control Matrix"
echo "============================================"
echo ""

# ── STEP 1: CREATE SECUREVAULT DIRECTORY ─────────────────
# This simulates a sensitive data directory that needs
# proper access controls applied — a common real-world task.
echo "[*] Building SecureVault environment..."

mkdir -p ~/SecureVault

# Populate with realistic sensitive files
cat > ~/SecureVault/config.txt << 'CONFIG'
# Application Configuration — SENSITIVE
DB_HOST=prod-db-01.internal
DB_PORT=5432
DB_USER=app_svc
DB_PASS=REDACTED
API_KEY=REDACTED
LOG_LEVEL=INFO
CONFIG

cat > ~/SecureVault/ops.log << 'LOG'
2026-03-10 18:00:01 [INFO] System startup complete
2026-03-10 18:01:14 [INFO] User jane authenticated
2026-03-10 18:05:33 [WARN] Failed login attempt from 192.168.1.99
2026-03-10 18:06:01 [WARN] Failed login attempt from 192.168.1.99
2026-03-10 18:06:45 [ALERT] Brute force pattern detected — 192.168.1.99
LOG

cat > ~/SecureVault/README.txt << 'README'
SecureVault — Restricted Access Directory
Access restricted to authorized personnel only.
All access attempts are logged and audited.
README

echo "[+] SecureVault created with 3 files"

# ── STEP 2: INTENTIONALLY MISCONFIGURE PERMISSIONS ───────
# This is the breach students find and fix.
# World-readable sensitive files = CONFIDENTIALITY violation.
chmod 777 ~/SecureVault
chmod 777 ~/SecureVault/config.txt
chmod 777 ~/SecureVault/ops.log
echo "[+] Permissions intentionally misconfigured — breach is live"
echo "[!] BREACH: SecureVault is world-readable and world-writable"

echo ""

# ── STEP 3: CREATE SSH DIRECTORY IF MISSING ──────────────
if [ ! -d ~/.ssh ]; then
    mkdir -p ~/.ssh
    echo "[+] ~/.ssh created"
fi

# Misconfigure SSH directory too
chmod 755 ~/.ssh
echo "[!] BREACH: ~/.ssh permissions too open (755 — should be 700)"

echo ""

# ── VERIFICATION ─────────────────────────────────────────
echo "[*] Current permission state (the breach):"
echo ""
ls -la ~/SecureVault/
echo ""
ls -la ~ | grep ".ssh"
echo ""
echo "============================================"
echo "  Environment ready. Breaches are live."
echo ""
echo "  Your mission:"
echo "  1. Identify the permission violations above"
echo "  2. Apply correct permissions using chmod"
echo "  3. Verify your fixes with ls -la"
echo "  4. Write harden.sh to automate the fix"
echo "  5. Push harden.sh to your GitHub repo"
echo ""
echo "  Hint: What chmod value locks a directory"
echo "  so only the owner can enter it?"
echo "============================================"
echo ""
