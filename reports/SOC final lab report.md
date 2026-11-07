# Virtualized Security Operations Center (SOC) Lab Using Wazuh

## 1. Executive Summary

This project involved designing and implementing a virtualized Security Operations Center (SOC) monitoring environment using Wazuh.

The lab was developed using Oracle VirtualBox and three virtual machines: Ubuntu Server, Windows 10, and Kali Linux.

Wazuh was deployed as the SIEM platform to collect and analyse security events from the Windows endpoint. Controlled security testing was performed to validate file integrity monitoring, failed authentication detection, PowerShell event collection, and custom detection rules.

The project demonstrates practical knowledge of SIEM deployment, endpoint monitoring, security event analysis, and detection engineering.

## 2. Project Objectives

The main objectives were:

- Build an isolated virtualized SOC environment.
- Deploy and configure Wazuh Manager.
- Install and register a Windows Wazuh Agent.
- Collect Windows security and PowerShell events.
- Configure File Integrity Monitoring.
- Detect repeated failed authentication attempts.
- Develop custom Wazuh detection rules.
- Perform controlled security testing using Kali Linux.
- Map selected detections to MITRE ATT&CK.
- Document configurations, test results, and project evidence.

## 3. Lab Architecture

### 3.1 Virtual Machines

| Machine | Operating System | Role | IP Address |
|---|---|---|---|
| SOC Server | Ubuntu Server | Wazuh Manager and Dashboard | 192.168.56.104 |
| Victim Endpoint | Windows 10 Home | Monitored endpoint | 192.168.56.103 |
| Testing Machine | Kali Linux | Controlled security testing | 192.168.56.102 |

### 3.2 Network Configuration

The virtual machines communicate using a VirtualBox Host-Only Network.

| Property | Value |
|---|---|
| Network Address | 192.168.56.0 |
| Subnet Mask | 255.255.255.0 |
| CIDR | /24 |
| Network Type | Host-Only |

### 3.3 Main Technologies

- Oracle VirtualBox
- Ubuntu Server
- Wazuh 4.14.7
- Windows 10 Home
- Kali Linux
- PowerShell
- Windows Event Logging
- XML-based Wazuh detection rules
- MITRE ATT&CK Framework

## 4. Wazuh Deployment and Configuration

Wazuh Manager was deployed on Ubuntu Server.

The Windows endpoint was registered as Wazuh Agent ID `005`.

The following services and communication ports were used:

| Port | Purpose |
|---|---|
| TCP 1514 | Agent communication |
| TCP 1515 | Agent registration |
| TCP 443 | Wazuh Dashboard HTTPS |

The Wazuh Dashboard was used to review security events and generated alerts.

## 5. Implemented Security Monitoring

### 5.1 File Integrity Monitoring

Wazuh File Integrity Monitoring was configured to monitor:

`C:\SOC-Lab-Test`

Controlled file creation and modification tests were performed.

Observed alerts:

| Rule ID | Description | Level |
|---|---|---|
| 554 | File added | 5 |
| 550 | File checksum changed | 7 |

**Result:** File creation and modification activities were successfully detected.

### 5.2 Failed Login Detection

Windows Security Event ID 4625 was collected through the Wazuh Agent.

Controlled failed SMB authentication attempts were generated from Kali Linux against the Windows endpoint.

The built-in Rule 60122 identified failed logon events.

Custom Rule 100100 was developed to identify five failed logins from the same source IP address within 120 seconds.

**Result:** The repeated failed-login test successfully generated a Level 10 custom alert.

### 5.3 PowerShell Script Block Logging

PowerShell Script Block Logging was enabled on the Windows endpoint.

The Wazuh Agent collected events from:

`Microsoft-Windows-PowerShell/Operational`

Windows Event ID 4104 was verified in the local event log and Wazuh archives.

Custom Rule 100200 was created using built-in Rule 91802 as its parent.

**Result:** The custom Rule 100200 successfully generated a Level 5 alert.

### 5.4 Encoded PowerShell Detection

Windows process creation telemetry was collected through Event ID 4688.

Custom Rule 100300 was developed using built-in Rule 67027 as its parent.

The rule identifies PowerShell command lines containing the `-EncodedCommand` parameter.

A harmless PowerShell command was encoded and executed to validate the detection.

**Result:** Custom Rule 100300 successfully generated a Level 10 alert.

The detection was mapped to:

- T1059.001 – PowerShell.
- T1027 – Obfuscated Files or Information.

## 6. Custom Detection Rules

| Rule ID | Detection Purpose | Level | Status |
|---|---|---:|---|
| 100100 | Repeated failed Windows logins | 10 | Verified |
| 100200 | PowerShell Script Block Logging | 5 | Verified |
| 100300 | Encoded PowerShell execution | 10 | Verified |

The custom rules extend the built-in Wazuh detection capabilities and demonstrate practical detection engineering.

## 7. MITRE ATT&CK Mapping

| Technique ID | Technique | Related Detection |
|---|---|---|
| T1110.001 | Password Guessing | Rule 100100 |
| T1059.001 | PowerShell | Rule 100300 |
| T1027 | Obfuscated Files or Information | Rule 100300 |

These mappings represent the behaviours exercised by controlled lab tests. They do not indicate that an actual compromise occurred.

## 8. Project Validation Status

The following implementation and testing activities have been verified:

- Wazuh Manager installation and operation.
- Windows Wazuh Agent registration and communication.
- Lab network connectivity.
- File Integrity Monitoring.
- Windows failed logon event collection.
- Custom repeated failed-login detection.
- PowerShell Script Block Logging.
- Custom Rule 100200.
- Encoded PowerShell test using custom Rule 100300.

**Additional validation still required:**

- Phase 8.2 tests beyond the encoded PowerShell test (8.2.1).
- Final Phase 8.7 validation and evidence review.

**Intentionally skipped:**

- Phase 8.3 – Separate Process Creation Monitoring activity.
- Phase 8.4 – Persistence Detection.
- Phase 8.6 – Alert Investigation and Incident Response.

Note: Windows Event ID 4688 was still used as telemetry for Rule 100300. Skipping the separate Phase 8.3 activity does not mean that process creation telemetry was never used.

## 9. Project Limitations

- The lab uses a small virtualized environment with one monitored Windows endpoint.
- It is designed for educational and portfolio demonstration purposes.
- The environment does not represent a production high-availability SOC.
- The encoded PowerShell rule detects a command-line indicator rather than analysing the decoded payload.
- Further testing is required to evaluate false positives and broader detection coverage.
- A structured incident response workflow has not yet been implemented as part of this project.

## 10. Future Improvements

Potential future improvements include:

- Add more Windows and Linux monitored endpoints.
- Integrate Suricata for network intrusion detection.
- Develop additional custom detection rules.
- Improve event correlation and false-positive analysis.
- Develop incident investigation and response workflows.
- Integrate threat intelligence sources.
- Explore AWS-based SOC deployment.
- Introduce security monitoring automation.

## 11. Conclusion

The Virtualized SOC Lab successfully demonstrates the deployment of a basic SIEM monitoring environment using Wazuh.

The project provides practical experience in endpoint monitoring, security event collection, File Integrity Monitoring, authentication monitoring, PowerShell logging, and custom detection engineering.

The controlled testing activities demonstrate how Wazuh can identify selected suspicious behaviours and generate alerts for security analysis.

This project establishes a foundation for further learning in SOC operations, security monitoring, and detection engineering.