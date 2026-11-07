# Encoded PowerShell Execution Detection

## 1. Overview

PowerShell supports encoded command execution through the `-EncodedCommand` parameter.

Encoded commands use Base64 encoding to represent PowerShell command content. This feature can be used for legitimate administration, but it may also be abused by attackers to make commands less readable during initial inspection.

In this SOC laboratory, a custom Wazuh detection rule was developed to identify PowerShell processes launched with the `-EncodedCommand` parameter.

The detection uses Windows Process Creation Event ID 4688.

## 2. Lab Environment

| Component | Configuration |
|---|---|
| Monitored Endpoint | Windows 10 Home |
| Hostname | DESKTOP-569IPTN |
| IP Address | 192.168.56.103 |
| Wazuh Agent ID | 005 |
| Wazuh Manager | Ubuntu Server |
| Manager IP | 192.168.56.104 |
| Custom Rule ID | 100300 |

## 3. Windows Process Creation Monitoring

Windows Security Event ID 4688 records process creation activities.

The event can provide information such as:

- New process name.
- Process command line, when command-line auditing is enabled.
- Process creation information.
- Event timestamp.

The command-line information is important for identifying PowerShell execution parameters.

## 4. Windows Audit Configuration

Process Creation auditing and command-line inclusion were enabled during the lab setup.

Relevant Windows audit category:

```text
Detailed Tracking
└── Audit Process Creation
```

The command-line inclusion policy enables command-line information to be recorded in process creation events.

Note: Process Creation Monitoring was used as the event source for this detection. The separate Phase 8.3 process monitoring activity was intentionally skipped.

## 5. Controlled Encoded PowerShell Test

A harmless PowerShell command was encoded using Base64 and executed.

Test command:

```powershell
$command = 'Write-Output "SOC-PHASE8-2-ENCODED-TEST"'

$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)

$encoded = [Convert]::ToBase64String($bytes)

Start-Process powershell.exe -ArgumentList "-NoProfile -EncodedCommand $encoded" -Wait
```

A separate Phase 8.5 validation test was performed using the marker:

```text
SOC-PHASE8-5-RULE-100300-TEST
```

The generated process creation event was received by Wazuh.

## 6. Wazuh Built-in Parent Rule

Wazuh built-in rule 67027 identifies Windows process creation events.

The custom rule uses this built-in rule as its parent.

Parent rule information:

| Field | Value |
|---|---|
| Rule ID | 67027 |
| Event ID | 4688 |
| Description | A process was created |
| Alert Level | 3 |

## 7. Custom Detection Rule

The following custom rule was added to:

```text
/var/ossec/etc/rules/local_rules.xml
```

Rule configuration:

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

## 8. Rule Explanation

| Element | Purpose |
|---|---|
| `100300` | Custom rule identifier |
| `level="10"` | High-severity alert level |
| `if_sid` | Uses built-in process creation rule 67027 |
| `win.eventdata.commandLine` | Examines the Windows process command line |
| `type="pcre2"` | Enables PCRE2 regular expression matching |
| `(?i)` | Case-insensitive matching |
| `-EncodedCommand` | Identifies the encoded command parameter |

## 9. MITRE ATT&CK Mapping

The detection is mapped to the following MITRE ATT&CK techniques:

| Technique ID | Technique | Relevance |
|---|---|---|
| T1059.001 | PowerShell | PowerShell command execution |
| T1027 | Obfuscated Files or Information | Use of encoding to make content less readable |

Base64 encoding alone does not prove malicious obfuscation. It is a detection indicator that requires contextual investigation.

## 10. Detection Workflow

1. A PowerShell process is launched using `-EncodedCommand`.
2. Windows generates Process Creation Event ID 4688.
3. The Wazuh agent collects the event.
4. The event reaches the Wazuh Manager.
5. Built-in Rule 67027 identifies the process creation event.
6. Custom Rule 100300 checks the command-line field.
7. The `-EncodedCommand` parameter matches the custom rule.
8. Wazuh generates a Level 10 alert.

## 11. Validation Results

The custom detection rule was successfully validated.

Observed alert information:

| Field | Result |
|---|---|
| Agent ID | 005 |
| Hostname | DESKTOP-569IPTN |
| Endpoint IP | 192.168.56.103 |
| Windows Event | 4688 |
| Custom Rule ID | 100300 |
| Alert Level | 10 |
| Fired Times | 1 |
| MITRE Technique | T1059.001, T1027 |

Alert description:

```text
Suspicious PowerShell execution using an encoded command.
```

## 12. Evidence

Evidence directory:

```text
Evidence/Phase-8-Attack-Detection/8.5-Custom-Rules/
```

Collected evidence includes:

- Custom Rule 100300 configuration.
- Encoded PowerShell execution test.
- Wazuh Level 10 alert.
- Process creation event details.

## 13. Security Significance

Encoded PowerShell execution is worth monitoring because it can reduce the readability of commands during initial inspection.

This detection helps analysts identify PowerShell processes using encoded command parameters.

However, encoded execution can also occur in legitimate administrative workflows. The alert should therefore be investigated using process details, user context, command-line content, parent process information, and endpoint activity.

## 14. Conclusion

A custom Wazuh detection rule was successfully developed and validated to identify encoded PowerShell execution.

The implementation demonstrates practical detection engineering using Windows Event ID 4688, Wazuh built-in rules, custom rule conditions, and MITRE ATT&CK mapping.