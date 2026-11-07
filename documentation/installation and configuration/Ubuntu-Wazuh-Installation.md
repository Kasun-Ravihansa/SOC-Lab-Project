# Ubuntu Server and Wazuh Installation

## 1. Overview

Ubuntu Server was deployed as the centralized Security Information and Event Management (SIEM) server for the SOC laboratory.

Wazuh 4.14.7 was installed to provide endpoint monitoring, event analysis, security alert generation, and dashboard access.

## 2. Server Information

| Configuration | Value |
|---|---|
| Operating System | Ubuntu Server |
| Hostname | kasunserver |
| IP Address | 192.168.56.104 |
| SIEM Platform | Wazuh |
| Wazuh Version | 4.14.7 |
| Role | Centralized Monitoring Server |

## 3. System Preparation

Update the Ubuntu package repository:

```bash
sudo apt update
```

Upgrade installed packages:

```bash
sudo apt upgrade -y
```

Check the system IP configuration:

```bash
ip -br addr
```

Verify the hostname:

```bash
hostname
```

## 4. Wazuh Installation

The Wazuh installation was performed using the official Wazuh installation method.

The Wazuh installation includes the following components:

| Component | Purpose |
|---|---|
| Wazuh Manager | Security event analysis and alert generation |
| Wazuh Indexer | Security event indexing and storage |
| Wazuh Dashboard | Security monitoring interface |

Official installation documentation:

https://documentation.wazuh.com/current/installation-guide/index.html

The installation was performed using the Wazuh installation assistant.

The installer and installation options should be obtained from the official documentation for the selected Wazuh version.

## 5. Wazuh Manager Verification

Check the Wazuh Manager service:

```bash
sudo systemctl status wazuh-manager
```

Check whether the service is active:

```bash
sudo systemctl is-active wazuh-manager
```

Expected output:

```text
active
```

## 6. Important Network Ports

| Port | Protocol | Purpose |
|---|---|---|
| 1514 | TCP | Agent communication |
| 1515 | TCP | Agent enrollment |
| 443 | TCP | Dashboard access |

Check listening ports:

```bash
sudo ss -tulnp
```

## 7. Wazuh Agent Management

List connected agents:

```bash
sudo /var/ossec/bin/agent_control -l
```

Check the Windows agent:

```bash
sudo /var/ossec/bin/agent_control -i 005
```

Expected status:

```text
Status: Active
```

## 8. Important Configuration Files

| File | Purpose |
|---|---|
| `/var/ossec/etc/ossec.conf` | Wazuh Manager configuration |
| `/var/ossec/etc/rules/local_rules.xml` | Custom detection rules |
| `/var/ossec/logs/ossec.log` | Wazuh Manager operational logs |
| `/var/ossec/logs/alerts/alerts.json` | Generated security alerts |
| `/var/ossec/logs/archives/archives.json` | Collected event archives, when archive logging is enabled |

## 9. Wazuh Dashboard

Access the dashboard through:

```text
https://192.168.56.104
```

The dashboard provides an interface to monitor agents, security events, alerts, and detection activity.

## 10. Result

Ubuntu Server was configured as the central Wazuh monitoring server. The Wazuh Manager was deployed and prepared to receive security events from the Windows endpoint.