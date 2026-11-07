# Challenges and Solutions

## 1. Introduction

During the development of the Virtualized SOC Lab, several technical challenges were encountered while configuring virtual machines, connecting Wazuh agents, collecting Windows events, and developing custom detection rules.

This document summarizes the main challenges and the approaches used to address them.

## 2. Challenges and Solutions

### 2.1 Virtual Machine Network Connectivity

**Challenge:**

The virtual machines needed to communicate with each other through an isolated network. Incorrect network configuration could prevent the Wazuh Agent from communicating with the Manager.

**Solution:**

- Configured a VirtualBox Host-Only Network.
- Assigned static IP addresses to the lab machines.
- Verified connectivity using `ping`.
- Tested required network ports using connectivity tools.

**Result:**

The Kali Linux, Windows, and Ubuntu Server machines were able to communicate within the lab network.

### 2.2 Wazuh Agent Connectivity

**Challenge:**

The Windows endpoint needed to establish communication with the Wazuh Manager and register as an active agent.

**Solution:**

- Checked the Wazuh Agent service on Windows.
- Verified the manager address in the agent configuration.
- Checked the required communication ports.
- Used Wazuh agent-control commands to verify agent status.

**Result:**

The Windows endpoint was successfully registered as Wazuh Agent ID `005` and appeared as Active.

### 2.3 Windows Security Event Collection

**Challenge:**

Windows security events needed to be collected and forwarded to Wazuh for monitoring.

**Solution:**

- Enabled the required Windows audit policy settings.
- Configured the Wazuh Agent to collect the Windows Security event channel.
- Generated controlled failed logon attempts.
- Verified the resulting Event ID `4625` records.

**Result:**

Wazuh successfully received Windows failed logon events.

### 2.4 File Integrity Monitoring

**Challenge:**

The lab needed to identify file creation and modification activities on the Windows endpoint.

**Solution:**

- Configured a dedicated monitoring directory.
- Enabled real-time monitoring for the directory.
- Created and modified test files.
- Checked the generated Wazuh alerts.

**Result:**

Wazuh generated alerts for file creation and modification activities.

### 2.5 PowerShell Event Collection

**Challenge:**

PowerShell activity needed to be recorded and forwarded to Wazuh.

**Solution:**

- Enabled PowerShell Script Block Logging.
- Configured the Wazuh Agent to collect the PowerShell Operational event channel.
- Executed a harmless test command.
- Verified the generated Event ID `4104` in Windows and Wazuh.

**Result:**

PowerShell Script Block Logging events were successfully collected.

### 2.6 Custom Detection Rule Development

**Challenge:**

Default monitoring did not provide the exact custom detection logic required for the encoded PowerShell test.

**Solution:**

- Examined the relevant Windows process creation event.
- Identified the built-in Wazuh parent rule.
- Developed custom Rule ID `100300`.
- Validated the rule configuration.
- Executed a controlled encoded PowerShell test.

**Result:**

The custom rule generated a Level 10 alert when the tested command contained the `-EncodedCommand` parameter.

## 3. Lessons from Troubleshooting

The troubleshooting process highlighted several important practices:

- Verify network connectivity before investigating agent communication problems.
- Check service status before changing configurations.
- Validate XML rule syntax before restarting Wazuh Manager.
- Confirm that Windows is generating the required events before troubleshooting Wazuh.
- Use both Wazuh archives and alerts to investigate event collection and rule matching.
- Preserve backups before modifying configuration files.

## 4. Conclusion

The challenges encountered during development improved practical troubleshooting skills and provided a better understanding of how endpoint telemetry, network connectivity, SIEM configuration, and detection rules work together.