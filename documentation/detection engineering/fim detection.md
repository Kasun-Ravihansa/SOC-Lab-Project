# File Integrity Monitoring (FIM) Detection

## 1. Overview

File Integrity Monitoring (FIM) is a security monitoring technique used to detect unauthorized or unexpected changes to files and directories.

In this SOC laboratory, Wazuh File Integrity Monitoring was configured on the Windows 10 monitored endpoint to detect file creation and modification activities.

The purpose of this implementation is to demonstrate how endpoint file changes can be monitored and reported through a centralized SIEM platform.

## 2. Lab Environment

| Component | Configuration |
|---|---|
| Monitored Endpoint | Windows 10 Home |
| Hostname | DESKTOP-569IPTN |
| IP Address | 192.168.56.103 |
| Wazuh Agent ID | 005 |
| Wazuh Manager | Ubuntu Server |
| Manager IP | 192.168.56.104 |
| Monitoring Directory | C:\SOC-Lab-Test |

## 3. FIM Configuration

The Windows Wazuh agent was configured to monitor a dedicated test directory.

Configuration file:

```text
C:\Program Files (x86)\ossec-agent\ossec.conf
```

The following configuration was added inside the `<syscheck>` section:

```xml
<syscheck>
    <directories realtime="yes">C:\SOC-Lab-Test</directories>
</syscheck>
```

The `realtime="yes"` option enables real-time monitoring for the configured directory.

## 4. Testing Procedure

Two controlled file operations were performed.

### Test 1 – File Creation

A test file was created inside the monitored directory.

Example PowerShell command:

```powershell
New-Item -Path "C:\SOC-Lab-Test\fim-test.txt" -ItemType File
```

### Test 2 – File Modification

The created file was modified.

```powershell
Add-Content -Path "C:\SOC-Lab-Test\fim-test.txt" -Value "SOC FIM modification test"
```

These activities were used to validate whether Wazuh could identify file creation and modification events.

## 5. Detection Results

The following Wazuh alerts were successfully generated.

| Rule ID | Alert Level | Description |
|---|---:|---|
| 554 | 5 | File added to the monitored directory |
| 550 | 7 | Integrity checksum changed |

### Rule 554 – File Added

This alert indicates that a new file was detected within the monitored directory.

### Rule 550 – File Modified

This alert indicates that the integrity information of a monitored file changed.

## 6. Detection Workflow

1. A file is created or modified on the Windows endpoint.
2. The Wazuh agent monitors the configured directory.
3. File integrity information is collected.
4. The event is forwarded to the Wazuh Manager.
5. Wazuh evaluates the event.
6. A corresponding security alert is generated.
7. The alert is displayed through the Wazuh Dashboard.

## 7. Security Significance

FIM can help identify:

- Unexpected file modifications.
- Unauthorized changes to monitored files.
- Suspicious changes to important configuration files.
- Potential indicators of malware activity.

FIM alerts do not automatically prove malicious activity. Further investigation is required to determine whether a change is authorized.

## 8. Evidence

The following evidence was collected:

- FIM configuration.
- File creation and modification activity.
- Wazuh Rule 554 alert.
- Wazuh Rule 550 alert.
- Wazuh Dashboard FIM events.

Evidence directory:

```text
Evidence/03-File-Integrity-Monitoring/
```

## 9. Conclusion

File Integrity Monitoring was successfully implemented on the Windows endpoint using Wazuh.

The lab demonstrated the detection of file creation and modification activities and the generation of corresponding security alerts.