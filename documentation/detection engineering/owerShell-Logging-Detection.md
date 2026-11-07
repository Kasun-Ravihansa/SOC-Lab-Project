# PowerShell Script Block Logging Detection

## 1. Overview

PowerShell is a powerful Windows command-line and scripting environment frequently used for system administration.

However, attackers may also abuse PowerShell to execute malicious commands, download payloads, or perform unauthorized system activities.

PowerShell Script Block Logging provides visibility into PowerShell script content executed on Windows systems.

In this SOC laboratory, Windows PowerShell logging was enabled and integrated with Wazuh to monitor Event ID 4104.

## 2. Lab Environment

| Component | Configuration |
|---|---|
| Monitored Endpoint | Windows 10 Home |
| Hostname | DESKTOP-569IPTN |
| IP Address | 192.168.56.103 |
| Wazuh Agent ID | 005 |
| Wazuh Manager | Ubuntu Server |
| Manager IP | 192.168.56.104 |

## 3. Enabling PowerShell Script Block Logging

Script Block Logging was enabled through the Windows Registry policy.

Registry path:

```text
HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```

The following PowerShell commands were used:

```powershell
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

New-Item -Path $path -Force

New-ItemProperty -Path $path `
    -Name EnableScriptBlockLogging `
    -Value 1 `
    -PropertyType DWORD `
    -Force
```

Verify the configuration:

```powershell
Get-ItemProperty -Path $path
```

Expected configuration:

```text
EnableScriptBlockLogging : 1
```

## 4. Windows Event ID 4104

PowerShell Script Block Logging generates Event ID 4104 in the following event channel:

```text
Microsoft-Windows-PowerShell/Operational
```

Event ID 4104 contains information about PowerShell script blocks processed by the PowerShell engine.

## 5. Wazuh Agent Configuration

The Windows Wazuh agent was configured to collect PowerShell Operational events.

Configuration file:

```text
C:\Program Files (x86)\ossec-agent\ossec.conf
```

Configuration:

```xml
<localfile>
    <location>Microsoft-Windows-PowerShell/Operational</location>
    <log_format>eventchannel</log_format>
</localfile>
```

The Wazuh agent service was restarted after the configuration change.

```powershell
Restart-Service WazuhSvc
```

## 6. Controlled PowerShell Test

A harmless PowerShell script was executed to generate a test event.

```powershell
& {
    $socTest = "SOC-PHASE8-POWERSHELL-TEST"
    Write-Output $socTest
}
```

The event was verified locally using:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-PowerShell/Operational'
    Id = 4104
} -MaxEvents 20
```

The generated event was also verified in Wazuh event archives.

## 7. Custom Wazuh Detection Rule

Custom Rule ID 100200 was configured to identify PowerShell Script Block Logging events.

```xml
<rule id="100200" level="5">
    <if_sid>91802</if_sid>
    <description>Windows PowerShell Script Block Logging event detected (Event ID 4104).</description>
    <group>windows,powershell,script_block_logging,</group>
</rule>
```

### Rule Explanation

| Element | Purpose |
|---|---|
| `100200` | Custom detection rule ID |
| `level="5"` | Alert severity level |
| `if_sid` | Uses built-in rule 91802 |
| `description` | Describes the detected PowerShell event |
| `group` | Categorizes the alert |

## 8. Detection Workflow

1. PowerShell executes a script block.
2. Windows generates Event ID 4104.
3. The Wazuh agent collects the PowerShell event.
4. The event is forwarded to the Wazuh Manager.
5. Wazuh processes the event using its built-in rule.
6. Custom Rule 100200 identifies the event.
7. A corresponding alert is generated.

## 9. Security Significance

PowerShell logging can help security analysts identify:

- Suspicious PowerShell commands.
- Unexpected script execution.
- Potentially malicious script activity.
- PowerShell activity requiring further investigation.

Event ID 4104 provides script visibility but does not automatically indicate malicious behavior.

## 10. Evidence

Evidence directory:

```text
Evidence/Phase-8-Attack-Detection/8.1-PowerShell-Detection/
```

Collected evidence includes:

- PowerShell Script Block Logging configuration.
- Windows Event ID 4104 test.
- Wazuh received event.
- Custom Rule 100200 live alert.

## 11. Conclusion

PowerShell Script Block Logging was enabled and integrated with Wazuh.

The lab successfully demonstrated how PowerShell script activity can be collected from a Windows endpoint and identified through a custom Wazuh detection rule.