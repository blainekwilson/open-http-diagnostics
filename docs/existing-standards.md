# Existing Standards

## W3C Trace Context

Open HTTP Diagnostics uses W3C Trace Context for request correlation. The primary request header is `traceparent`.

## OpenTelemetry

OpenTelemetry commonly uses W3C Trace Context for propagation. Open HTTP Diagnostics is complementary to OpenTelemetry and focuses on consistent infrastructure logging and operational diagnostics.

## HTTP structured fields

Future versions of `OHD-Trace-Path` may use structured field syntax for safer parsing.
