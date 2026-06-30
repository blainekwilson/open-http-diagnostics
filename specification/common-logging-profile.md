# Open HTTP Diagnostics (OHD) Common Access Logging Profile
**Version:** Draft 0.2  
**Level:** 1 – Common Access Logging Profile  
**Status:** Draft
---
# 1. Introduction
The Open HTTP Diagnostics (OHD) Common Access Logging Profile establishes a common HTTP access logging standard across web servers, reverse proxies, load balancers, Web Application Firewalls (WAFs), application frameworks, and applications.
The goal is to define a minimum set of logging fields that can be consistently produced regardless of the underlying HTTP platform while remaining compatible with existing logging infrastructure.
This specification complements the W3C Trace Context specification and does **not** replace existing platform logging formats.
---
# 2. Goals
The goals of the OHD Common Access Logging Profile are to:
- Establish common HTTP access log field names.
- Encourage adoption of W3C Trace Context.
- Simplify troubleshooting across heterogeneous infrastructure.
- Improve interoperability with SIEM and observability platforms.
- Minimize implementation effort by leveraging existing platform logging capabilities.
- Provide the foundation for higher Open HTTP Diagnostics levels.
---
# 3. Scope
Level 1 defines only HTTP access logging.
Level 1 does **not** define:
- Trace Context generation
- Trace Context propagation
- Response diagnostic headers
- Deep request tracing
- Log transport
- Log storage
- SIEM integration
These capabilities are introduced in later OHD levels.
---
# 4. Core Profile (MUST)
Every OHD Level 1 implementation SHALL support the following canonical fields.
| Position | Field | Description |
|----------|-------|-------------|
| 1 | timestamp | Date and time the request was processed (ISO-8601 recommended). |
| 2 | client_ip | Source IP address of the client. |
| 3 | method | HTTP request method. |
| 4 | host | HTTP Host header. |
| 5 | path | Request path excluding the query string. |
| 6 | status | HTTP response status code. |
| 7 | duration | Total request processing time. |
| 8 | traceparent | Incoming W3C Trace Context `traceparent` request header. |
These fields form the OHD Core Profile and SHALL always appear first in the access log.
---
# 5. Recommended Fields (SHOULD)
Platforms SHOULD log the following fields when supported.
| Field | Description |
|-------|-------------|
| query | HTTP query string. |
| protocol | HTTP protocol version. |
| bytes_sent | Number of response bytes sent. |
| referer | HTTP Referer request header. |
| user_agent | HTTP User-Agent request header. |
| tracestate | Incoming W3C Trace Context `tracestate` request header. |
Recommended fields SHALL appear immediately after the Core Profile fields.
---
# 6. Platform Extensions (MAY)
Platforms MAY log additional fields.
Examples include:
- server_node
- server_ip
- server_port
- authenticated_user
- tls_version
- tls_cipher
- request_id
- virtual_host
Platform-specific fields SHALL be appended **after** the Core Profile and Recommended fields.
The order of platform-specific fields is implementation-defined.
---
# 7. Metadata
When the logging format supports metadata, implementations SHOULD identify OHD logs.
Example:
```text
#OpenHTTPDiagnostics: 1.0
#Profile: Core
#Platform: nginx
#Fields: timestamp client_ip method host path status duration traceparent query protocol bytes_sent referer user_agent tracestate
```
Platforms that already define metadata formats (such as IIS W3C logging) SHOULD include equivalent information where practical.
---
# 8. Example Log Entry
Example using tab-separated values.
```text
2026-06-30T18:42:12+00:00	203.0.113.15	GET	example.com	/products	200	0.018	00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01	id=123	HTTP/2.0	4281		curl/8.7.1
```
---
# 9. W3C Trace Context
Open HTTP Diagnostics adopts the W3C Trace Context specification.
If a valid `traceparent` request header exists, implementations SHALL log it exactly as received.
If a `tracestate` request header exists and is supported, implementations SHOULD log it exactly as received.
Generation or propagation of Trace Context is outside the scope of Level 1.
---
# 10. Platform Mapping
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
Platform documentation SHALL reference this specification rather than redefining the canonical field names.
---
# 11. Conformance
A platform conforms to the OHD Common Access Logging Profile when:
1. The Core Profile fields are logged.
2. Core Profile fields appear in the canonical order.
3. Existing `traceparent` headers are logged without modification.
4. Additional fields are appended after the canonical OHD fields.
5. Platform-specific extensions are documented.
---
# 12. Future Levels
The Common Access Logging Profile serves as the foundation for additional Open HTTP Diagnostics capabilities.
| Level | Description |
|--------|-------------|
| Level 1 | Common Access Logging Profile |
| Level 2 | W3C Trace Context generation and propagation |
| Level 3 | Diagnostic response headers |
| Level 4 | Deep request diagnostics (Failed Request Trace) |
Each level builds upon the previous level while remaining independently deployable.