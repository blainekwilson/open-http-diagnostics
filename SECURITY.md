# Security Policy

Open HTTP Diagnostics is intended to improve troubleshooting without exposing sensitive infrastructure details.

## Security principles

- Do not expose internal hostnames.
- Do not expose private IP addresses.
- Do not expose cloud account IDs, subscription IDs, project IDs, or tenant IDs.
- Do not expose EC2 instance IDs, container IDs, Kubernetes pod names, or node names by default.
- Do not expose usernames, session IDs, authorization headers, cookies, or application secrets.
- Use opaque owner-defined identifiers for diagnostic path labels.
- Make response path diagnostics optional and disabled by default.

## Recommended response header posture

`OHD-Trace-ID` may be enabled by default where appropriate because it identifies the request, not the infrastructure.

`OHD-Trace-Path` should be optional and disabled by default unless the infrastructure owner has defined safe opaque labels.

## Reporting security issues

Please do not open public issues for security vulnerabilities. Contact the maintainers privately using the preferred contact method listed in the repository.
