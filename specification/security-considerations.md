# Security Considerations

## Untrusted trace input

Trace Context received from a client is untrusted. It may be malformed, intentionally duplicated, reused, or selected to create excessive log cardinality. Implementations must validate it and must not use it for access control.

## Log injection

Header and URI values may contain characters intended to corrupt line-oriented logs. Implementations must escape or normalize control characters and delimiters.

## Sensitive data

Access logging can expose personal data, secrets, and session information. Canonical fields do not include authorization headers, cookies, or request bodies. Recommended query logging must be assessed carefully.

## Response disclosure

The trace ID is intended to be opaque. Response diagnostics must not expose topology, hostnames, addresses, cloud identifiers, software versions, or internal routing policy.

## Sampling and denial of service

Deep diagnostics can consume CPU, memory, disk, and network capacity. Implementations should support limits, sampling, bounded capture sizes, and emergency disable controls.
