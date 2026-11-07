# Kali Linux Setup

## 1. Overview

Kali Linux was deployed as the security testing machine in the SOC laboratory.

It was used to perform controlled network connectivity tests and authentication testing against the Windows monitored endpoint.

All activities were conducted within the isolated VirtualBox Host-only network.

## 2. System Information

| Configuration | Value |
|---|---|
| Operating System | Kali Linux |
| IP Address | 192.168.56.102 |
| Network | 192.168.56.0/24 |
| Role | Security Testing Machine |

## 3. Network Configuration Verification

Check the network interfaces:

```bash
ip -br addr
```

Verify the configured IP address:

```bash
ip addr show
```

The expected laboratory address is:

```text
192.168.56.102/24
```

## 4. Connectivity Testing

Test connectivity to the Ubuntu Wazuh Manager:

```bash
ping -c 4 192.168.56.104
```

Test connectivity to the Windows endpoint:

```bash
ping -c 4 192.168.56.103
```

Check SMB port connectivity:

```bash
nc -zv 192.168.56.103 445
```

## 5. Controlled Authentication Testing

Kali Linux was used to generate controlled failed authentication attempts against the Windows endpoint.

Example:

```bash
smbclient -L //192.168.56.103 -U 'INVALID_SOC_TEST_USER'
```

This test was used to generate Windows authentication failure events.

The Windows Security event log recorded Event ID 4625.

Wazuh collected the event and evaluated it against the configured detection rules.

Repeated controlled failed login attempts were used to validate custom Rule ID 100100.

## 6. Security Testing Scope

The Kali Linux machine was used for:

- Network connectivity verification.
- SMB service connectivity testing.
- Controlled failed authentication testing.
- Validation of Windows security event collection.
- Verification of Wazuh detection capabilities.

All testing was restricted to the SOC laboratory environment.

## 7. Result

Kali Linux was configured as the security testing machine and successfully used to generate controlled activities for validating endpoint security monitoring and detection capabilities.