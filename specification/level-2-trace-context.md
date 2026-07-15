# Level 2 — Trace Context Enforcement

**Status:** Initial draft  
**Level:** 2

## Purpose

Level 2 ensures that a participating HTTP layer has valid W3C Trace Context available for downstream propagation and logging.

## Required behavior

A Level 2 participant:

1. examines the incoming `traceparent` header;
2. accepts and propagates a valid value according to W3C Trace Context processing rules;
3. creates a new trace when the header is missing or unusable;
4. forwards Trace Context to the next participating layer;
5. records the effective trace information in its access or diagnostic logs.

## Trace identity and spans

The trace ID identifies the end-to-end trace. Each tracing participant may create a new parent ID for the outgoing request as required by the W3C model. Implementations must not treat the complete `traceparent` value as an immutable request ID across every hop.

For cross-layer searches, logs should expose at least:

- `trace_id` — the 32-hex-character trace ID;
- `parent_id` — the parent ID used or observed by the layer;
- `trace_flags` — the trace flags;
- `trace_source` — `incoming`, `generated`, or `restarted`.

These Level 2 fields are structured diagnostic fields and do not change the Level 1 positional field list.

## Invalid input

Implementations must follow W3C Trace Context requirements for malformed, forbidden, or unsupported values. They must not blindly trust client-provided tracing data for authorization, routing, or security decisions.

## Compatibility

OHD does not create a competing trace propagation header. `traceparent` and `tracestate` remain the wire format.
