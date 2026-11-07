# Windows Wazuh Agent Installation

## 1. Overview

Windows 10 Home was configured as the monitored endpoint in the SOC laboratory.

The Wazuh agent was installed to collect Windows security events and forward them to the centralized Wazuh Manager running on Ubuntu Server.

## 2. Endpoint Information

| Configuration | Value |
|---|---|
| Operating System | Windows 10 Home |
| OS Version | 10.0.18363 |
| Hostname | DESKTOP-569IPTN |
| IP Address | 192.168.56.103 |
| Wazuh Agent Version | 4.14.7 |
| Agent ID | 005 |
| Agent Name | DESKTOP-569IPTN |
| Wazuh Manager | 192.168.56.104 |

## 3. Wazuh Agent Installation

The Wazuh Windows agent was installed using the official Wazuh Windows installation package.

Official documentation:

https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html

During installation, the Wazuh Manager address was configured as:

```text
192.168.56.104
```

The agent was enrolled with the Wazuh Manager.

## 4. Windows Agent Service Verification

Open PowerShell as Administrator.

Check the Wazuh agent service:

```powershell
Get-Service WazuhSvc
```

Expected service status:

```text
Running
```

## 5. Agent Configuration

The Windows agent configuration file is located at:

```text
C:\Program Files (x86)\ossec-agent\ossec.conf
```

The agent is configured to collect Windows Security events:

```xml
<localfile>
  <location>Security</location>
  <log_format>eventchannel</log_format>
</localfile>
```

PowerShell Operational events are collected using:

```xml
<localfile>
  <location>Microsoft-Windows-PowerShell/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

These configurations allow the agent to collect relevant Windows event information.

## 6. File Integrity Monitoring

A dedicated test directory was configured for File Integrity Monitoring.

Directory:

```text
C:\SOC-Lab-Test
```

The following configuration was added under the `<syscheck>` section:

```xml
<directories realtime="yes">C:\SOC-Lab-Test</directories>
```

This enables real-time monitoring of file changes within the configured directory.

## 7. Restarting the Agent

After configuration changes, restart the Wazuh service:

```powershell
Restart-Service WazuhSvc
```

Verify the service:

```powershell
Get-Service WazuhSvc
```

## 8. Agent Communication Verification

Test connectivity to the Wazuh Manager:

```powershell
Test-NetConnection 192.168.56.104 -Port 1514
```

Check the agent status from Ubuntu:

```bash
sudo /var/ossec/bin/agent_control -i 005
```

Expected status:

```text
Active
```

## 9. Important Agent Files

| File | Purpose |
|---|---|
| `C:\Program Files (x86)\ossec-agent\ossec.conf` | Agent configuration |
| `C:\Program Files (x86)\ossec-agent\ossec.log` | Agent operational log |

## 10. Result

The Windows Wazuh agent was successfully connected to the Ubuntu Wazuh Manager.

The endpoint was configured to provide security event information, PowerShell logs, and File Integrity Monitoring data to the SOC monitoring environment.