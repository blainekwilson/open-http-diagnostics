# Roadmap

## Phase 1 — Freeze Level 1

- Finalize canonical Level 1 field names and semantics.
- Validate field availability across IIS, NGINX, Apache HTTP Server, Envoy, and HAProxy.
- Publish IIS and NGINX configuration guides.
- Add configuration validation scripts.

## Phase 2 — Define Trace Context enforcement

- Specify validation of incoming `traceparent`.
- Specify generation when missing or invalid.
- Define common log fields for trace ID, parent ID, flags, and source.
- Implement the profile first in OpenResty.

## Phase 3 — Response diagnostics

- Define an optional response trace identifier.
- Define safe overwrite and precedence rules.
- Evaluate an optional, higher-level path diagnostic without requiring infrastructure disclosure.

## Phase 4 — Deep diagnostics

- Migrate and adapt the Failed Request Trace prototype.
- Correlate deep diagnostic records using W3C Trace Context.
- Add security controls for sensitive headers, query parameters, cookies, and bodies.

## Phase 5 — Conformance and broader platforms

- Add conformance fixtures and parsers.
- Add Apache, Envoy, HAProxy, ASP.NET Core, Flask, and native NGINX support.
- Evaluate an Internet-Draft after multiple independent implementations exist.
