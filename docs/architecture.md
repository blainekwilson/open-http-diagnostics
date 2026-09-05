# Architecture

Open HTTP Diagnostics is a conformance specification supported by platform mappings, optional implementations, examples, and tests.

```text
W3C Trace Context
        |
        v
+-------------------------------+
| OHD Header Field Definitions  |
+-------------------------------+
        |
        +--> Level 1: common access logging
        +--> Level 2: establish and propagate trace context
        +--> Level 3: return OHD-Trace-ID
        +--> Level 4: selective deep diagnostics
```

## One trace identity

OHD does not create a parallel tracing system.

- `traceparent` is authoritative.
- `tracestate` carries W3C vendor state.
- `OHD-Trace-ID` is the trace ID extracted from the effective `traceparent`.

The same trace ID correlates request headers, access logs, downstream calls, response diagnostics, and deep diagnostic records.

## Repository boundaries

```text
specification/      normative behavior
platforms/          configuration and product mappings
implementations/    code that supplies missing behavior
examples/           non-normative samples
conformance-tests/  fixtures and executable validators
docs/               architecture and rationale
```

These top-level boundaries are intentionally stable.

## Platform versus implementation

A platform guide answers: "How far can this product conform using native capabilities?"

An implementation answers: "What code supplies behavior the platform does not provide natively?"

For example, NGINX configuration can log incoming trace fields at Level 1. OpenResty or a native NGINX module is needed to validate or create Trace Context at Level 2.

## Extension strategy

New products are added under `platforms/`. New code is added under `implementations/`. New normative requirements require specification review and conformance updates rather than a new top-level directory.
