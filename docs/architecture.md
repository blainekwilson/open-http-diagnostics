# Architecture

OHD is a specification with platform mappings and reference implementations.

```text
W3C Trace Context
        |
        v
OHD specification
  Level 1: common access logging
  Level 2: trace-context enforcement
  Level 3: optional response diagnostics
  Level 4: deep diagnostics
        |
        +--> platform configuration guides
        |
        +--> reference implementations
        |
        +--> conformance tests
```

The specification is the product. Platform configuration and code demonstrate that the specification can be adopted across heterogeneous infrastructure.

## Data flow

1. A request may arrive with `traceparent`.
2. Level 1 logs the value when present.
3. A Level 2 participant validates it or creates a new trace, then propagates context downstream.
4. Each participating layer logs the effective trace ID.
5. Level 3 may return the trace ID to the client.
6. Level 4 records deeper diagnostics using the same trace ID.
