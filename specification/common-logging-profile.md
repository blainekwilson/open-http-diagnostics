# Open HTTP Diagnostics (OHD) Common Logging Profile

**Version:** Draft 0.1  
**Level:** 1 – Common Logging Profile  
**Status:** Draft

---

# 1. Introduction

The Open HTTP Diagnostics (OHD) Common Logging Profile establishes a consistent HTTP access logging standard across web servers, reverse proxies, load balancers, web application firewalls (WAFs), application frameworks, and applications.

The purpose of this specification is to simplify troubleshooting by defining a common set of logging fields that can be consistently produced regardless of the underlying HTTP infrastructure.

This specification complements the W3C Trace Context specification and does **not** replace existing platform logging formats.

---

# 2. Goals

The goals of the OHD Common Logging Profile are to:

- Establish consistent HTTP access log field names.
- Encourage adoption of W3C Trace Context.
- Simplify searching across heterogeneous infrastructure.
- Improve interoperability between logging and SIEM platforms.
- Minimize implementation effort by leveraging existing platform capabilities.
- Serve as the foundation for higher Open HTTP Diagnostics levels.

---

# 3. Scope

Level 1 defines only HTTP access logging.

It does **not** define:

- Trace Context generation
- Trace Context propagation
- Response diagnostic headers
- Deep request tracing
- Log transport
- Log storage
- SIEM integration

These capabilities are introduced in later OHD levels.

---

# 4. Canonical Field Definitions

The following fields define the OHD Common Logging Profile.

| Field | Description |
|--------|-------------|
| timestamp | Date and time the request was processed (ISO-8601 recommended). |
| client_ip | Source IP address of the client. |
| method | HTTP request method. |
| scheme | HTTP or HTTPS. |
| host | HTTP Host header. |
| path | Request path excluding the query string. |
| query | HTTP query string. |
| protocol | HTTP protocol version. |
| status | HTTP response status code. |
| bytes_sent | Number of response bytes sent to the client. |
| duration | Total request processing time. |
| traceparent | Incoming W3C Trace Context `traceparent` request header. |
| tracestate | Incoming W3C Trace Context `tracestate` request header when present. |
| referer | HTTP Referer request header. |
| user_agent | HTTP User-Agent request header. |

---

# 5. Optional Fields

Implementations MAY log additional fields.

Examples include:

| Field | Description |
|--------|-------------|
| server_ip | Local server IP address. |
| server_port | Local listening port. |
| authenticated_user | Authenticated user. |
| tls_version | Negotiated TLS version. |
| tls_cipher | Negotiated cipher suite. |
| request_id | Platform-specific request identifier. |
| virtual_host | Platform-specific virtual host or site name. |

Platform-specific extensions SHOULD be documented.

---

# 6. Recommended Field Order

To simplify parsing and comparison across platforms, the following field order is recommended.

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

Platforms are encouraged to preserve this ordering whenever practical.

---

# 7. Example Log Record

The following example illustrates a tab-separated log entry.

```text
2026-06-30T18:42:12+00:00	203.0.113.15	GET	https	example.com	/products	id=123	HTTP/2.0	200	4281	0.018	00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01		curl/8.7.1
```

The fields correspond to:

| Position | Value |
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
| 13 | tracestate (empty) |
| 14 | referer (empty) |
| 15 | user_agent |

---

# 8. Trace Context

Open HTTP Diagnostics adopts the W3C Trace Context specification.

If a valid `traceparent` request header exists, implementations SHOULD log it exactly as received.

If a `tracestate` request header exists, implementations SHOULD log it exactly as received.

Generation or propagation of Trace Context is outside the scope of Level 1.

---

# 9. Platform Mapping

Each supported platform SHALL document how the canonical OHD fields map to native logging capabilities.

Examples include:

- IIS W3C Logging
- NGINX
- Apache HTTP Server
- Envoy Proxy
- HAProxy
- ASP.NET Core
- Flask
- Express.js

Platform-specific documentation SHOULD reference this specification rather than redefining the field names.

---

# 10. Conformance

A platform conforms to the OHD Common Logging Profile when:

1. The canonical OHD fields are logged.
2. Logged values correspond to the field definitions in this specification.
3. Existing W3C Trace Context headers are logged without modification.
4. Platform-specific extensions are documented.

---

# 11. Future Levels

The Common Logging Profile serves as the foundation for additional Open HTTP Diagnostics capabilities.

| Level | Description |
|--------|-------------|
| Level 1 | Common HTTP Diagnostics Logging Profile |
| Level 2 | W3C Trace Context generation and propagation |
| Level 3 | Diagnostic response headers |
| Level 4 | Deep request diagnostics (Failed Request Trace) |

Each level builds upon the previous level while remaining independently deployable.