# Lessons Learned

## 1. Introduction

Building this Virtualized Security Operations Center (SOC) Lab provided practical experience in endpoint monitoring, security event collection, detection engineering, and security analysis using Wazuh.

The project helped connect theoretical cybersecurity concepts with practical security monitoring activities.

## 2. Technical Lessons

### 2.1 SOC Architecture

- Learned how a SOC monitoring environment works.
- Understood the roles of a SIEM manager, monitored endpoint, and attacker simulation machine.
- Practised configuring communication between virtual machines using a VirtualBox Host-Only Network.
- Learned how network connectivity affects security event collection.

### 2.2 Wazuh SIEM

- Learned how to install and configure Wazuh Manager and Wazuh Agent.
- Understood how agents forward security events to the manager.
- Practised checking agent connectivity and service status.
- Learned how Wazuh rules classify events based on their characteristics.

### 2.3 File Integrity Monitoring

- Learned how File Integrity Monitoring (FIM) identifies file changes.
- Practised monitoring a dedicated Windows directory.
- Observed alerts generated when files were created and modified.
- Understood the importance of file integrity monitoring in detecting unauthorized changes.

### 2.4 Authentication Monitoring

- Learned how Windows Security Event ID 4625 records failed logon attempts.
- Practised generating controlled authentication failures from Kali Linux.
- Created a custom Wazuh rule to identify repeated failed logins from the same source IP.
- Understood how repeated authentication failures can indicate a possible brute-force attack.

### 2.5 PowerShell Monitoring

- Learned how Windows PowerShell Script Block Logging records script execution activity.
- Worked with Windows Event ID 4104.
- Configured Wazuh to collect PowerShell operational events.
- Created a custom rule to identify Script Block Logging events.

### 2.6 Custom Detection Engineering

- Learned how to create and validate custom Wazuh detection rules.
- Used existing Wazuh rules as parent rules.
- Developed a custom rule to detect PowerShell execution containing the `-EncodedCommand` parameter.
- Mapped the detection to relevant MITRE ATT&CK techniques: T1059.001 and T1027.

## 3. Practical Skills Developed

Through this project, I improved my ability to:

- Configure and troubleshoot Linux and Windows systems.
- Work with virtualized network environments.
- Monitor endpoint security events.
- Analyse Windows event logs.
- Write and validate Wazuh XML detection rules.
- Use Linux commands to investigate logs and services.
- Perform controlled security testing.
- Organize technical documentation and project evidence.

## 4. Conclusion

This project provided a practical foundation in SIEM operations and detection engineering. It also demonstrated how endpoint telemetry, custom detection rules, and controlled security testing can be combined to build a basic SOC monitoring environment.