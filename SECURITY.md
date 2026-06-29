# Security Policy and Considerations

Open HTTP Diagnostics must be safe by default. The project is intended to improve troubleshooting without exposing sensitive infrastructure details.

## Sensitive values that must not be exposed

Implementations must not expose the following values in response headers by default:

- Internal hostnames
- Private IP addresses
- Public IP addresses of internal infrastructure unless explicitly approved
- EC2 instance IDs
- Kubernetes pod names or UIDs
- Container IDs
- Cloud account IDs
- Region/account/resource identifiers that disclose architecture
- Usernames
- Session identifiers
- Authentication tokens
- Cookies
- Authorization headers
- Raw upstream names
- Raw WAF, CDN, or proxy node identifiers unless approved by the owner

## Opaque identifiers

Diagnostic identifiers should be opaque and deployment-defined.

Good examples:

```http
Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```

Bad examples:

```http
Trace-Path: waf="imperva-iad-proxy-123.internal"; app="prod-web-04.company.local"
```

## Response headers

`Trace-ID` is intended to be support-safe because it identifies a request, not infrastructure. However, organizations should still consider whether returning trace IDs to clients aligns with their incident response and privacy policies.

`Trace-Path` is more sensitive and should be disabled by default.

## Logging

Logs may contain more detail than response headers, but implementations should still redact sensitive values by default. Deep diagnostics must use explicit allowlists for sensitive request and response data.

## Reporting vulnerabilities

Do not open a public issue for sensitive vulnerabilities. Use the repository owner's preferred private reporting method once configured.
