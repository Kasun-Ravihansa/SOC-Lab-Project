# Detection Rule Analysis

## 1. Project Overview

This document analyses the built-in and custom Wazuh detection rules used in the Virtualized Security Operations Center (SOC) Lab.

The project uses Wazuh to collect Windows endpoint telemetry, identify suspicious activities, and generate security alerts through custom detection logic.

**Environment:**

| Component | Details |
|---|---|
| SIEM | Wazuh 4.14.7 |
| Manager | Ubuntu Server |
| Manager IP | 192.168.56.104 |
| Monitored Endpoint | Windows 10 Home |
| Endpoint IP | 192.168.56.103 |
| Agent ID | 005 |
| Testing Machine | Kali Linux |
| Testing IP | 192.168.56.102 |

## 2. Built-in Wazuh Detection Rules

The project uses existing Wazuh rules as the foundation for custom detection.

### 2.1 Rule 60122 – Windows Failed Logon

| Property | Value |
|---|---|
| Rule ID | 60122 |
| Level | 5 |
| Event Source | Windows Security |
| Windows Event ID | 4625 |
| Purpose | Detect failed Windows logon attempts |

**Description:**

Windows Event ID 4625 is generated when a logon attempt fails. Wazuh processes this event and generates an authentication failure alert.

**Validation:**

Controlled failed SMB authentication attempts were generated from Kali Linux against the Windows endpoint.

The collected event contained:

- Account name used in the failed attempt.
- Logon Type 3 (Network).
- Source IP address: 192.168.56.102.
- Windows authentication failure information.

**Result:** The failed logon event was successfully collected and detected.

### 2.2 Rule 91802 – PowerShell Script Block Logging

| Property | Value |
|---|---|
| Rule ID | 91802 |
| Event Source | PowerShell Operational |
| Windows Event ID | 4104 |
| Purpose | Process PowerShell Script Block Logging events |

**Description:**

Windows PowerShell Script Block Logging records script block execution activity. Event ID 4104 contains information about the recorded script block.

The built-in Wazuh rule was used as the parent rule for custom Rule 100200.

**Validation:**

A harmless PowerShell command was executed and its corresponding Event ID 4104 was verified in Windows and Wazuh.

**Result:** PowerShell Script Block Logging events were successfully collected.

### 2.3 Rule 67027 – Windows Process Creation

| Property | Value |
|---|---|
| Rule ID | 67027 |
| Event Source | Windows Security |
| Windows Event ID | 4688 |
| Purpose | Process creation event detection |

**Description:**

Windows Event ID 4688 records process creation activity. This event can contain process information, including the command line when command-line auditing is enabled.

The built-in rule was used as the parent rule for custom Rule 100300.

**Validation:**

A controlled encoded PowerShell execution was performed. The resulting process creation event contained the `-EncodedCommand` parameter.

**Result:** The process creation event was successfully used as the source for custom encoded PowerShell detection.

## 3. Custom Wazuh Detection Rules

### 3.1 Rule 100100 – Repeated Failed Login Detection

| Property | Value |
|---|---|
| Custom Rule ID | 100100 |
| Severity | Level 10 |
| Parent Rule | 60122 |
| Detection Category | Authentication / Brute Force |
| Frequency | 5 events |
| Timeframe | 120 seconds |

**Detection Logic:**

The rule identifies five failed Windows logon events from the same source IP address within 120 seconds.

**Rule Configuration:**

```xml
<rule id="100100" level="10" frequency="5" timeframe="120">
  <if_matched_sid>60122</if_matched_sid>
  <same_field>win.eventdata.ipAddress</same_field>
  <description>Possible brute-force attack: 5 failed Windows logins from the same source IP within 120 seconds.</description>
  <group>authentication_failed,windows,brute_force,</group>
</rule>
```

**Testing Procedure:**

1. Used Kali Linux to generate controlled failed SMB authentication attempts.
2. Targeted the Windows endpoint at `192.168.56.103`.
3. Generated five failed login events from the same source IP.
4. Verified the custom Wazuh alert.

**Result:**

<badge color="success">Verified</badge>

Wazuh successfully generated a Level 10 alert using custom Rule 100100.

**Security Significance:**

Repeated failed authentication attempts can indicate password guessing or brute-force activity. However, legitimate users repeatedly entering incorrect passwords can also trigger this detection.

### 3.2 Rule 100200 – PowerShell Script Block Logging Detection

| Property | Value |
|---|---|
| Custom Rule ID | 100200 |
| Severity | Level 5 |
| Parent Rule | 91802 |
| Event ID | 4104 |
| Detection Category | PowerShell Monitoring |

**Detection Logic:**

The rule identifies PowerShell Script Block Logging events processed by the built-in Wazuh rule 91802.

**Rule Configuration:**

```xml
<rule id="100200" level="5">
  <if_sid>91802</if_sid>
  <description>Windows PowerShell Script Block Logging event detected (Event ID 4104).</description>
  <group>windows,powershell,script_block_logging,</group>
</rule>
```

**Testing Procedure:**

1. Enabled PowerShell Script Block Logging.
2. Executed a harmless PowerShell test command.
3. Verified Event ID 4104 in the Windows PowerShell Operational log.
4. Confirmed that Wazuh received the event.
5. Verified the custom Rule 100200 alert.

**Result:**

<badge color="success">Verified</badge>

Wazuh successfully generated a Level 5 alert for the PowerShell Script Block Logging event.

**Security Significance:**

PowerShell logging provides useful visibility into script execution. Event ID 4104 alone does not prove malicious activity; further analysis is required to determine whether the recorded script is suspicious.

### 3.3 Rule 100300 – Encoded PowerShell Detection

| Property | Value |
|---|---|
| Custom Rule ID | 100300 |
| Severity | Level 10 |
| Parent Rule | 67027 |
| Event ID | 4688 |
| Detection Category | Suspicious PowerShell Execution |
| MITRE ATT&CK | T1059.001, T1027 |

**Detection Logic:**

The rule identifies process creation events whose command line contains the `-EncodedCommand` parameter.

**Rule Configuration:**

```xml
<rule id="100300" level="10">
  <if_sid>67027</if_sid>
  <field name="win.eventdata.commandLine" type="pcre2">(?i)-EncodedCommand</field>
  <description>Suspicious PowerShell execution using an encoded command.</description>
  <mitre>
    <id>T1059.001</id>
    <id>T1027</id>
  </mitre>
  <group>windows,powershell,encoded_command,suspicious_execution,</group>
</rule>
```

**Testing Procedure:**

1. Created a harmless PowerShell command.
2. Encoded the command using Base64 with Unicode encoding.
3. Executed PowerShell using `-EncodedCommand`.
4. Verified the Windows process creation event.
5. Confirmed the command line was received by Wazuh.
6. Verified the custom Rule 100300 alert.

**Result:**

<badge color="success">Verified</badge>

Wazuh successfully generated a Level 10 alert.

The verified alert contained:

- Rule ID: `100300`
- Level: `10`
- Agent ID: `005`
- Agent IP: `192.168.56.103`
- MITRE techniques: `T1059.001` and `T1027`

**Security Significance:**

Encoded PowerShell execution can be used to conceal command content. However, the use of `-EncodedCommand` is not automatically malicious. Legitimate administrative scripts can also use this parameter.

## 4. Detection Rule Summary

| Rule ID | Detection | Level | Status |
|---|---|---:|---|
| 60122 | Windows failed logon | 5 | Verified |
| 91802 | PowerShell Script Block event | Built-in | Verified |
| 67027 | Windows process creation | Built-in | Verified |
| 100100 | Repeated failed logins | 10 | Verified |
| 100200 | PowerShell Script Block Logging | 5 | Verified |
| 100300 | Encoded PowerShell execution | 10 | Verified |

## 5. Limitations

- Rule 100100 identifies repeated failures from the same source IP; it does not establish that an attack was successful.
- Rule 100200 detects logging events, not malicious PowerShell scripts.
- Rule 100300 detects the presence of `-EncodedCommand`; it does not decode or inspect the Base64 content.
- Detection accuracy depends on the availability and quality of Windows event telemetry.
- Additional testing is required to evaluate false positives and detection coverage.

## 6. Conclusion

The project demonstrates how built-in Wazuh rules can be extended using custom detection logic.

Three custom rules were developed and verified for repeated failed logins, PowerShell Script Block Logging, and encoded PowerShell execution.

These detections provide practical experience in endpoint monitoring, event correlation, custom rule development, and security detection engineering.