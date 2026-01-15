#!/bin/bash

# Configuration
DAYS_VALID=365
KEY_SIZE=2048
SUBJ="/C=US/ST=State/L=City/O=SecurityResearch/OU=C2Project/CN=localhost"

echo "--- Generating SSL Certificates for Emotet Recreation ---"

# 1. Generate Server Private Key and Self-Signed Certificate
echo "[*] Creating Server Key and Certificate..."
openssl req -x509 -newkey rsa:$KEY_SIZE -keyout server.key -out server.crt \
    -days $DAYS_VALID -nodes -subj "$SUBJ"

# 2. Generate Client Private Key and Self-Signed Certificate
echo "[*] Creating Client Key and Certificate..."
openssl req -x509 -newkey rsa:$KEY_SIZE -keyout client.key -out client.crt \
    -days $DAYS_VALID -nodes -subj "$SUBJ"

echo "--- Generation Complete ---"

# List files and show distribution instructions
ls -l *.key *.crt
echo ""
echo "Distribution Instructions:"
echo "--------------------------"
echo "To Server directory: server.key, server.crt, client.crt"
echo "To Client directory: client.key, client.crt, server.crt"
