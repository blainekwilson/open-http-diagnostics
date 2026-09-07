# Google Cloud Run Implementation

Planned application middleware and OpenTelemetry integration for OHD Levels 2
and 3 in Cloud Run containers.

The implementation should preserve W3C Trace Context across requests and
outbound calls, derive `OHD-Trace-ID` from the effective W3C trace ID, enrich
structured logs, and add the response field at Level 3.
