# Security Policy

Open HTTP Diagnostics handles diagnostic data that may contain sensitive information. Implementations must default to the minimum data necessary for troubleshooting.

## Reporting vulnerabilities

Report suspected vulnerabilities privately to the repository owner rather than opening a public issue.

## Security principles

- Never log authorization credentials by default.
- Never log cookies by default.
- Avoid logging raw query strings unless explicitly enabled and filtered.
- Treat trace identifiers as correlation data, not authentication secrets.
- Do not expose internal hostnames, private addresses, cloud resource identifiers, or platform names in response diagnostics.
- Use explicit allowlists for deep diagnostic capture.
- Apply retention, access control, and transport protection appropriate to production logs.
