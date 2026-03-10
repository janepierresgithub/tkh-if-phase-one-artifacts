#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Night 1: Terminal Genesis — Official Instructor Script
# Author: George Robbins (Lead Instructor)
# Source: https://gist.github.com/grobbins-cell/126d5c64f5f071ae950cc18c09b391fa
# ============================================================
echo "[*] Provisioning Session 01: Terminal Genesis..."
cd ~

# 1. Build "The Maze"
echo "[*] Constructing the maze..."
mkdir -p ~/maze/level_{1..100}

# 2. Hide the flag in level 42
echo "MISSION ACCOMPLISHED: +10 XP. You have learned to see in the dark." > ~/maze/level_42/flag.txt

# 3. Install GitHub CLI if not present
if ! command -v gh &> /dev/null; then
    echo "[*] Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update && sudo apt install gh -y
fi

echo "[*] Environment Ready. Welcome to the Terminal."
