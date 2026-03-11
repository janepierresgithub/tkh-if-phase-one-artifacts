#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Phase 1 · Week 1 · Session 02 — The Keymaster
# Script: harden.sh
# Author: Jane G. Pierre — Teaching Assistant
#
# PURPOSE:
#   Applies a baseline set of Linux file permission
#   hardening operations. Each change is annotated with
#   the CIA Triad property it enforces and its NIST NICE
#   framework mapping.
#
# CIA TRIAD MAPPING SUMMARY:
#   chmod 700 ~/.ssh          → CONFIDENTIALITY
#   chmod 600 authorized_keys → CONFIDENTIALITY
#   chmod 640 /etc/shadow     → CONFIDENTIALITY + INTEGRITY
#   SUID audit                → INTEGRITY
#   chmod 700 ~/Vault         → CONFIDENTIALITY (Least Privilege)
#
# NIST NICE FRAMEWORK:
#   Work Role: Systems Administrator (OM-ADM-001)
#   Work Role: Vulnerability Analyst (SP-VNA-001)
#   Task: Implement system security measures (T0484)
#   Task: Identify security vulnerabilities (T0028)
#
# PRINCIPLE OF LEAST PRIVILEGE:
#   Every chmod in this script reduces permissions to
#   the minimum required for the resource to function.
#   No user or process should have more access than
#   their role requires. (Saltzer & Schroeder, 1975)
# ============================================================

set -e

echo ""
echo "============================================"
echo "  System Hardening Script — Session 02"
echo "  TKH Innovation Fellowship 2026"
echo "============================================"
echo ""

# ── SSH DIRECTORY HARDENING ───────────────────────────────
# CIA: CONFIDENTIALITY
# The .ssh directory must be readable only by its owner.
# If group or world can read it, SSH will refuse to use
# the keys inside — and worse, an attacker could steal them.
#
# 700 = rwx------ = owner: read/write/execute, no one else
echo "[*] Hardening SSH directory..."
if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    echo "[✓] ~/.ssh — chmod 700 (CONFIDENTIALITY enforced)"
else
    echo "[!] ~/.ssh not found — skipping"
fi

# ── AUTHORIZED KEYS HARDENING ─────────────────────────────
# CIA: CONFIDENTIALITY
# authorized_keys is the whitelist of public keys allowed
# to authenticate as this user. If writable by others,
# an attacker could add their own key and gain access.
#
# 600 = rw------- = owner: read/write only, no one else
if [ -f "$HOME/.ssh/authorized_keys" ]; then
    chmod 600 "$HOME/.ssh/authorized_keys"
    echo "[✓] ~/.ssh/authorized_keys — chmod 600 (CONFIDENTIALITY enforced)"
else
    echo "[!] authorized_keys not found — skipping"
fi

echo ""

# ── SHADOW FILE HARDENING ─────────────────────────────────
# CIA: CONFIDENTIALITY + INTEGRITY
# /etc/shadow stores hashed passwords. If readable by
# regular users, an attacker can download and crack hashes
# offline. If writable, they can replace hashes directly.
#
# 640 = rw-r----- = root: read/write, shadow group: read only
# chown root:shadow ensures only the shadow group can read.
echo "[*] Hardening /etc/shadow..."
if [ -f /etc/shadow ]; then
    sudo chmod 640 /etc/shadow
    sudo chown root:shadow /etc/shadow 2>/dev/null || true
    echo "[✓] /etc/shadow — chmod 640 (CONFIDENTIALITY + INTEGRITY enforced)"
else
    echo "[!] /etc/shadow not found — skipping"
fi

echo ""

# ── SUID BINARY AUDIT ─────────────────────────────────────
# CIA: INTEGRITY
# SUID (Set User ID) binaries run with the permissions of
# their OWNER, not the user executing them. A SUID binary
# owned by root gives any user who can run it root-level
# access. Unexpected SUID binaries are a privilege
# escalation path — an Integrity violation.
#
# -perm -4000 = find any file with the SUID bit set
# This is a READ-ONLY audit — it does not change anything.
echo "[*] Running SUID binary audit..."
echo "[!] Any unexpected binary below is an Integrity risk:"
echo ""
find /usr/bin -perm -4000 2>/dev/null && echo "" || echo "[!] find returned no results or permission denied"
echo "[✓] SUID audit complete (INTEGRITY check)"

echo ""

# ── VAULT / SECRETS HARDENING ─────────────────────────────
# CIA: CONFIDENTIALITY
# NIST: Least Privilege Principle
# If a Vault or secrets directory exists, ensure no
# group or world access. Sensitive files inside should
# be owner-readable only.
echo "[*] Checking for Vault directory..."
if [ -d "$HOME/Vault" ]; then
    chmod 700 "$HOME/Vault"
    echo "[✓] ~/Vault — chmod 700 (CONFIDENTIALITY + Least Privilege)"

    if [ -f "$HOME/Vault/secrets.txt" ]; then
        chmod 600 "$HOME/Vault/secrets.txt"
        echo "[✓] ~/Vault/secrets.txt — chmod 600"
    fi
else
    echo "[!] ~/Vault not found — skipping"
fi

echo ""

# ── FINAL SUMMARY ─────────────────────────────────────────
echo "============================================"
echo "  Hardening complete."
echo ""
echo "  CIA Triad coverage:"
echo "  [✓] CONFIDENTIALITY — SSH, shadow, Vault"
echo "  [✓] INTEGRITY       — SUID audit"
echo "  [ ] AVAILABILITY    — out of scope tonight"
echo ""
echo "  AAA Note: in a production environment,"
echo "  log this run with: logger -t harden.sh"
echo "  for accounting/audit trail compliance."
echo "============================================"
echo ""
