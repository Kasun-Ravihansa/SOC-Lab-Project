# MITRE ATT&CK Mapping

## 1. Introduction

This document maps the SOC Lab's security monitoring and custom detection capabilities to relevant MITRE ATT&CK techniques.

The MITRE ATT&CK framework provides a knowledge base of adversary tactics and techniques based on observed attack behaviours.

This mapping focuses on the activities that were actually tested in the lab.

## 2. Detection-to-Technique Mapping

| Detection | Event Source | MITRE ATT&CK Technique | Technique ID |
|---|---|---|---|
| Repeated failed logins | Windows Event ID 4625 | Password Guessing | T1110.001 |
| Encoded PowerShell execution | Windows Event ID 4688 | PowerShell | T1059.001 |
| Encoded PowerShell execution | Windows Event ID 4688 | Obfuscated Files or Information | T1027 |

## 3. Technique Analysis

### 3.1 T1110.001 – Password Guessing

**Tactic:** Credential Access

**Related Custom Rule:** 100100

**Event Source:** Windows Security Event ID 4625

**Description:**

Password Guessing involves attempting to obtain valid credentials by repeatedly trying passwords against an account.

In this SOC Lab, controlled failed SMB authentication attempts were generated from Kali Linux against the Windows endpoint.

The custom Wazuh Rule 100100 identifies five failed logon events from the same source IP address within 120 seconds.

**Detection Evidence:**

- Windows Event ID 4625.
- Source IP: `192.168.56.102`.
- Target IP: `192.168.56.103`.
- Custom Rule ID: `100100`.
- Alert Severity: Level 10.

**Mapping Limitation:**

The test demonstrates repeated failed authentication attempts consistent with password guessing behaviour. It does not demonstrate successful credential compromise.

### 3.2 T1059.001 – PowerShell

**Tactic:** Execution

**Related Custom Rule:** 100300

**Event Source:** Windows Security Event ID 4688

**Description:**

PowerShell is a command and scripting environment that can be used by administrators and adversaries to execute commands and scripts.

In this lab, a harmless PowerShell command was encoded and executed using the `-EncodedCommand` parameter.

Custom Rule 100300 identifies process creation events containing this parameter.

**Detection Evidence:**

- Windows Event ID 4688.
- PowerShell process creation.
- Command-line parameter: `-EncodedCommand`.
- Custom Rule ID: `100300`.
- Alert Severity: Level 10.

**Mapping Limitation:**

The test validates detection of encoded PowerShell execution. It does not demonstrate malicious script execution or compromise of the endpoint.

### 3.3 T1027 – Obfuscated Files or Information

**Tactic:** Defense Evasion

**Related Custom Rule:** 100300

**Event Source:** Windows Security Event ID 4688

**Description:**

Obfuscated Files or Information describes techniques used to make files or information harder to analyse or understand.

Encoding command content can be one method of concealing the content of a command.

The lab's Rule 100300 identifies PowerShell execution containing the `-EncodedCommand` parameter.

**Detection Evidence:**

- Encoded PowerShell command generated using Base64.
- Windows process creation event.
- Wazuh Rule ID: `100300`.
- Alert Severity: Level 10.

**Mapping Limitation:**

Base64 encoding is not inherently malicious and is not sufficient by itself to prove defence evasion. The rule identifies a potentially suspicious indicator that should be investigated further.

## 4. Monitoring Coverage Without Direct ATT&CK Mapping

The following monitoring activities are implemented but are not assigned a specific ATT&CK technique in this report.

| Monitoring Capability | Event / Rule | Purpose |
|---|---|---|
| File Integrity Monitoring | Wazuh Rules 554 and 550 | Identify file creation and modification |
| PowerShell Script Block Logging | Event ID 4104 / Rule 100200 | Record PowerShell script block activity |
| Process Creation Monitoring | Event ID 4688 / Rule 67027 | Provide process creation telemetry |

These capabilities provide security visibility. Their presence alone does not establish that a particular adversary technique has occurred.

## 5. MITRE ATT&CK Coverage Summary

| Technique ID | Technique Name | Related Rule | Validation |
|---|---|---|---|
| T1110.001 | Password Guessing | 100100 | Controlled failed-login test |
| T1059.001 | PowerShell | 100300 | Encoded PowerShell test |
| T1027 | Obfuscated Files or Information | 100300 | Encoded PowerShell test |

## 6. Future Detection Improvements

Potential improvements include:

- Add detections for suspicious PowerShell behaviours beyond the presence of an encoded-command parameter.
- Correlate authentication failures with successful logons.
- Investigate suspicious process trees and parent-child relationships.
- Improve detection logic using additional Windows telemetry.
- Evaluate false positives using legitimate administrative activity.
- Expand ATT&CK coverage through controlled testing of additional techniques.

## 7. Conclusion

The SOC Lab demonstrates practical detection coverage for selected credential access and execution-related behaviours.

The custom Wazuh rules provide visibility into repeated failed logins and encoded PowerShell execution.

The ATT&CK mappings describe the behaviours represented by the controlled tests, not proof of a real-world compromise.