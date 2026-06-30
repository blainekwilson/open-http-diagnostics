# Level 4: Deep Diagnostics

Level 4 captures detailed failed-request diagnostics correlated to the same trace context used in common logs.

## Intended use

- Troubleshooting production issues
- Comparing client evidence with infrastructure logs
- Investigating WAF, load balancer, proxy, and application routing conflicts

## Requirements

- Sensitive data must be redacted by default.
- Capture should be configurable and scoped.
- Output should include `trace_id` for correlation with Level 1 logs.
