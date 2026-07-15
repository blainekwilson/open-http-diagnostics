# Level 1 — Common Access Logging

**Status:** Draft 0.3  
**Level:** 1

## 1. Purpose

Level 1 defines the smallest useful common access-log profile that can be implemented by major HTTP platforms using native logging capabilities.

Level 1 records an incoming `traceparent` value when present. It does not create or modify Trace Context.

## 2. Canonical fields

The following fields are the Level 1 canonical fields. For positional text formats, they appear first and in this order.

| Position | Field | Meaning | Recommended representation |
|---:|---|---|---|
| 1 | `timestamp` | Time at which request processing completed or the access record was written | ISO 8601 with offset or UTC |
| 2 | `client_ip` | Client address as determined by the logging layer | IPv4 or IPv6 text |
| 3 | `method` | HTTP request method | Token such as `GET` |
| 4 | `host` | Effective request host | Host name, optionally including port |
| 5 | `path` | Request path excluding query string | URI path |
| 6 | `status` | Final HTTP response status | Integer |
| 7 | `duration` | Total elapsed processing time | Decimal seconds |
| 8 | `traceparent` | Incoming W3C `traceparent` header exactly as observed | Header value or `-` when absent |

A platform conforms to the Level 1 Core Profile when it produces all eight fields or an explicitly documented equivalent.

## 3. Recommended fields

The following fields should be logged when the platform can produce them safely and without custom code:

| Field | Meaning |
|---|---|
| `query` | Query string excluding the leading `?` |
| `protocol` | HTTP protocol version |
| `bytes_sent` | Response body bytes sent |
| `referer` | Incoming `Referer` header |
| `user_agent` | Incoming `User-Agent` header |
| `tracestate` | Incoming W3C `tracestate` header exactly as observed |

Recommended fields follow the canonical fields in the order shown above when a positional format is used.

## 4. Extension fields

Platforms and operators may record additional fields. In positional formats, extension fields are appended after the canonical and recommended fields.

Examples include `server_node`, `tls_version`, `tls_cipher`, `authenticated_user`, `virtual_host`, and platform-specific request identifiers.

Extension fields must not alter the position or meaning of canonical fields.

## 5. Missing values

A text log should represent a missing value as `-` unless the native logging format has a well-defined alternative. Empty positional fields should be avoided because they are difficult to distinguish from malformed records.

## 6. Delimited text

Tab-separated values are recommended when a platform supports literal tab separators. Values containing tabs, carriage returns, or line feeds must be escaped or normalized.

Example metadata and record:

```text
#OpenHTTPDiagnostics: 0.3
#Level: 1
#Fields: timestamp client_ip method host path status duration traceparent query protocol bytes_sent referer user_agent tracestate
2026-07-14T20:15:12+00:00\t203.0.113.15\tGET\texample.com\t/products\t200\t0.018\t00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01\tid=123\tHTTP/2.0\t4281\t-\tcurl/8.7.1\t-
```

## 7. Structured formats

JSON and other structured formats may use named fields rather than positional order. They must use the canonical names and meanings defined here.

## 8. Privacy and security

`query`, `referer`, `user_agent`, and client address data can contain sensitive information. Operators must evaluate collection and retention requirements. Query logging should be disabled, filtered, or redacted where secrets or personal data may be present.

## 9. Out of scope

Level 1 does not define:

- creation or repair of Trace Context;
- propagation to an upstream service;
- client-visible response diagnostics;
- deep request or response capture;
- log transport, storage, indexing, or retention.
