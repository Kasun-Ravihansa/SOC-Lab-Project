# Network Topology

## 1. Network Overview

The SOC lab uses a VirtualBox Host-only network to connect three virtual machines.

The network provides isolated communication between the Kali Linux testing machine, Windows monitored endpoint, and Ubuntu Wazuh monitoring server.

## 2. Network Configuration

| Device | Operating System | IP Address | Role |
|---|---|---|---|
| VM 01 | Kali Linux | `192.168.56.102/24` | Security Testing |
| VM 02 | Windows 10 Home | `192.168.56.103/24` | Monitored Endpoint |
| VM 03 | Ubuntu Server | `192.168.56.104/24` | Wazuh Manager |

**Network Address:** `192.168.56.0/24`

**Network Type:** VirtualBox Host-only Adapter

## 3. Logical Network Diagram

```text
              VirtualBox Host-only Network
                    192.168.56.0/24
                            |
             +--------------+--------------+
             |              |              |
             |              |              |
       +-----------+  +-----------+  +-----------+
       | Kali      |  | Windows 10|  | Ubuntu    |
       | Linux     |  | Victim    |  | Server    |
       +-----------+  +-----------+  +-----------+
       | .56.102   |  | .56.103   |  | .56.104   |
       +-----------+  +-----------+  +-----------+
             |              |              |
             |              |              |
       Security         Wazuh Agent    Wazuh Manager
       Testing          Monitoring     SIEM Server
                            |
                            |
                     Security Events
                            |
                            v
                     Wazuh Dashboard
```

## 4. Communication Requirements

| Source | Destination | Port | Purpose |
|---|---|---|---|
| Windows 10 | Ubuntu Server | TCP 1514 | Wazuh agent communication |
| Windows 10 | Ubuntu Server | TCP 1515 | Agent enrollment |
| Administrator Browser | Ubuntu Server | TCP 443 | Wazuh dashboard |
| Kali Linux | Windows 10 | TCP 445 | Controlled SMB authentication testing |

## 5. Network Verification

The following commands can be used to verify connectivity.

### Kali Linux

```bash
ip -br addr
```

Test connectivity to Ubuntu Server:

```bash
ping -c 4 192.168.56.104
```

Test SMB connectivity to Windows:

```bash
nc -zv 192.168.56.103 445
```

### Ubuntu Server

```bash
ip -br addr
```

Check the Wazuh Manager:

```bash
sudo systemctl is-active wazuh-manager
```

Check the Windows agent:

```bash
sudo /var/ossec/bin/agent_control -i 005
```

### Windows 10

```powershell
ipconfig
```

Test connectivity to Ubuntu Server:

```powershell
Test-NetConnection 192.168.56.104 -Port 1514
```

## 6. Network Security Considerations

- The SOC lab uses a Host-only network for isolated virtual machine communication.
- Security testing is restricted to the laboratory environment.
- Only required communication ports should be enabled.
- The Windows endpoint should not be exposed unnecessarily to external networks.

## 7. Conclusion

The VirtualBox Host-only network provides the communication infrastructure required for the SOC lab.

It allows Kali Linux to perform controlled security tests, Windows to generate monitored security events, and Ubuntu Server to collect and analyze those events using Wazuh.