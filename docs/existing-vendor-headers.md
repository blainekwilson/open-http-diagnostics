# Existing Vendor and Platform Headers

This document tracks existing request and response correlation fields. It is descriptive, not normative.

Examples to research and document include:

- CloudFront request identifiers;
- AWS X-Ray trace headers;
- API Gateway request identifiers;
- load-balancer generated request IDs;
- WAF transaction identifiers;
- reverse-proxy request ID conventions;
- framework-specific correlation IDs.

The objective is to map existing identifiers to OHD without replacing useful native telemetry.
