This is just the ReadME document for the actual private repository as the original repository has exploits to gain certain certificates to gain access to the networks. Along with exploits to gain access to admin for Windows and Linux.

Emotet Recreation : HTTPS C2 Simulation
====================
A high-performance, multi-threaded C++/Python Command & Control (C2) simulation using SSL/TLS for secure communication.
## 📋 Overview

This repository recreates the communication architecture of the Emotet botnet. It utilizes a Star Topology to manage client-server interactions, featuring both single-server and multi-server "handoff" capabilities.

Language: C++, Python

### Core Features:
* **Secure Communication:** All traffic is wrapped in SSL/TLS.
* **Multi-threaded:** Handles multiple concurrent client connections.
* **Star Topology:** Supports single-server and multi-server "handoff" logic.
* **Cross-Platform:** Includes logic for both Windows and Linux environments.
---
## 🛠 Communication Protocols

### Single-Server Protocol
1. **Handshake:** Client contacts server with a unique `Client ID`.
2. **Verification:** Server checks if the client is already known.
3. **Payload Delivery:** If new, the server sends the malware binary and updates its database.
4. **Synchronization:** Server transitions to a listening state for client updates.
5. **Exfiltration:** Client sends updates to the `/files` directory, sleeps, and repeats from Step 1.

### Multi-Server (Handoff) Protocol
1. **Initial Contact:** Client contacts the primary server.
2. **Handoff Logic:** If the client is new, the primary server redirects it to a secondary server to balance the load.
3. **Execution:** Once assigned to a server, the standard delivery and update protocol (Steps 3-5 above) begins.

---

## ⚙️ Arguments & Configuration

### Server Configuration
| Argument | Description |
| :--- | :--- |
| `--ip` | Server IP address |
| `--pt` | Server Port |
| `--file_size` | Size of the payload file sent to clients (in kB) |
| `--time` | Time window to accept new connections (seconds) |
| `--flag` | Set to `True` for testing mode |
| `--duration` | Total runtime for the test sequence (seconds) |

### Client Configuration
| Argument | Description |
| :--- | :--- |
| `--ip` | Target Server IP |
| `--pt` | Target Server Port |
| `--file_size` | Size of update files sent by client (in kB) |
| `--var` | Allowed deviation in update file size (in kB) |
| `--duration` | Frequency of client check-ins (seconds) |
| `--flag` | Set to `True` for testing mode |

---

## 📊 Client Metadata Tracking
The server maintains the following information for every connected host:

| Field | Description |
| :--- | :--- |
| `localID` | Unique identifier for the client |
| `Connections` | The active socket/connection object |
| `ClientIP` | Source IP of the host |
|`ClientPort`| Client's Port|
| `Username` | OS Username of the host |
| `Platform` | Operating System (Windows/Linux) |
| `FileSent` | Status of malware payload delivery |
| `Update_Number` | Incremental count of updates received |
| `Last_Update_Time` | Timestamp of the most recent beacon |

---



### Usage:
Execute *client.py* and *server.py*.To run multiple servers make sure to run the server on different IPs and then list them in the *server.py* file.

To test the setup follow the directions given below:
1. Run shell script for the Server named '_server.sh_' and then enter the Server's IP
2. Run shell script for Clients named '_client.sh_' and then enter a list of Server IPs
3. Once both scripts have completed execution, run the test written in python named 'test_client_server.py'.
To modify the test parameters take a look at the shell scripts and then modify as needed.

## 🚀 Getting Started

### 1. Generate SSL Certificates
SSL certificates are required for communication. Run the generation script located in the botnet directory:
* Copy `client.crt`, `server.crt`, and `server.key` to the **Server** directory.
* Copy `client.crt`, `server.crt`, and `client.key` to the **Client** directory.

### 2. Manual Execution
```bash
# Run the Server
python3 server.py --host 127.0.0.1 --port 8080 --serfile 1024

# Run the Client
python3 client.py --host 127.0.0.1 --port 8080 --beacontime 60
```

---

## 🔐 SSL/TLS Troubleshooting

If you encounter "Connection Refused" or "SSL Handshake Failed" errors, check the following:

1. **Certificate Pathing:** Ensure `.crt` and `.key` files are in the same directory as the script.
2. **Common Name (CN) Mismatch:** The certificate `Common Name` should match the IP/hostname (use `127.0.0.1` for local testing).
3. **Permissions:** On Linux, ensure the user has read access: `chmod 600 server.key`.
4. **Clock Sync:** Ensure system clocks are synchronized, or the certificate may be viewed as invalid/expired.


##  📂 Version History
* **V0**: C++ Implementation. High-performance Star Topology.
* **V1 - V2**: Python base with basic Star Topology communication.
* **V3 - V4**: Payload delivery and parallelized update handling.
* **V1 - V3**: (Multi-Server): Advanced handoff logic and shell script automation.
