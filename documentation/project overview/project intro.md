# Project Introduction

## Project Title
**Virtualized Security Operations Center (SOC) Lab Using Wazuh**

## 1. Introduction

This project focuses on designing, implementing, and testing a virtualized Security Operations Center (SOC) environment using VirtualBox, Wazuh, Windows 10, Ubuntu Server, and Kali Linux.

The main purpose of this lab is to understand how security monitoring, endpoint visibility, log collection, threat detection, and security alert generation work in a practical environment.

The lab simulates a small enterprise security monitoring environment where Windows acts as the monitored endpoint, Ubuntu Server hosts the Wazuh SIEM platform, and Kali Linux is used to generate controlled security testing activities.

## 2. Technologies Used

| Technology | Purpose |
|---|---|
| Oracle VirtualBox | Virtualization platform |
| Ubuntu Server | Wazuh Manager and SIEM server |
| Wazuh 4.14.7 | Security monitoring and threat detection |
| Windows 10 Home | Monitored endpoint |
| Kali Linux | Controlled security testing |
| PowerShell | Windows event and execution testing |
| Linux Terminal | Server administration and log analysis |

## 3. Main Features Implemented

- Centralized security event collection from a Windows endpoint.
- File Integrity Monitoring (FIM).
- Windows failed login monitoring.
- Custom brute-force detection using Wazuh rules.
- PowerShell Script Block Logging monitoring.
- Windows process creation event monitoring through Event ID 4688.
- Custom detection of encoded PowerShell execution.
- Security alert analysis using Wazuh.

## 4. Project Scope

The project demonstrates the fundamental operations of a SOC monitoring environment through controlled laboratory activities.

The implemented detections focus on endpoint security events, authentication failures, file modifications, and suspicious PowerShell execution.

The environment is isolated using a VirtualBox Host-only network to support controlled testing between the virtual machines.

## 5. Project Outcome

The lab demonstrates how endpoint events can be collected, analyzed, and converted into security alerts using Wazuh.

It also provides practical experience with SIEM administration, Windows security logging, Linux server management, detection engineering, and basic security monitoring workflows.

## 6. Project Status

The core SOC monitoring environment and several detection scenarios have been implemented and verified. Final validation and evidence organization are planned as the remaining project activities.