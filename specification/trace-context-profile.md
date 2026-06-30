# Trace Context Profile

## Purpose

This profile defines how Open HTTP Diagnostics participants use W3C Trace Context for HTTP request correlation.

## Request header

Open HTTP Diagnostics uses the W3C `traceparent` request header.

Example:

```http
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

## Behavior

A participating component should follow this behavior:

1. If `traceparent` is present and valid, preserve it and propagate it.
2. If `traceparent` is missing or invalid and the component is capable of generating one, create a valid `traceparent` before forwarding the request.
3. Log the complete `traceparent` value where supported.
4. Log extracted fields where supported:
   - `trace_id`
   - `span_id`
   - `trace_flags`
   - `traceparent_source`

## Non-goals

This project does not replace W3C Trace Context or OpenTelemetry.
