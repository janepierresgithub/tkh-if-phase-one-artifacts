# brute_detector.py
# Mission: Filter failed login attempts from auth_audit.log

log_file = "/home/jane/auth_audit.log"
report_file = "/home/jane/brute_report.txt"
counter = 0

try:
    with open(log_file, "r") as log:
        with open(report_file, "w") as report:
            for line in log:
                if "Failed password" in line:
                    report.write(line)
                    counter += 1

    print(f"Audit complete. Found {counter} attack signatures.")
    print(f"Report saved to: {report_file}")

except FileNotFoundError:
    print("Error: Log file not found. Did the provisioning script run?")
