# Trace Context Profile

## Purpose

This profile defines how HTTP infrastructure and application components should handle W3C Trace Context for operational diagnostics.

The project does not replace W3C Trace Context. It defines a practical implementation profile for consistent adoption across infrastructure layers.

## Request header

Participating components use the standard W3C request header:

```http
traceparent: 00-<trace-id>-<span-id>-<trace-flags>
```

## Required behavior

A participating component should perform the following steps for each request:

1. Inspect the incoming `traceparent` header.
2. If `traceparent` is present and valid, preserve the trace ID.
3. If `traceparent` is missing or invalid, generate a new valid `traceparent` where the platform supports request header modification.
4. Log the active trace ID using the common log field `trace_id`.
5. Forward the active trace context to the next hop where supported.

## Missing traceparent

If a request arrives without a valid `traceparent`, the first capable participating component should create one.

```text
Incoming request without traceparent
        ↓
Participating component generates traceparent
        ↓
Component logs trace_id
        ↓
Component forwards traceparent downstream
```

## Existing traceparent

If a request arrives with a valid `traceparent`, the component should not discard the trace ID.

Implementations may create a new span ID for the current hop when appropriate, but the trace ID must remain consistent across the request path.

## Invalid traceparent

If a request contains an invalid `traceparent`, implementations should either:

- create a new trace context, or
- log the invalid value separately and create a new trace context.

Implementations must not forward malformed trace context as if it were valid.

## Logging fields

At minimum, implementations should log:

```json
{
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "span_id": "00f067aa0ba902b7",
  "trace_flags": "01",
  "trace_context_source": "received"
}
```

Recommended values for `trace_context_source`:

- `received` — valid trace context was received from an upstream component.
- `generated` — this component generated trace context because it was missing or invalid.
- `unavailable` — the component could not inspect or create trace context.

## Configuration

Recommended default:

```yaml
trace_context:
  enabled: true
  create_if_missing: true
  replace_invalid: true
```
