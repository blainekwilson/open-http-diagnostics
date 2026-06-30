# Architecture

Open HTTP Diagnostics is organized as a specification with reference configurations and implementations.

```text
HTTP request
   |
   | traceparent created or preserved
   v
Infrastructure and application layers
   |
   | common fields logged at each participating layer
   v
HTTP response
   |
   | optional OHD-Trace-ID / OHD-Trace-Path
   v
Client or support engineer
```

## Design model

### Specification first

The primary artifact is the behavior specification, not a specific library.

### Configuration where possible

If a platform can already conform through configuration, the project should provide scripts and documentation rather than unnecessary code.

### Reference implementation where needed

If a platform cannot natively conform, the project should provide middleware, modules, or helper libraries.

## Capability layers

1. Common logging
2. Trace context enforcement
3. Response diagnostics
4. Deep diagnostics
