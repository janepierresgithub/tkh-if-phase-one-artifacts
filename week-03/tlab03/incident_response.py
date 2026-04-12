#!/usr/bin/env python3
import subprocess
import json

print("[*] Initiating Automated Threat Hunt...")

# TASK 1: Use subprocess to grep for "Failed password" in /var/log/titan_sim/auth_sim.log
result = subprocess.run(
    ["grep", "Failed password", "/var/log/titan_sim/auth_sim.log"],
    capture_output=True,
    text=True
)
raw_output = result.stdout

# TASK 2: Parse the captured output to extract ONLY the attacking IP addresses.
lines = raw_output.split('\n')
attacker_ips = []

for line in lines:
    if line:
        parts = line.split(" ")
        ip = parts[10]
        attacker_ips.append(ip)

print(f"[+] Attacker IPs identified: {attacker_ips}")

# TASK 3: Create a dictionary containing the extracted IPs and export it to 'threat_report.json'
alert_data = {
    "alert_type": "Brute Force",
    "attacker_ips": attacker_ips
}

with open("threat_report.json", "w") as file:
    json.dump(alert_data, file, indent=4)

print("[+] Threat report exported to threat_report.json")
print("[+] Threat Hunt Complete. Report generated.")