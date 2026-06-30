# Level 3: Response Diagnostics

Level 3 provides optional response-visible diagnostic headers.

## OHD-Trace-ID

`OHD-Trace-ID` returns the trace ID associated with the request. It helps clients and support teams report the exact request to search for in logs.

## OHD-Trace-Path

`OHD-Trace-Path` is optional and disabled by default. It provides safe opaque labels describing logical layers traversed by the request.

## Recommended defaults

```yaml
response_trace_id:
  enabled: true

trace_path:
  enabled: false
```
