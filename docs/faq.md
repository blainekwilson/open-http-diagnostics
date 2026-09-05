# Frequently Asked Questions

## Is OHD a replacement for OpenTelemetry?

No. OHD uses W3C Trace Context and focuses on consistent HTTP infrastructure behavior, access-log mappings, client-visible correlation, and optional deep diagnostics.

## Why log three trace fields?

- `traceparent` preserves complete W3C context at the layer.
- `tracestate` preserves optional vendor state.
- `ohd_trace_id` is an easy-to-search representation of the stable trace ID.

At Level 1, these values may be absent. Level 2 establishes and propagates them.

## Why not use `X-OHD-Trace-ID`?

New `X-` prefixed HTTP fields are discouraged. The project uses `OHD-Trace-ID`.

## Is `OHD-Trace-ID` a second request ID?

No. It must equal the trace ID inside the effective `traceparent`.

## Can an incoming OHD trace ID be trusted?

No. At Level 2, usable `traceparent` is authoritative. If no usable Trace Context exists, the participant establishes a new trace rather than trusting the standalone OHD value.

## Why not return `traceparent` in the response?

The parent ID is hop-specific. The trace ID is the stable value useful for support and log searches.

## Does Level 1 require code?

The goal is configuration-only adoption where possible. IIS 8.5+, NGINX, and Apache can log incoming HTTP request fields using native configuration.

## Will OHD expose infrastructure topology?

The initial Level 3 profile returns only the trace ID. A response-visible path feature is deferred pending security and interoperability review.

## Are queries required in access logs?

No. Query is recommended rather than canonical because it can contain secrets or personal information.
