# Response Trace ID

## Purpose

The Response Trace ID feature returns the active trace ID to the client so users, support teams, and engineers can correlate a visible HTTP response with server-side logs.

This is especially useful when a participating component generated `traceparent` because the client did not send one.

## Header

```http
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

## Behavior

Recommended behavior:

1. If the request has a valid trace ID, the implementation may return `Trace-ID`.
2. If the implementation generated the trace ID, the implementation should return `Trace-ID` unless disabled.
3. If a `Trace-ID` response header already exists, the implementation must not overwrite it unless explicitly configured.
4. The value must be the W3C trace ID, not the full `traceparent` value.

## Why not return full traceparent?

The client usually needs a stable support correlation value, not span IDs or trace flags. Returning only the trace ID keeps the response header simpler.

## Example

```http
HTTP/1.1 500 Internal Server Error
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

A support ticket can then include:

```text
The failed request returned Trace-ID 4bf92f3577b34da6a3ce929d0e0e4736.
```
