#!/bin/bash
# =============================================================================
# harden.sh
# TKH Innovation Fellowship 2026 — Phase 1, Week 1, Night 2
# Author: Jane G. Pierre (Teaching Assistant)
# Session: P1-W1-D2 | The Permissions Gauntlet
# Date: 2026-03-11
#
# Purpose:
#   Automatically apply secure file permissions to critical system paths.
#   Demonstrates the CIA Triad — Confidentiality and Integrity enforced
#   through Least Privilege access control.
# =============================================================================

echo ""
echo "============================================="
echo "  TKH Phase 1 — Security Hardening Script"
echo "  Session D2: The Permissions Gauntlet"
echo "============================================="
echo ""

echo "[*] Hardening SSH directory..."
chmod 700 /home/$USER/.ssh
echo "[+] chmod 700 applied to /home/$USER/.ssh"
echo "    Owner: rwx | Group: --- | Others: ---"
echo ""

echo "[*] Hardening authorized_keys..."
chmod 600 /home/$USER/.ssh/authorized_keys 2>/dev/null && \
  echo "[+] chmod 600 applied to authorized_keys" || \
  echo "[!] authorized_keys not found — skipping"
echo ""

echo "[*] Hardening /etc/passwd..."
sudo chmod 644 /etc/passwd
echo "[+] chmod 644 applied to /etc/passwd"
echo ""

echo "[*] Hardening /etc/shadow..."
sudo chmod 600 /etc/shadow
echo "[+] chmod 600 applied to /etc/shadow"
echo ""

echo "============================================="
echo "  Verification — Current Permissions"
echo "============================================="
ls -ld /home/$USER/.ssh 2>/dev/null
ls -l /etc/passwd
ls -l /etc/shadow
echo ""
echo "  Confirm:"
echo "  .ssh        → drwx------  (700)"
echo "  /etc/passwd → -rw-r--r--  (644)"
echo "  /etc/shadow → -rw-------  (600)"
echo "============================================="
echo ""
