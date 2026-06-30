# Open HTTP Diagnostics

Open HTTP Diagnostics (OHD) is a specification-first project for consistent HTTP diagnostics across infrastructure, proxies, load balancers, web servers, and application frameworks.

The project builds on W3C Trace Context rather than replacing it. The core goal is to make HTTP request troubleshooting easier by standardizing trace propagation, access-log fields, optional response diagnostics, and deep failed-request diagnostics.

## Goals

- Ensure requests have a valid W3C `traceparent` header when possible.
- Define a common HTTP diagnostic logging profile across platforms.
- Provide safe optional response headers that help support teams identify a request.
- Support deeper failed-request diagnostics where platforms allow it.
- Provide configuration helpers and reference implementations for common web platforms.

## Capability levels

### Level 1: Common HTTP Diagnostics Logging

The lowest-friction adoption path. Platforms log a common set of fields, including W3C Trace Context headers where available.

For many platforms this requires configuration only, not code.

### Level 2: Trace Context Enforcement

A participating layer ensures a valid `traceparent` exists. If the request already contains a valid `traceparent`, it is preserved and propagated. If it is missing or invalid, the first capable participating layer generates one.

### Level 3: Response Diagnostics

Optional response headers expose support-safe diagnostic values, such as the trace ID generated or used for the request. Path-style diagnostics are optional and should use opaque owner-defined labels.

### Level 4: Deep Diagnostics

Optional failed-request tracing captures deeper request/response details, timing, routing decisions, and platform-specific diagnostic context.

## Repository layout

```text
open-http-diagnostics/
  specification/      Normative and standards-style documents
  profiles/            Adoption profiles for Levels 1-4
  guides Configure     existing product
  implementations/     Platform-specific configuration and reference implementations
  docs/                Architecture, standards, security, and vendor notes
  examples/            Example curl output, logs, and responses
  conformance-tests/   Future validation tests
```

## First reference target

The first configuration target is IIS W3C logging because IIS can already log custom request headers using W3C custom fields. The IIS helper scripts configure logging to include the `traceparent` request header.

## Status

Early design/prototype. The specification and implementations are expected to evolve.
