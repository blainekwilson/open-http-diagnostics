# Response Diagnostics

## Purpose

Response diagnostics allow a client or support engineer to identify the trace used for a request without requiring access to internal logs.

## OHD-Trace-ID

`OHD-Trace-ID` is an optional response header containing the trace ID associated with the request.

Example:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

Recommended behavior:

1. If a participating component generates a new `traceparent`, it should return `OHD-Trace-ID` unless disabled.
2. If a valid `traceparent` was received, returning `OHD-Trace-ID` is optional.
3. If `OHD-Trace-ID` already exists, participants should not overwrite it unless explicitly configured.

## OHD-Trace-Path

`OHD-Trace-Path` is an optional response header containing safe, opaque path hints.

Example:

```http
OHD-Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```

This header is disabled by default. It must not expose hostnames, IP addresses, account IDs, instance IDs, pod names, or other sensitive infrastructure details.
