# Project Objectives

## 1. Primary Objective

To design and implement a virtualized Security Operations Center (SOC) lab that demonstrates centralized security monitoring, endpoint event collection, threat detection, and alert generation using Wazuh.

## 2. Specific Objectives

### 2.1 SOC Infrastructure Implementation
- Build a virtualized environment using Oracle VirtualBox.
- Deploy Ubuntu Server as the central Wazuh Manager.
- Configure Windows as a monitored endpoint.
- Configure Kali Linux for controlled security testing.
- Establish network connectivity between the virtual machines.

### 2.2 Centralized Security Monitoring
- Install and configure Wazuh Manager.
- Deploy and connect the Wazuh Windows agent.
- Collect Windows security events.
- Monitor endpoint activities through the Wazuh dashboard.

### 2.3 File Integrity Monitoring
- Configure File Integrity Monitoring on the Windows endpoint.
- Monitor a dedicated test directory.
- Detect file creation and modification activities.
- Verify generated Wazuh alerts.

### 2.4 Authentication Monitoring
- Monitor Windows failed login events.
- Identify failed authentication attempts.
- Develop a custom Wazuh rule to detect repeated failed logins from the same source IP.
- Validate the detection using controlled login attempts.

### 2.5 PowerShell Monitoring
- Enable PowerShell Script Block Logging.
- Collect Windows PowerShell Operational events.
- Monitor Event ID 4104.
- Create a custom Wazuh detection rule for PowerShell logging events.

### 2.6 Custom Detection Engineering
- Develop custom Wazuh rules.
- Detect encoded PowerShell execution through Windows process creation events.
- Map relevant detections to MITRE ATT&CK techniques.
- Validate custom detection rules using controlled test activities.

### 2.7 Final Validation and Documentation
- Verify the operational status of the SOC infrastructure.
- Validate implemented detection capabilities.
- Capture screenshots and relevant logs.
- Prepare technical documentation and a final project report.

## 3. Learning Objectives

Through this project, the following practical skills are developed:

- SIEM deployment and administration.
- Linux server management.
- Windows security auditing.
- Endpoint monitoring.
- Security event analysis.
- Custom detection rule development.
- MITRE ATT&CK mapping.
- Basic SOC monitoring and investigation workflows.

## 4. Project Limitations

- The environment uses a small number of virtual machines.
- Detection testing is performed using controlled laboratory simulations.
- The project does not represent a complete enterprise SOC.
- Advanced incident response automation and production-scale integrations are outside the current implementation scope.