# Existing Standards

Open HTTP Diagnostics should build on existing standards whenever possible.

## W3C Trace Context

W3C Trace Context defines the `traceparent` and `tracestate` HTTP headers used to propagate trace identity across services.

Open HTTP Diagnostics uses W3C Trace Context as the request identity foundation.

## OpenTelemetry

OpenTelemetry commonly uses W3C Trace Context for context propagation. Open HTTP Diagnostics should complement OpenTelemetry rather than compete with it.

The distinction:

- OpenTelemetry provides instrumentation, metrics, traces, and observability pipelines.
- Open HTTP Diagnostics defines an operational HTTP profile for trace propagation, common access logging, response trace IDs, and optional HTTP-layer diagnostics.

## HTTP structured fields

Future versions of optional diagnostic response headers may use HTTP Structured Fields syntax for safer parsing.

## Existing request IDs

Many platforms support request IDs or correlation IDs. Open HTTP Diagnostics should document how these relate to W3C trace IDs and avoid unnecessary competing identifiers.
