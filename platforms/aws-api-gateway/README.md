# AWS API Gateway

AWS API Gateway is an HTTP front door whose access logs can be the canonical
Level 1 record for Lambda, container, or service integrations.

| OHD level | Status | Method |
|---|---|---|
| 1 | Documented | Stage access logging exported to the configured CloudWatch destination |
| 2 | Planned | Gateway tracing plus backend W3C Trace Context integration |
| 3 | Integration-specific | Backend or gateway response policy |
| 4 | Planned | Provider and backend diagnostics |

Start with [Level 1](level-1.md).
