# Security Considerations

Open HTTP Diagnostics must avoid turning troubleshooting headers or logs into an information disclosure issue.

## Response headers

Response-visible diagnostics should use support-safe identifiers.

Safe examples:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
OHD-Trace-Path: edge="a1"; waf="b2"; app="123"
```

Unsafe examples:

```http
OHD-Trace-Path: proxy="ip-10-1-2-3.ec2.internal"
OHD-Trace-Path: app="i-0123456789abcdef0"
OHD-Trace-Path: pod="checkout-api-7d8f9c5c9b-x4n2p"
```

## Logs

Logs should avoid raw secrets and should follow organizational data retention and privacy requirements.
