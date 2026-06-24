#!/bin/bash

# Check if port 53 is listening
if ! ss -tuln | grep -q ':53 '; then
    echo "No DNS service listening on port 53"
    exit 1
fi

# If either service is running, exit successfully
if systemctl is-active --quiet pdns; then
    echo "PowerDNS (pdns) is running. Skipping."
    exit 0
fi

if systemctl is-active --quiet named; then
    echo "BIND (named) is running. Skipping."
    exit 0
fi

# Port 53 is listening but neither service is active
echo "Port 53 is listening, but neither pdns nor named service is active"
exit 1
