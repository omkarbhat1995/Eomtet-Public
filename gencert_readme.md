## 🔐 SSL Certificate Setup

To enable secure communication between the server and the clients, you must generate and distribute SSL certificates. This project uses **mutual TLS (mTLS)**, meaning both the server and the client must verify each other.

### 1. The Generation Script (`generate_certs.sh`)
Create a file named `generate_certs.sh` in your root directory and paste the following:

```bash
#!/bin/bash

# Configuration
DAYS_VALID=365  
KEY_SIZE=2048
SUBJ="/C=US/ST=State/L=City/O=SecurityResearch/OU=C2Project/CN=localhost"

echo "--- Generating SSL Certificates ---"

# Generate Server Key and Certificate
openssl req -x509 -newkey rsa:$KEY_SIZE -keyout server.key -out server.crt \
    -days $DAYS_VALID -nodes -subj "$SUBJ"

# Generate Client Key and Certificate
openssl req -x509 -newkey rsa:$KEY_SIZE -keyout client.key -out client.crt \
    -days $DAYS_VALID -nodes -subj "$SUBJ"

echo "--- Generation Complete ---"
```

### 2. Execution Instructions
Follow these steps to initialize your security layer:

1. **Make it executable**:
   ```bash
   chmod +x generate_certs.sh
   ```
2. **Run the script**:
   ```bash
   ./generate_certs.sh
   ```
3. **Distribute the files**: The script will generate four files. Move them exactly as shown below to ensure the handshake works:
   Destination	Required Files
   /server folder	server.key, server.crt, client.crt
   /client folder	client.key, client.crt, server.crt

   ---
   🔍 Key Details
   
* -**nodes (No DES)**: This flag ensures the private keys are not encrypted with a password. This allows the Python and C++ scripts to load the keys automatically without requiring manual input during a headless deployment.

* -**subj**: This pre-fills the certificate metadata.

**Note**: The CN=localhost (Common Name) works for local testing. If deploying across different machines, you should update localhost to the **Server's actual IP address** to prevent SSL validation errors.
