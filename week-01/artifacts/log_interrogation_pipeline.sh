#!/bin/bash
# ============================================================
# TKH Innovation Fellowship 2026
# Phase 1 · Week 1 · Session 03 — Stream Editing & Automation
# Artifact: log_interrogation_pipeline.sh
# Author: Jane G. Pierre — Teaching Assistant
#
# PURPOSE:
#   Documented walkthrough of the full forensic pipeline
#   built during tonight's Deep Dive lab. This script
#   is intentionally verbose — each step is annotated
#   with the concept it demonstrates and its CIA/NIST
#   mapping so it serves as a reference artifact.
#
# CONCEPTS DEMONSTRATED:
#   - The Holy Trinity: grep / awk / sort+uniq
#   - stdout redirection (>)
#   - Pipeline chaining with pipes (|)
#   - Indicator of Compromise (IOC) extraction
#
# CIA TRIAD MAPPING:
#   This pipeline enforces INTEGRITY — it produces a
#   tamper-evident, attributed record of which IPs
#   launched attacks, verifiable against the raw log.
#
# NIST NICE FRAMEWORK:
#   Work Role: Cyber Defense Analyst (CD-AN-001)
#   Task: Identify indicators of compromise (T0260)
# ============================================================

set -e

LOG="$HOME/access.log"
OUTPUT="$HOME/threat_ips.txt"

echo ""
echo "============================================"
echo "  Log Interrogation Pipeline — Session 03"
echo "  TKH Innovation Fellowship 2026"
echo "============================================"
echo ""

# ── PREFLIGHT CHECK ───────────────────────────────────────
# Verify the log exists before running the pipeline
# Security principle: validate inputs before processing
if [ ! -f "$LOG" ]; then
    echo "[✗] $LOG not found. Run setup_lab_03 first."
    exit 1
fi
echo "[✓] Log file found: $LOG"
TOTAL=$(wc -l < "$LOG")
echo "[✓] Total entries: $TOTAL"
echo ""

# ── STEP 1: GREP — The Scalpel ───────────────────────────
# grep filters rows. Every line NOT matching the pattern
# is discarded. The result is a focused subset of the log.
#
# Pattern: "UNION SELECT" — SQL injection attack signature
# This is an Indicator of Compromise (IOC).
#
# CIA: INTEGRITY — we isolate only verified attack events
echo "[*] Step 1 — Filtering attack entries with grep..."
ATTACK_LINES=$(grep -c "UNION SELECT" "$LOG" 2>/dev/null || echo "0")
echo "[+] Attack entries found: $ATTACK_LINES"
echo ""

# ── STEP 2: AWK — The Formatter ──────────────────────────
# awk processes each line as a row of fields.
# By default it splits on whitespace.
# $1 = column 1 = the IP address in Apache log format.
#
# Format: IP - - [timestamp] "REQUEST" STATUS BYTES
#         $1  $2 $3  $4         $5       $6    $7
#
# CIA: CONFIDENTIALITY — we extract only what we need.
# No raw log data leaves this pipeline — just attacker IPs.
echo "[*] Step 2 — Extracting IP addresses with awk..."
RAW_IPS=$(grep "UNION SELECT" "$LOG" | awk '{print $1}' | wc -l)
echo "[+] Raw IP entries (with duplicates): $RAW_IPS"
echo ""

# ── STEP 3: SORT + UNIQ — The Refiner ────────────────────
# sort: alphabetizes the IP list so identical entries
#       are adjacent — required before uniq can work.
# uniq: collapses consecutive duplicates into one entry.
#
# Together they produce a clean, deduplicated list —
# suitable for input to Fail2Ban, iptables, or a SIEM.
echo "[*] Step 3 — Deduplicating with sort and uniq..."
echo ""

# ── FULL PIPELINE — One command, all four stages ─────────
# This is the complete pipeline students built in class.
# Reading left to right:
#   grep    → filter to attack lines only
#   awk     → extract column 1 (IP address)
#   sort    → alphabetize so uniq can work
#   uniq    → collapse duplicates
#   >       → redirect stdout to file (not screen)
grep "UNION SELECT" "$LOG" \
    | awk '{print $1}' \
    | sort \
    | uniq \
    > "$OUTPUT"

# ── VERIFICATION ─────────────────────────────────────────
# Security principle: always verify outputs after a
# pipeline completes. An empty threat_ips.txt is itself
# a finding worth investigating.
echo "[+] Pipeline complete. Verifying output..."
echo ""

if [ -s "$OUTPUT" ]; then
    COUNT=$(wc -l < "$OUTPUT")
    echo "[✓] $OUTPUT — $COUNT unique attacker IPs"
    echo ""
    echo "Threat Intelligence — Unique Attacker IPs:"
    echo "-------------------------------------------"
    cat "$OUTPUT"
    echo "-------------------------------------------"
else
    echo "[✗] $OUTPUT is empty — check log and pattern"
    exit 1
fi

echo ""
echo "============================================"
echo "  Pipeline complete."
echo "  Next step: feed threat_ips.txt to"
echo "  iptables or Fail2Ban to block these IPs."
echo "============================================"
echo ""

# ── BONUS: RANKED PIPELINE ───────────────────────────────
# This extended version counts how many times each IP
# attacked. The worst offender surfaces at the top.
# sort -nr = sort numerically, in reverse (highest first)
echo "[*] Bonus — Ranked attacker frequency:"
echo ""
grep "UNION SELECT" "$LOG" \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -nr
echo ""
