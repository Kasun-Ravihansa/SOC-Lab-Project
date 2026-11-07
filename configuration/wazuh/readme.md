# Wazuh Configuration

## 1. Overview

This directory contains configuration files and documentation related to the Wazuh Manager used in the SOC Lab.

**Wazuh Manager Details**

| Property | Value |
|---|---|
| Hostname | kasunserver |
| Operating System | Ubuntu Server |
| Wazuh Version | 4.14.7 |
| Manager IP | 192.168.56.104 |
| Agent Communication | TCP 1514 |
| Agent Registration | TCP 1515 |
| Dashboard | HTTPS 443 |

## 2. Files

| File | Description |
|---|---|
| `ossec.conf` | Wazuh Manager main configuration file |
| `local_rules.xml` | Custom Wazuh detection rules |

## 3. Configuration Locations

Original configuration files on the Ubuntu Server:

```text
/var/ossec/etc/ossec.conf
/var/ossec/etc/rules/local_rules.xml
```

## 4. Custom Detection Rules

The lab uses the following custom Wazuh rules:

| Rule ID | Purpose | Severity |
|---|---|---|
| 100100 | Repeated Windows failed login detection | Level 10 |
| 100200 | PowerShell Script Block Logging event detection | Level 5 |
| 100300 | Encoded PowerShell execution detection | Level 10 |

## 5. Configuration Validation

Before restarting the Wazuh Manager after rule modifications, validate the configuration:

```bash
sudo /var/ossec/bin/wazuh-analysisd -t
```

Check the Wazuh Manager service:

```bash
sudo systemctl status wazuh-manager
```

Restart the service when required:

```bash
sudo systemctl restart wazuh-manager
```

## 6. Security Notes

- Do not upload credentials or passwords.
- Do not upload private keys or authentication secrets.
- Review configuration files before publishing them.
- Keep backups before making configuration changes.

## 7. Purpose

These files provide configuration references for understanding and reproducing the Wazuh monitoring and detection environment.