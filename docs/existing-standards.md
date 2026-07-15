# Existing Standards

OHD is designed to complement existing standards and formats.

## W3C Trace Context

Defines `traceparent` and `tracestate` propagation. OHD Level 2 uses these fields and does not define a competing request propagation header.

## W3C Extended Log File Format

Provides a widely used self-describing text log pattern, including `#Fields` metadata. OHD borrows the concept of self-describing records but defines platform-neutral semantic field names.

## OpenTelemetry

Provides APIs, SDKs, semantic conventions, and telemetry pipelines. OHD focuses on lightweight HTTP infrastructure configuration and interoperable diagnostic behavior; it can feed or complement OpenTelemetry deployments.

## HTTP Structured Fields

May be considered for future response diagnostics if a structured multi-value response field is standardized.
