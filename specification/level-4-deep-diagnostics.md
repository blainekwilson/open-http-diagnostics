# Level 4 — Deep Diagnostics

**Status:** Initial draft  
**Level:** 4

## Purpose

Level 4 defines optional, detailed diagnostics for investigating failed or unexpected HTTP requests. It incorporates the goals of the earlier Failed Request Trace project while using the same W3C trace ID as Levels 1 through 3.

## Candidate diagnostic data

A Level 4 implementation may capture:

- request and response timing stages;
- upstream selection and connection results;
- rewrite and routing decisions;
- selected request and response headers;
- selected cookies and query parameters;
- authentication and authorization outcomes;
- retry behavior;
- error and exception information;
- bounded request or response body samples.

## Security requirements

Deep diagnostics must be disabled or minimal by default. Implementations must use explicit allowlists for sensitive capture and must always protect credentials and secrets.

At minimum, implementations must redact:

- `Authorization` and proxy authorization fields;
- cookies unless explicitly allowlisted;
- known API key and token fields;
- passwords and credential-like query parameters;
- private keys and certificate material.

## Correlation

Every deep diagnostic record must contain the effective `trace_id`. Platform-specific request or event identifiers may be included as extension fields.

## Activation

Implementations should support selective activation by status code, path, trace ID, time window, sampling rule, or administrative policy.
