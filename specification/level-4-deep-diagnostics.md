# Level 4 — Deep Diagnostics

**Status:** Draft 0.4  
**Level:** 4

## 1. Purpose

Level 4 defines optional detailed diagnostics for failed or unexpected HTTP requests. It incorporates the goals of Failed Request Trace while using the same W3C trace ID and `OHD-Trace-ID` established by Levels 1 through 3.

## 2. Correlation

Every deep diagnostic record must contain:

- `trace_id` — the effective W3C trace ID;
- `traceparent` — the value observed or produced at the recording layer;
- `ohd_trace_id` — the matching OHD convenience value;
- a platform-specific event timestamp;
- the diagnostic layer or component role.

Platform-specific request or event identifiers may be included as extension fields.

## 3. Candidate diagnostic data

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

## 4. Security requirements

Deep diagnostics must be disabled or minimal by default. Implementations must use explicit allowlists for sensitive capture and always protect credentials and secrets.

At minimum, implementations must redact:

- `Authorization` and proxy authorization fields;
- cookies unless explicitly allowlisted;
- known API-key and token fields;
- passwords and credential-like query parameters;
- private keys and certificate material.

## 5. Activation

Implementations should support selective activation by status code, path, trace ID, time window, sampling rule, or administrative policy.

## 6. Resource controls

Implementations should provide bounded record sizes, rate limits, sampling controls, retention guidance, and an emergency disable mechanism.
