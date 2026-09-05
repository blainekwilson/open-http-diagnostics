# Security Considerations

## Untrusted trace input

`traceparent`, `tracestate`, and `OHD-Trace-ID` received from a client are untrusted. They may be malformed, duplicated, deliberately reused, or chosen to create excessive log cardinality. Implementations must validate Level 2 inputs and must not use trace values for access control.

## Conflicting identifiers

A conflicting `OHD-Trace-ID` must not override the trace ID in usable W3C Trace Context. Implementations should record mismatches without echoing untrusted diagnostic details.

## Log injection

Header and URI values may contain characters intended to corrupt line-oriented logs. Implementations must escape or normalize control characters and delimiters.

## Sensitive data

Canonical fields do not include authorization fields, cookies, or request bodies. Query, referrer, user-agent, and address information may still contain personal data or secrets and must be governed by collection and retention policy.

## Response disclosure

A trace ID is intended to be opaque, but exposing it may still assist log-correlation attempts. Operators must avoid exposing logs publicly and must never treat knowledge of a trace ID as proof that a requester owns or initiated a request.

## Caches

A cached `OHD-Trace-ID` can falsely associate one client's response with another request. Level 3 implementations must account for caching behavior.

## Sampling and denial of service

Deep diagnostics can consume CPU, memory, disk, and network capacity. Implementations should support limits, sampling, bounded capture sizes, and emergency disable controls.
