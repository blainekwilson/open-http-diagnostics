# Architecture

Open HTTP Diagnostics separates core diagnostic behavior from optional advanced diagnostics.

```text
                 HTTP Request
                      │
                      ▼
          ┌────────────────────────┐
          │ Trace Context Profile  │
          │ - validate traceparent │
          │ - create if missing    │
          │ - preserve if valid    │
          └───────────┬────────────┘
                      │
                      ▼
          ┌────────────────────────┐
          │ Common Access Logging  │
          │ - trace_id             │
          │ - layer                │
          │ - status/duration      │
          └───────────┬────────────┘
                      │
                      ▼
          ┌────────────────────────┐
          │ Response Trace ID      │
          │ - Trace-ID header      │
          └───────────┬────────────┘
                      │
                      ▼
       Optional Diagnostic Extensions
          ┌──────────────┬──────────────┐
          ▼              ▼              ▼
   Trace-Path       Deep Diagnostics   Platform adapters
```

## Core flow

1. Request enters a participating component.
2. Component checks for valid `traceparent`.
3. If missing or invalid, component creates trace context if capable.
4. Component logs the active trace ID using common fields.
5. Component forwards trace context downstream.
6. Component may return `Trace-ID` in the response.
7. Optional extensions may add path hints or deep diagnostics.

## Layered adoption

Organizations can adopt Open HTTP Diagnostics incrementally.

### Minimal adoption

- Generate/preserve `traceparent`.
- Log `trace_id`.

### Operational adoption

- Add common access log fields.
- Return `Trace-ID` to clients.

### Advanced diagnostics

- Enable `Trace-Path` with opaque labels.
- Enable deep diagnostics during troubleshooting.

## Implementation model

Each platform implementation should be one package or module with independently configurable capabilities.

Example:

```yaml
open_http_diagnostics:
  trace_context:
    enabled: true
    create_if_missing: true

  access_logging:
    enabled: true

  response_trace_id:
    enabled: true

  trace_path:
    enabled: false

  deep_diagnostics:
    enabled: false
```
