
#!/bin/bash

# SOC Lab - Wazuh Alert Search

ALERT_FILE="/var/ossec/logs/alerts/alerts.json"

if [ ! -f "$ALERT_FILE" ]; then
    echo "ERROR: Wazuh alerts file not found."
    exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "ERROR: jq is not installed."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Usage: $0 <RULE_ID>"
    echo "Example: $0 100300"
    exit 1
fi

RULE_ID="$1"

echo "======================================"
echo "         WAZUH ALERT SEARCH"
echo "======================================"
echo "Searching for Rule ID: $RULE_ID"
echo

sudo jq -c --arg id "$RULE_ID" \
    'select(.rule.id == $id)' "$ALERT_FILE"

echo
echo "======================================"
echo "           SEARCH COMPLETED"
echo "======================================"
