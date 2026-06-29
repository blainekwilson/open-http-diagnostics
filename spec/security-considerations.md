# Security Considerations

## Safe by default

Open HTTP Diagnostics should be safe by default. Core behavior should improve traceability without exposing sensitive information.

## Header exposure

`Trace-ID` is generally safer than `Trace-Path` because it identifies a request, not infrastructure.

`Trace-Path` must be treated as an optional diagnostic extension and disabled by default.

## Opaque labels

Any identifier exposed to clients must be opaque. It should only be meaningful to the infrastructure owner.

## Logs versus response headers

Response headers are visible to clients. Logs are internal. Implementations may log more detail than they expose, but logs still require redaction and access control.

## Trust boundaries

Implementations should not blindly trust client-supplied trace IDs for security decisions. Trace IDs are correlation values, not authentication or authorization controls.

## Header spoofing

Clients can send `traceparent` or other headers. Implementations should validate syntax and may mark whether trace context was received or generated using `trace_context_source`.

## Privacy

Trace IDs can be used to correlate activity. Organizations should consider retention, access control, and privacy requirements for trace logs.
