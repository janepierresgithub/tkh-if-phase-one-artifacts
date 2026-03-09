#!/bin/bash
# =============================================================================
# bash_onliners.sh
# TKH Innovation Fellowship 2026 — Phase 1, Week 1, Night 3
# Author: Jane G. Pierre (Teaching Assistant)
# Session: P1-W1-D3 | Stream Editing & Piping
# Date: 2026-03-12
#
# Purpose:
#   Five advanced BASH one-liners for complex system analysis.
#   Each demonstrates grep, sed, awk, and pipe chaining as used
#   in real SOC analyst and sysadmin workflows.
# =============================================================================

echo ""
echo "============================================="
echo "  TKH Phase 1 — BASH One-Liners"
echo "  Session D3: Stream Editing & Piping"
echo "============================================="
echo ""

# One-Liner 1: Top 5 most frequent syslog entries
# Real-world use: Rapid triage of a noisy log to find recurring events
echo "[1] Top 5 most frequent syslog entries:"
cat /var/log/syslog | awk '{$1=$2=$3=""; print $0}' | sort | uniq -c | sort -rn | head -5
echo ""

# One-Liner 2: Unique usernames from failed login attempts
# Real-world use: Spot brute force targets or compromised accounts
echo "[2] Failed login usernames (auth.log):"
grep "Failed password" /var/log/auth.log 2>/dev/null \
  | awk '{print $9}' | sort | uniq -c | sort -rn \
  || echo "  [!] auth.log empty or inaccessible"
echo ""

# One-Liner 3: Count error lines in syslog (case-insensitive)
# Real-world use: Quick health check — is this log clean or on fire?
echo "[3] Error line count in syslog:"
grep -ic "error" /var/log/syslog && echo "  errors found in /var/log/syslog"
echo ""

# One-Liner 4: Files in /etc modified in the last 7 days
# Real-world use: Change detection — what touched /etc recently?
echo "[4] Files in /etc modified in the last 7 days:"
find /etc -maxdepth 2 -mtime -7 2>/dev/null | head -20
echo ""

# One-Liner 5: Preview a sed substitution safely before writing
# Real-world use: Automated config patching without opening an editor
echo "[5] Preview sed substitution on /etc/hosts (DRY RUN — no changes made):"
sed 's/localhost/0.0.0.0/g' /etc/hosts | head -5
echo "  [Note: To write: sed -i 's/localhost/0.0.0.0/g' /etc/hosts]"
echo ""

echo "============================================="
echo "  All five one-liners executed."
echo "============================================="
echo ""
