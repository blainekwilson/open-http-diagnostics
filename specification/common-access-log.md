# Common HTTP Diagnostics Logging Profile

## Purpose

This document defines common logging fields for HTTP infrastructure and applications.

## Core fields

Recommended fields:

| Field | Description |
|---|---|
| `timestamp` | Request completion timestamp |
| `traceparent` | Complete W3C Trace Context header value |
| `trace_id` | Extracted trace ID where supported |
| `method` | HTTP method |
| `scheme` | HTTP scheme |
| `host` | Request host |
| `path` | Request path without query string |
| `query` | Query string only if explicitly allowed by policy |
| `status` | HTTP response status |
| `duration_ms` | Request duration in milliseconds |
| `client_ip` | Client IP according to local platform policy |
| `user_agent` | User-Agent header where appropriate |
| `referer` | Referer header where appropriate |
| `layer` | Logical layer such as edge, waf, lb, proxy, app |
| `node_id` | Opaque owner-defined node or participant ID |
| `ohd_trace_id` | Response trace ID where emitted |
| `ohd_trace_path` | Response diagnostic path where emitted |

## Query string guidance

Query strings may contain secrets, tokens, or personal information. Implementations should avoid logging raw query strings unless explicitly configured by the infrastructure owner.  If you need to log this information then it should be masked using OHD Level 3 logging.

## Header guidance

Sensitive request headers such as `Authorization`, `Cookie`, and security tokens must not be logged by default.  If you need to log this information then it should be masked using OHD Level 3 logging.
