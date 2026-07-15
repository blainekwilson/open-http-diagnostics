# Level 3 — Response Diagnostics

**Status:** Initial draft  
**Level:** 3

## Purpose

Level 3 provides optional client-visible values that allow a user or support team to identify the trace associated with an HTTP response.

## Response trace identifier

An implementation may return the effective trace ID in a response field named `OHD-Trace-ID`.

Example:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

The response contains the trace ID only, not the complete `traceparent`, because the parent ID can change at each hop.

## Recommended behavior

- When the participating layer generated a trace because none was available, it should return `OHD-Trace-ID` unless disabled by policy.
- An implementation may return the value for all requests for operational consistency.
- A layer must not overwrite a different response value without an explicit precedence policy.
- The header is diagnostic only and must not be used as proof of identity or authorization.

## Path and layer hints

A response-visible path feature remains experimental and is disabled by default. Any future form must use opaque, owner-defined identifiers and must not expose hostnames, IP addresses, cloud resource IDs, account IDs, software versions, or internal topology.

The initial Level 3 profile standardizes the trace identifier first. Path diagnostics may be proposed separately after practical implementation and security review.

## Browser access

Applications using cross-origin browser requests may need to expose the response field using CORS response configuration before JavaScript can read it.
