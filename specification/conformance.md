# Conformance

**Status:** Draft 0.4

## General rules

- Normative requirements are defined only in `specification/`.
- Platform guides describe mappings and limitations; they do not redefine OHD.
- Implementations must declare the OHD levels and draft version they support.
- Partial support must be described explicitly.

## Level 1

A Level 1 implementation or mapping must provide the ten canonical fields defined by the Level 1 specification, including `traceparent`, `tracestate`, and `ohd_trace_id`.

For positional OHD-native formats, canonical fields must appear first and in the defined order. Native formats with fixed names or ordering may conform through a documented mapping.

## Level 2

A Level 2 implementation must demonstrate:

- continuation of usable incoming Trace Context;
- establishment of a new trace when no usable context exists;
- derivation of `OHD-Trace-ID` from the effective trace ID;
- correction of a conflicting convenience value;
- downstream propagation of all applicable fields.

## Level 3

A Level 3 implementation must demonstrate that the response contains exactly one `OHD-Trace-ID` matching the effective trace ID for the request.

## Level 4

A Level 4 implementation must demonstrate correlation with the same trace ID, default protection of sensitive data, bounded capture, and selective activation.

## Version claims

A conformance claim should identify:

```text
OHD-Draft: 0.4
OHD-Levels: 1,2,3
Platform: nginx-openresty
Implementation-Version: 0.1.0
```
