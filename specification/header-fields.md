# OHD HTTP Header Fields

**Status:** Draft 0.4  
**Applies to:** Levels 1–4

This document is the authoritative definition of HTTP header fields used by Open HTTP Diagnostics.

## 1. `traceparent`

`traceparent` is defined by W3C Trace Context. OHD does not redefine its wire format or processing rules.

For version `00`, a typical value is:

```http
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

The 32 lowercase hexadecimal characters in the second component are the trace ID.

## 2. `tracestate`

`tracestate` is defined by W3C Trace Context and carries vendor-specific state associated with `traceparent`.

OHD participants must follow W3C processing and size rules. OHD does not interpret vendor entries.

## 3. `OHD-Trace-ID`

`OHD-Trace-ID` is an OHD convenience field containing only the trace ID from the effective `traceparent`.

Example:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

### 3.1 Format

The value must:

- contain exactly 32 lowercase hexadecimal characters;
- represent 16 bytes;
- not be all zeroes;
- equal the trace ID in the effective `traceparent`.

### 3.2 Authority

`traceparent` is authoritative. `OHD-Trace-ID` must never establish an independent trace identity.

If both fields are received and their trace IDs differ, a Level 2 participant must derive `OHD-Trace-ID` from the effective `traceparent`. The mismatch should be recorded when the implementation supports diagnostic events.

If `OHD-Trace-ID` is received without a usable `traceparent`, a Level 2 participant must not construct a trace from the client-supplied convenience value. It must establish a new trace according to W3C Trace Context and replace `OHD-Trace-ID` with the new trace ID.

### 3.3 Request use

At Level 1, a platform logs `OHD-Trace-ID` exactly as received, if present.

At Level 2, a participant ensures the outgoing request contains an `OHD-Trace-ID` matching the outgoing `traceparent`.

### 3.4 Response use

At Level 3, a participant returns the effective trace ID using the same field name:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

The response field is single-valued. Intermediaries must not append multiple OHD trace IDs.

### 3.5 Security

`OHD-Trace-ID` is diagnostic correlation data. It is not authentication, authorization, proof of request ownership, or a security token.

## 4. Field-name representation in logs

Named structured logs use these canonical property names:

```text
traceparent
tracestate
ohd_trace_id
```

The HTTP field remains `OHD-Trace-ID`; `ohd_trace_id` is its canonical log-field representation.

## 5. References

- W3C Trace Context: <https://www.w3.org/TR/trace-context/>
- RFC 6648, deprecating new `X-` prefixes: <https://www.rfc-editor.org/rfc/rfc6648>
