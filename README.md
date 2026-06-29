# Open HTTP Diagnostics

Open HTTP Diagnostics is a specification and set of reference implementations for consistent HTTP diagnostics across web servers, reverse proxies, load balancers, WAFs, application frameworks, and cloud infrastructure.

The project builds on **W3C Trace Context** rather than replacing it. Its goal is to make HTTP request troubleshooting easier by standardizing how trace identifiers are created, propagated, logged, and optionally returned to clients for support-safe troubleshooting.

## Goals

- Ensure every participating HTTP layer has a valid `traceparent` request header.
- Generate `traceparent` when it is missing or invalid, where supported.
- Preserve and propagate existing W3C Trace Context.
- Log common HTTP access fields using consistent names across platforms.
- Optionally return a support-safe trace identifier in the HTTP response.
- Optionally expose opaque diagnostic path hints using a response header.
- Provide a foundation for deeper Failed Request Trace-style diagnostics.

## Non-goals

- Replace OpenTelemetry, W3C Trace Context, or vendor observability tools.
- Expose internal hostnames, private IP addresses, instance IDs, pod names, account IDs, or sensitive infrastructure details.
- Act as a log aggregation platform or SIEM.
- Require every infrastructure component to support every feature.

## Core concepts

Open HTTP Diagnostics is organized around four capabilities:

1. **Trace Context Profile**  
   A standard operational profile for creating, validating, preserving, and propagating W3C `traceparent` headers.

2. **Common Access Log**  
   A common JSON logging shape for HTTP access logs across platforms.

3. **Response Trace ID**  
   An optional response header that returns the trace ID to clients and support teams.

4. **Diagnostic Extensions**  
   Optional response path hints and deep request diagnostics for environments that want additional troubleshooting detail.

## Default posture

The project should be safe by default.

```yaml
trace_context:
  enabled: true
  create_if_missing: true

access_logging:
  enabled: true
  format: json

response_trace_id:
  enabled: true

trace_path:
  enabled: false

deep_diagnostics:
  enabled: false
```

## Example response

```http
HTTP/1.1 200 OK
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

If optional diagnostic path hints are enabled:

```http
HTTP/1.1 200 OK
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```

`Trace-Path` values must be opaque, owner-defined labels. They must not disclose hostnames, private IPs, instance IDs, Kubernetes pod names, cloud account IDs, or vendor-sensitive details.

## Repository layout

```text
spec/                    Specification documents
docs/                    Architecture and implementation guidance
implementations/          Reference implementations by platform
examples/                 Example requests, responses, and logs
tests/conformance/        Future conformance tests
```

## Status

This project is in early design. The initial goal is to define the specification, produce a working NGINX/OpenResty reference implementation, and migrate the existing Failed Request Trace prototype into the broader diagnostics framework.
