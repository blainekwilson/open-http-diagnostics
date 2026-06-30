# Roadmap

## Phase 1: Specification and Level 1 configuration

- Define the Common HTTP Diagnostics Logging Profile.
- Document W3C Trace Context usage.
- Provide IIS W3C logging configuration scripts.
- Provide examples for IIS, NGINX, Apache, and application frameworks.

## Phase 2: Trace Context enforcement

- Provide reference implementations that create `traceparent` when missing.
- Preserve existing valid `traceparent` headers.
- Define consistent log field names for extracted trace fields.

## Phase 3: Response diagnostics

- Define `OHD-Trace-ID` response behavior.
- Define optional `OHD-Trace-Path` response behavior.
- Document security considerations and safe opaque labeling.

## Phase 4: Deep diagnostics

- Migrate Failed Request Trace concepts into the Level 4 profile.
- Implement NGINX/OpenResty deep diagnostics.
- Add examples showing correlation between access logs, response headers, and deep traces.

## Phase 5: Conformance

- Build conformance tests.
- Add sample expected outputs.
- Publish compatibility matrix by platform.
