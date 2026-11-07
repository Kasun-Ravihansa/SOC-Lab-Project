# SOC Lab Architecture

## 1. Overview

The SOC lab uses a three-machine virtualized architecture implemented through Oracle VirtualBox.

The architecture consists of:

1. Kali Linux – Security Testing Machine
2. Windows 10 – Monitored Endpoint
3. Ubuntu Server – Centralized Wazuh Monitoring Server

All three virtual machines communicate through a VirtualBox Host-only network.

## 2. Architecture Components

### 2.1 Ubuntu Server – Wazuh Manager

**IP Address:** `192.168.56.104`

**Hostname:** `kasunserver`

**Role:** Centralized Security Monitoring Server

Responsibilities:

- Hosts Wazuh Manager.
- Receives security events from the Windows agent.
- Processes incoming security events.
- Applies built-in and custom detection rules.
- Generates security alerts.
- Provides the Wazuh dashboard for monitoring.

Important Wazuh ports:

| Port | Protocol | Purpose |
|---|---|---|
| 1514 | TCP | Wazuh agent communication |
| 1515 | TCP | Agent enrollment |
| 443 | TCP | Wazuh dashboard access |

### 2.2 Windows 10 – Monitored Endpoint

**IP Address:** `192.168.56.103`

**Hostname:** `DESKTOP-569IPTN`

**Wazuh Agent ID:** `005`

**Role:** Monitored Windows Endpoint

Responsibilities:

- Generates Windows security events.
- Sends collected events to Wazuh Manager.
- Provides file integrity monitoring data.
- Generates authentication failure events.
- Provides PowerShell logging events.
- Provides process creation events.

Monitored activities include:

- File creation and modification.
- Failed login attempts.
- PowerShell Script Block Logging.
- Process creation and encoded PowerShell execution.

### 2.3 Kali Linux – Security Testing Machine

**IP Address:** `192.168.56.102`

**Role:** Controlled Security Testing Machine

Responsibilities:

- Performs controlled connectivity tests.
- Generates controlled failed authentication attempts.
- Tests network communication with the Windows endpoint.
- Supports validation of security monitoring and detection capabilities.

All testing is performed within the isolated laboratory environment.

## 3. Security Event Processing Workflow

1. Windows generates a security event.
2. The Wazuh agent collects the configured event.
3. The event is forwarded to the Ubuntu Wazuh Manager.
4. Wazuh analysis engine processes the event.
5. Built-in or custom detection rules are evaluated.
6. Matching events generate security alerts.
7. Alerts are stored and displayed through the Wazuh dashboard.

## 4. Implemented Detection Capabilities

| Detection | Event / Rule | Purpose |
|---|---|---|
| File added | Rule 554 | Detect file creation |
| File modified | Rule 550 | Detect file integrity changes |
| Failed Windows login | Event 4625 / Rule 60122 | Monitor authentication failures |
| Repeated failed logins | Rule 100100 | Detect possible brute-force activity |
| PowerShell Script Block Logging | Event 4104 / Rule 100200 | Monitor PowerShell script activity |
| Encoded PowerShell execution | Event 4688 / Rule 100300 | Detect encoded PowerShell process execution |

## 5. Custom Detection Rules

The following custom rules are configured in:

`/var/ossec/etc/rules/local_rules.xml`

| Rule ID | Detection | Alert Level |
|---|---|---|
| 100100 | Repeated failed Windows logins | 10 |
| 100200 | PowerShell Script Block Logging event | 5 |
| 100300 | Encoded PowerShell execution | 10 |

## 6. Network Architecture

The three virtual machines use the same VirtualBox Host-only network.

Network details:

- Network: `192.168.56.0/24`
- Kali Linux: `192.168.56.102`
- Windows 10: `192.168.56.103`
- Ubuntu Server: `192.168.56.104`

The Host-only network allows communication between the virtual machines and the host computer without exposing the laboratory network directly to the external network.

## 7. Architecture Limitations

- The lab uses a single monitored Windows endpoint.
- The architecture is designed for learning and demonstration.
- High availability and distributed Wazuh infrastructure are not implemented.
- The environment is not intended for production deployment.

## 8. Conclusion

This architecture provides a practical environment for understanding centralized endpoint monitoring, event collection, detection engineering, and security alert generation using Wazuh.