# Specification

This directory contains the Open HTTP Diagnostics specification documents.

The specification is intentionally modular:

- `trace-context-profile.md` defines how participating components handle W3C Trace Context.
- `common-access-log.md` defines common log fields.
- `response-trace-id.md` defines how the active trace ID can be returned to clients.
- `trace-path-header.md` defines optional response-visible diagnostic path hints.
- `deep-diagnostics.md` defines optional Failed Request Trace-style diagnostics.
- `security-considerations.md` defines safety requirements.

The core specification is the Trace Context Profile plus Common Access Log. Response headers and deep diagnostics are optional extensions.
