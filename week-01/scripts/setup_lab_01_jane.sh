#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Phase 1 · Week 1 · Session 01 — The Shell Awakening
# Bootstrap Script: setup_lab_01_jane.sh
# Author: Jane G. Pierre — TA Reference Implementation
# Note: Independent implementation created before accessing
#       lead instructor materials. Retained as TA artifact.
# ============================================================

set -e

echo ""
echo "============================================"
echo "  TKH Lab Environment Setup — Session 01"
echo "============================================"
echo ""
# STEP 1: Create /opt/alpha and mission.txt
echo "[*] Building lab directory structure..."
sudo mkdir -p /opt/alpha
sudo tee /opt/alpha/mission.txt > /dev/null << 'MISSIONEOF'
CLASSIFIED — OPERATION SHELL AWAKENING

Mission Briefing:
You have accessed the alpha directory.
Your objective: Map this server's territory.

Three items must be located and logged:
  1. The system event log (/var/log)
  2. This file (/opt/alpha/mission.txt)
  3. The hidden cache in /var/tmp

Record the absolute path to each item
in your discovery.txt artifact.

Good luck, operator.
MISSIONEOF
sudo chmod 644 /opt/alpha/mission.txt
echo "[+] /opt/alpha/mission.txt created."
# STEP 2: Create hidden directory in /var/tmp
echo "[*] Planting hidden cache in /var/tmp..."
sudo mkdir -p /var/tmp/.mission_cache
sudo tee /var/tmp/.mission_cache/intel.txt > /dev/null << 'INTELEOF'
CACHE LOCATED — INTEL RECOVERED

You found the hidden directory.
This is the third item for your discovery.txt.

Absolute path to this file:
/var/tmp/.mission_cache/intel.txt

Log it. Move on.
INTELEOF
sudo chmod 644 /var/tmp/.mission_cache/intel.txt
sudo chmod 755 /var/tmp/.mission_cache
echo "[+] /var/tmp/.mission_cache/intel.txt created."
# STEP 3: Install GitHub CLI if not present
echo "[*] Checking for GitHub CLI (gh)..."
if command -v gh &> /dev/null; then
    echo "[+] gh is already installed: $(gh --version | head -1)"
else
    echo "[*] Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
        sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
        https://cli.github.com/packages stable main" | \
        sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update -qq
    sudo apt install gh -y -qq
    echo "[+] GitHub CLI installed: $(gh --version | head -1)"
fi

# STEP 4: Install git if not present
echo "[*] Checking for git..."
if command -v git &> /dev/null; then
    echo "[+] git is already installed: $(git --version)"
else
    sudo apt install git -y -qq
    echo "[+] git installed."
fi
# STEP 5: Verify everything
echo ""
echo "[*] Verifying lab environment..."
echo ""

[ -f /opt/alpha/mission.txt ] && echo "[✓] /opt/alpha/mission.txt — FOUND" || echo "[✗] /opt/alpha/mission.txt — MISSING"
[ -f /var/tmp/.mission_cache/intel.txt ] && echo "[✓] /var/tmp/.mission_cache/intel.txt — FOUND" || echo "[✗] /var/tmp/.mission_cache/intel.txt — MISSING"

if [ -f /var/log/syslog ]; then
    echo "[✓] /var/log/syslog — FOUND"
elif [ -f /var/log/messages ]; then
    echo "[✓] /var/log/messages — FOUND"
else
    echo "[!] No syslog found — students should check /var/log with ls"
fi

command -v gh &> /dev/null && echo "[✓] GitHub CLI (gh) — READY" || echo "[✗] GitHub CLI (gh) — NOT INSTALLED"
command -v git &> /dev/null && echo "[✓] git — READY" || echo "[✗] git — NOT INSTALLED"

echo ""
echo "============================================"
echo "  Lab environment ready. Good luck!"
echo "============================================"
echo ""
echo "Hint for students: start with 'pwd' then 'ls'"
