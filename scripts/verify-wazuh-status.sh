
#!/bin/bash

# SOC Lab - Wazuh Manager Health Check

echo "======================================"
echo "       WAZUH MANAGER HEALTH CHECK"
echo "======================================"

# Check Wazuh Manager service
echo
echo "[1] Checking Wazuh Manager service..."

if systemctl is-active --quiet wazuh-manager; then
    echo "STATUS: Wazuh Manager is RUNNING"
else
    echo "STATUS: Wazuh Manager is NOT RUNNING"
fi

# Check required listening ports
echo
echo "[2] Checking required TCP ports..."

for port in 1514 1515 443; do
    if ss -lnt | grep -qE ":${port}[[:space:]]"; then
        echo "PORT $port: LISTENING"
    else
        echo "PORT $port: NOT LISTENING"
    fi
done

echo
echo "======================================"
echo "          CHECK COMPLETED"
echo "======================================"
