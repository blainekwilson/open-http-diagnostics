# Level 1 — Common Access Logging

**Status:** Draft 0.4  
**Level:** 1

## 1. Purpose

Level 1 defines the smallest useful common access-log profile that major HTTP platforms can produce using native logging capabilities.

Level 1 observes and records tracing fields. It does not create, validate, repair, or propagate Trace Context.

Header definitions are authoritative in [OHD HTTP Header Fields](header-fields.md).

## 2. Canonical fields

For positional text formats, the following fields appear first and in this order:

| Position | Field | Meaning | Recommended representation |
|---:|---|---|---|
| 1 | `timestamp` | Time request processing completed or the record was written | ISO 8601 with offset or UTC |
| 2 | `client_ip` | Client address as determined by the logging layer | IPv4 or IPv6 text |
| 3 | `method` | HTTP request method | Token such as `GET` |
| 4 | `host` | Effective request host | Host name, optionally including port |
| 5 | `path` | Request path excluding query string | URI path |
| 6 | `status` | Final HTTP response status | Integer |
| 7 | `duration` | Total elapsed processing time | Decimal seconds |
| 8 | `traceparent` | Incoming `traceparent` exactly as observed | Header value or `-` |
| 9 | `tracestate` | Incoming `tracestate` exactly as observed | Header value or `-` |
| 10 | `ohd_trace_id` | Incoming `OHD-Trace-ID` exactly as observed | 32 lowercase hex characters or `-` |

A platform conforms to the Level 1 Core Profile when it produces all ten fields or a documented semantic mapping where native field names or ordering cannot be controlled.

Level 1 does not require the three trace fields to be populated on every request. Missing values are expected until Level 2 is deployed or clients provide them.

## 3. Recommended fields

The following fields should be logged when the platform can produce them safely without custom code:

| Field | Meaning |
|---|---|
| `query` | Query string excluding the leading `?` |
| `protocol` | HTTP protocol version |
| `bytes_sent` | Response body bytes sent |
| `referer` | Incoming `Referer` field |
| `user_agent` | Incoming `User-Agent` field |

Recommended fields follow the canonical fields in the order shown when a positional format is used.

## 4. Extension fields

Platforms and operators may record additional fields. In positional formats, extension fields are appended after canonical and recommended fields.

Examples include `server_node`, `tls_version`, `tls_cipher`, `authenticated_user`, `virtual_host`, and platform-specific request identifiers.

Extension fields must not alter the position or meaning of canonical fields.

## 5. Missing values

A text log should represent a missing value as `-` unless the native logging format has a well-defined alternative. Empty positional fields should be avoided.

## 6. Delimited text

Tab-separated values are recommended when a platform supports literal tabs. Values containing tabs, carriage returns, or line feeds must be escaped or normalized.

```text
#OpenHTTPDiagnostics: 0.4
#Level: 1
#Fields: timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent
2026-07-15T20:15:12+00:00\t203.0.113.15\tGET\texample.com\t/products\t200\t0.018\t00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01\tvendor=value\t4bf92f3577b34da6a3ce929d0e0e4736\tid=123\tHTTP/2.0\t4281\t-\tcurl/8.7.1
```

## 7. Structured formats

JSON and other structured formats may use named properties rather than positional order. They must use the canonical names and meanings defined here.

## 8. Native-format conformance

Some products, including IIS W3C logging, control native names and ordering. Such products may conform through a documented mapping rather than rewriting the native format. A platform guide must identify unit conversions and ordering differences.

## 9. Privacy and security

Client addresses, queries, referrers, and user-agent values can contain sensitive information. Operators must evaluate collection and retention requirements. Query logging should be disabled, filtered, or redacted where secrets or personal data may be present.

Trace identifiers are correlation values, not secrets, but access to logs should still be controlled.

## 10. Out of scope

Level 1 does not define:

- creation, validation, or repair of Trace Context;
- propagation to an upstream service;
- client-visible response diagnostics;
- deep request or response capture;
- log transport, storage, indexing, or retention.
