import socket

# Define your targets (Update these with the IPs from target_intel.txt)
targets = ["127.0.0.1", "8.8.8.8", "1.1.1.1", "10.0.0.1"]

# The Efficiency Engine: Loop through every IP
for ip in targets:
    print(f"--- Checking Server: {ip} ---")
   
    # Create the socket and set a 1-second timer
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)
   
    # Use connect_ex to knock on Port 22
    # A result of 0 means the port is OPEN [2]
    result = s.connect_ex((ip, 22))
   
    if result == 0:
        print(f"SUCCESS: Port 22 is OPEN on {ip}")
    else:
        print(f"FAILED: Port 22 is CLOSED on {ip}")
   
    # Always close the connection [1]
    s.close()
