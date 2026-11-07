
#!/bin/bash

# SOC Lab - Wazuh Agent Status Verification

AGENT_ID="005"

echo "======================================"
echo "       WAZUH AGENT STATUS CHECK"
echo "======================================"

echo
echo "[1] Checking registered agents..."

sudo /var/ossec/bin/agent_control -l

echo
echo "[2] Checking Windows Agent ID: $AGENT_ID"

sudo /var/ossec/bin/agent_control -i "$AGENT_ID"

echo
echo "======================================"
echo "          CHECK COMPLETED"
echo "======================================"
