# VirtualBox Host-Only Network Configuration

## 1. Overview

A VirtualBox Host-only network was configured to provide isolated communication between the three SOC laboratory virtual machines.

This network allows the Kali Linux testing machine, Windows endpoint, and Ubuntu Wazuh Manager to communicate with each other without requiring direct external network exposure for laboratory communication.

## 2. Network Details

| Configuration | Value |
|---|---|
| Network Type | VirtualBox Host-only |
| Network Address | 192.168.56.0/24 |
| Subnet Mask | 255.255.255.0 |
| Kali Linux | 192.168.56.102 |
| Windows 10 | 192.168.56.103 |
| Ubuntu Server | 192.168.56.104 |

## 3. VirtualBox Network Configuration

The Host-only network was configured through VirtualBox Network Manager.

Configuration procedure:

1. Open Oracle VirtualBox.
2. Open Tools or Network Manager, depending on the VirtualBox version.
3. Navigate to Host-only Networks.
4. Create or select the Host-only network.
5. Verify that the network uses the `192.168.56.0/24` subnet.
6. Configure the network adapter for each virtual machine.
7. Select the Host-only Adapter as the network attachment type.

## 4. Virtual Machine Adapter Configuration

For each virtual machine:

1. Open VirtualBox.
2. Select the virtual machine.
3. Open Settings.
4. Select Network.
5. Enable the required network adapter.
6. Set Attached to as Host-only Adapter.
7. Select the configured Host-only network.
8. Save the configuration.

## 5. IP Address Assignment

The following IP addresses were used in the laboratory:

| Virtual Machine | IP Address |
|---|---|
| Kali Linux | 192.168.56.102 |
| Windows 10 | 192.168.56.103 |
| Ubuntu Server | 192.168.56.104 |

All three systems belong to the same `/24` subnet.

## 6. Connectivity Verification

### Kali Linux

```bash
ping -c 4 192.168.56.104
```

```bash
ping -c 4 192.168.56.103
```

### Windows 10

```powershell
Test-NetConnection 192.168.56.104 -Port 1514
```

```powershell
Test-NetConnection 192.168.56.104 -Port 443
```

### Ubuntu Server

```bash
ip -br addr
```

Check agent connectivity:

```bash
sudo /var/ossec/bin/agent_control -i 005
```

## 7. Required Communication Ports

| Port | Protocol | Source | Destination | Purpose |
|---|---|---|---|---|
| 1514 | TCP | Windows | Ubuntu | Wazuh agent communication |
| 1515 | TCP | Windows | Ubuntu | Agent enrollment |
| 443 | TCP | Host browser | Ubuntu | Wazuh dashboard |
| 445 | TCP | Kali | Windows | Controlled SMB testing |

Actual firewall rules should permit only the required communication.

## 8. Network Security Considerations

- The Host-only network is used for isolated laboratory communication.
- Testing is restricted to the configured virtual machines.
- The lab does not require exposing the monitored Windows endpoint directly to the public internet.
- The Host-only network does not automatically provide internet connectivity to the virtual machines.
- Any additional NAT or bridged adapter should be configured only when necessary.

## 9. Result

The VirtualBox Host-only network successfully connected the three SOC laboratory virtual machines.

It provided the network infrastructure required for security testing, endpoint monitoring, and centralized event collection using Wazuh.