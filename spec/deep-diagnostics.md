# Deep Diagnostics

## Purpose

Deep Diagnostics are optional Failed Request Trace-style captures that provide detailed request troubleshooting data beyond standard access logs.

This capability is intended to be enabled selectively, such as during troubleshooting, targeted debugging, or controlled diagnostic windows.

## Relationship to FRT

Failed Request Trace is the initial deep diagnostics module for Open HTTP Diagnostics.

Deep diagnostics should use the same trace ID as the common access log and response `Trace-ID` header.

## Potential captured data

Depending on platform support and configuration, deep diagnostics may include:

- Request method, path, and status
- Request headers with redaction
- Response headers with redaction
- Timing breakdowns
- Upstream selection
- Rewrite decisions
- Authentication decisions
- WAF decisions where available
- Routing metadata
- Error details

## Redaction

Deep diagnostics must use safe defaults.

Sensitive data should be redacted unless explicitly allowlisted.

Sensitive examples:

- `Authorization`
- `Cookie`
- `Set-Cookie`
- API keys
- Session IDs
- Passwords
- Tokens
- Sensitive query parameters

## Recommended default

```yaml
deep_diagnostics:
  enabled: false
```
