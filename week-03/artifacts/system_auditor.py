import subprocess
import json

# Instruction 1: The Interrogation
# Run ps aux and capture the full process list
process_list = subprocess.run(["ps", "aux"], capture_output=True, text=True)

# Instruction 2: The Search
# Check if the malicious process is running
if "unauthorized_cryptominer" in process_list.stdout:

    # Instruction 3: The Alert
    # Build a structured alert dictionary
    alert_data = {
        "event": "Unauthorized Process",
        "severity": "High",
        "process": "unauthorized_cryptominer"
    }

    # Instruction 4: The Export
    # Save the alert as a machine-readable JSON file
    with open("security_alert.json", "w") as file:
        json.dump(alert_data, file, indent=4)

    print("[ALARM] Unauthorized process detected. Alert saved to security_alert.json.")

else:
    print("[CLEAR] No unauthorized processes found.")
