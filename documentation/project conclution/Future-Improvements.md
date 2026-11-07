# Future Improvements

## 1. Introduction

The current SOC Lab provides a foundation for endpoint monitoring, security event collection, and custom detection engineering. However, several improvements could make the environment more realistic, scalable, and suitable for advanced SOC operations.

The following improvements are proposed as future development activities. They are not considered completed features of the current implementation.

## 2. Planned Improvements

### 2.1 Add More Monitored Endpoints

- Add additional Windows endpoints.
- Introduce a Linux endpoint with a Wazuh Agent.
- Monitor multiple systems simultaneously.
- Compare security events from different operating systems.

### 2.2 Expand Detection Engineering

- Develop additional custom Wazuh rules.
- Improve detection logic using event correlation.
- Detect suspicious account activity.
- Monitor suspicious network connections.
- Develop additional detections for common MITRE ATT&CK techniques.
- Test detection rules against both suspicious and normal activity to reduce false positives.

### 2.3 Improve Incident Response

- Develop a structured alert investigation workflow.
- Document alert triage and severity assessment.
- Create incident investigation reports.
- Introduce response procedures for common security incidents.
- Explore Wazuh Active Response in a controlled environment.

### 2.4 Integrate Network Intrusion Detection

- Introduce Suricata for network intrusion detection.
- Monitor network traffic within the isolated lab.
- Forward Suricata alerts to Wazuh.
- Correlate endpoint and network security events.

### 2.5 Improve Visualization and Reporting

- Create more detailed security dashboards.
- Organize alerts by severity and detection category.
- Develop periodic security monitoring reports.
- Track detection performance and false-positive rates.

### 2.6 Cloud-Based SOC Expansion

- Explore deploying a Wazuh environment in AWS.
- Configure secure connectivity between cloud and local lab environments.
- Evaluate cloud logging and monitoring integrations.
- Implement appropriate network security controls and access restrictions.

### 2.7 Automation and Threat Intelligence

- Explore automated alert enrichment.
- Integrate threat intelligence sources.
- Investigate suspicious IP addresses and indicators of compromise.
- Develop scripts to simplify log analysis and routine verification tasks.

## 3. Recommended Development Priority

| Priority | Improvement | Purpose |
|---|---|---|
| High | Additional detection rules | Improve detection coverage |
| High | Incident response workflow | Improve alert investigation |
| High | More endpoint types | Expand monitoring coverage |
| Medium | Suricata integration | Add network-level detection |
| Medium | Detection dashboards | Improve visibility |
| Medium | Threat intelligence | Enrich security alerts |
| Future | AWS deployment | Explore cloud SOC architecture |
| Future | Automation | Reduce repetitive investigation tasks |

## 4. Conclusion

These improvements can gradually transform the current virtualized SOC Lab into a more comprehensive security monitoring environment.

Future development will focus on expanding detection coverage, improving incident investigation, integrating network monitoring, and exploring cloud-based security operations.