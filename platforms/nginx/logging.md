# NGINX Level 1 – Common HTTP Diagnostics Logging

## Overview

NGINX provides a flexible logging system that allows request headers, response headers, server variables, and request timing information to be written to the access log without requiring custom modules.

Open HTTP Diagnostics (OHD) Level 1 uses this capability to create a consistent logging profile across web servers and application frameworks while remaining fully compatible with the W3C Trace Context specification.

No custom code is required to achieve Level 1 compliance.

---

# Objectives

An OHD Level 1 compliant NGINX configuration should:

- Log the incoming `traceparent` request header.
- Log the incoming `tracestate` request header when present.
- Log common HTTP request and response information using consistent field names.
- Preserve compatibility with existing log collection and SIEM platforms.
- Avoid modifying requests or responses.

Level 1 does **not** generate missing Trace Context headers or inject diagnostic response headers. Those capabilities are introduced in higher OHD levels.

---

# Recommended Logged Fields

| OHD Field | NGINX Variable |
|-----------|----------------|
| timestamp | `$time_iso8601` |
| client_ip | `$remote_addr` |
| method | `$request_method` |
| scheme | `$scheme` |
| host | `$host` |
| path | `$uri` |
| query | `$args` |
| protocol | `$server_protocol` |
| status | `$status` |
| bytes_sent | `$body_bytes_sent` |
| duration | `$request_time` |
| traceparent | `$http_traceparent` |
| tracestate | `$http_tracestate` |
| referer | `$http_referer` |
| user_agent | `$http_user_agent` |

---

# Example OHD Log Format

```nginx
log_format ohd
    '$time_iso8601\t'
    '$remote_addr\t'
    '$request_method\t'
    '$scheme\t'
    '$host\t'
    '$uri\t'
    '$args\t'
    '$server_protocol\t'
    '$status\t'
    '$body_bytes_sent\t'
    '$request_time\t'
    '$http_traceparent\t'
    '$http_tracestate\t'
    '$http_referer\t'
    '$http_user_agent';

access_log /var/log/nginx/access.log ohd;
```

---

# Example Log Entry

```
2026-06-30T18:42:12+00:00	203.0.113.15	GET	https	example.com	/products	id=123	HTTP/2.0	200	4281	0.018	00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01		curl/8.7.1
```

---

# Field Order

| Position | Field |
|----------|-------|
| 1 | timestamp |
| 2 | client_ip |
| 3 | method |
| 4 | scheme |
| 5 | host |
| 6 | path |
| 7 | query |
| 8 | protocol |
| 9 | status |
| 10 | bytes_sent |
| 11 | duration |
| 12 | traceparent |
| 13 | tracestate |
| 14 | referer |
| 15 | user_agent |

---

# Conformance

An NGINX deployment conforms to OHD Level 1 when:

- A common logging profile is configured.
- The `traceparent` request header is logged exactly as received.
- The `tracestate` request header is logged when present.
- No modifications are made to Trace Context headers.

Generation of missing `traceparent` headers is **not** part of Level 1.

---

# Related OHD Levels

| Level | Description |
|-------|-------------|
| Level 1 | Common HTTP Diagnostics logging profile |
| Level 2 | Trace Context generation and propagation |
| Level 3 | Optional diagnostic response headers |
| Level 4 | Deep request diagnostics (Failed Request Trace) |

NGINX can achieve Level 1 using configuration alone. Higher levels require additional implementations such as the OpenResty reference implementation or a native NGINX module.
