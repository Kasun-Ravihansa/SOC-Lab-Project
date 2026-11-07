# Windows Failed Login and Brute-Force Detection

## 1. Overview

Authentication monitoring is an important security monitoring capability used to identify suspicious login activities.

In this SOC laboratory, Windows Security Event ID 4625 was collected through the Wazuh agent to monitor failed authentication attempts.

A custom Wazuh detection rule was developed to identify repeated failed login attempts from the same source IP address.

## 2. Lab Environment

| Component | Configuration |
|---|---|
| Testing Machine | Kali Linux |
| Kali IP Address | 192.168.56.102 |
| Monitored Endpoint | Windows 10 |
| Windows IP Address | 192.168.56.103 |
| Wazuh Manager | Ubuntu Server |
| Manager IP | 192.168.56.104 |
| Wazuh Agent ID | 005 |

## 3. Windows Audit Policy Configuration

Windows auditing was configured to record successful and failed logon events.

The following command was used to configure the Logon audit policy:

```powershell
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
```

Verify the configuration:

```powershell
auditpol /get /subcategory:"Logon"
```

The Security event channel was configured in the Windows Wazuh agent:

```xml
<localfile>
    <location>Security</location>
    <log_format>eventchannel</log_format>
</localfile>
```

## 4. Controlled Failed Login Simulation

Kali Linux was used to generate a controlled failed SMB authentication attempt against the Windows endpoint.

Command:

```bash
smbclient -L //192.168.56.103 -U 'INVALID_SOC_TEST_USER'
```

The command attempted to authenticate using an intentionally invalid username.

This generated a Windows Security Event ID 4625.

## 5. Windows Event Analysis

Event ID 4625 represents a failed logon attempt.

The observed event contained the following information:

| Field | Observed Value |
|---|---|
| Event ID | 4625 |
| Account Name | INVALID_SOC_TEST_USER |
| Logon Type | 3 |
| Source IP | 192.168.56.102 |
| Workstation | KALI |
| Status | 0xC000006D |
| SubStatus | 0xC0000064 |
| Authentication Package | NTLM |

Logon Type 3 represents a network logon.

The SubStatus value `0xC0000064` indicates that the specified username does not exist.

## 6. Built-in Wazuh Detection

Wazuh processed the Windows failed login event using its built-in detection rules.

| Rule ID | Alert Level | Description |
|---|---:|---|
| 60122 | 5 | Windows logon failure |

## 7. Custom Brute-Force Detection Rule

A custom Wazuh rule was developed to identify five failed Windows login events from the same source IP address within 120 seconds.

Rule configuration:

```xml
<rule id="100100" level="10" frequency="5" timeframe="120">
    <if_matched_sid>60122</if_matched_sid>
    <same_field>win.eventdata.ipAddress</same_field>
    <description>Possible brute-force attack: 5 failed Windows logins from the same source IP within 120 seconds.</description>
    <group>authentication_failed,windows,brute_force,</group>
</rule>
```

### Rule Explanation

| Element | Purpose |
|---|---|
| `id="100100"` | Custom rule identifier |
| `level="10"` | High-severity alert level |
| `frequency="5"` | Requires five matching events |
| `timeframe="120"` | Evaluation window of 120 seconds |
| `if_matched_sid` | Uses built-in failed login rule 60122 |
| `same_field` | Groups matching events by source IP |

## 8. Detection Workflow

1. Kali Linux generates controlled failed login attempts.
2. Windows records Event ID 4625.
3. The Wazuh agent collects the Security events.
4. Wazuh processes the events using Rule 60122.
5. The custom Rule 100100 evaluates repeated failures.
6. Five matching events from the same source IP within 120 seconds trigger a Level 10 alert.

## 9. Security Significance

Repeated failed login attempts may indicate:

- Password guessing.
- Brute-force attempts.
- Unauthorized access attempts.
- Misconfigured applications repeatedly attempting authentication.

A repeated failed login alert is an indicator for investigation, not automatic proof of a successful compromise.

## 10. Evidence

Evidence directory:

```text
Evidence/04-Brute-Force-Detection/
```

Collected evidence includes:

- Kali repeated failed login simulation.
- Windows Event ID 4625.
- Wazuh Rule 60122.
- Custom Rule 100100 configuration.
- Custom brute-force detection alert.

## 11. Conclusion

Windows authentication monitoring was implemented using Wazuh.

The lab successfully demonstrated how repeated failed login attempts from the same source IP can be identified using a custom Wazuh detection rule.