# VirtualBox Setup

## 1. Overview

Oracle VirtualBox was used as the virtualization platform to build the SOC laboratory environment.

Three virtual machines were deployed to simulate a basic security monitoring environment:

- Ubuntu Server – Wazuh Manager
- Windows 10 Home – Monitored Endpoint
- Kali Linux – Security Testing Machine

## 2. Requirements

### Software Requirements

| Software | Purpose |
|---|---|
| Oracle VirtualBox | Virtual machine management |
| Ubuntu Server | SIEM server |
| Windows 10 Home | Endpoint monitoring |
| Kali Linux | Security testing |
| Wazuh 4.14.7 | Security monitoring |

### Hardware Recommendations

The following are suggested resources. Actual VM allocations depend on the host computer's available hardware.

| Component | Suggested Allocation |
|---|---|
| CPU | 4 or more physical cores on host |
| RAM | 8 GB or more on host |
| Storage | SSD with sufficient free space |
| Virtualization | Hardware virtualization enabled |

## 3. Virtual Machine Configuration

The laboratory contains three virtual machines.

| Virtual Machine | Operating System | Role |
|---|---|---|
| Ubuntu Server | Ubuntu Server | Wazuh Manager |
| Windows Victim | Windows 10 Home | Monitored Endpoint |
| Kali Linux | Kali Linux | Security Testing |

## 4. Virtual Machine Preparation

1. Install Oracle VirtualBox on the host computer.
2. Download the required operating system installation images from their official sources.
3. Create a separate virtual machine for each operating system.
4. Attach the corresponding ISO image.
5. Configure the CPU, memory, and virtual disk.
6. Install each operating system.
7. Configure the virtual network adapters to use the Host-only network.
8. Start all three virtual machines and verify their network connectivity.

## 5. VM Roles

### Ubuntu Server

- Hosts Wazuh Manager.
- Receives endpoint security events.
- Processes detection rules.
- Generates alerts.
- Provides the Wazuh dashboard.

### Windows 10

- Runs the Wazuh agent.
- Generates Windows security events.
- Provides File Integrity Monitoring data.
- Provides PowerShell and process creation events.

### Kali Linux

- Performs controlled security testing.
- Tests connectivity to the monitored endpoint.
- Generates controlled authentication failure events.

## 6. Result

Three virtual machines were successfully prepared to build the SOC monitoring environment using Oracle VirtualBox.