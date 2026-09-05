# Roadmap

## Milestone 0.4 — Consistent trace fields

- Define `OHD-Trace-ID` once in `specification/header-fields.md`.
- Align Levels 1–4 around `traceparent`, `tracestate`, and `OHD-Trace-ID`.
- Update IIS, NGINX, and Apache Level 1 mappings.
- Add valid, missing, malformed, and conflicting-value fixtures.
- Add executable Level 1 validation.

## Milestone 0.5 — Complete Level 1

- Validate field availability and units across IIS, NGINX, Apache, Envoy, and HAProxy.
- Publish tested configuration helpers.
- Document native-format deviations.
- Add CI for Markdown links, PowerShell syntax, configuration linting where tools are available, and TSV fixtures.

## Milestone 0.6 — OpenResty Levels 2 and 3

- Validate or establish W3C Trace Context.
- Derive and propagate `OHD-Trace-ID`.
- Return `OHD-Trace-ID` in responses.
- Add automated request/response tests.

## Milestone 0.7 — Deep diagnostics

- Migrate Failed Request Trace into the OpenResty implementation.
- Correlate records using the effective trace ID.
- Add allowlists, redaction, bounded capture, and activation controls.

## Milestone 0.8 — Independent implementation

- Add ASP.NET Core or Flask support for Levels 2 and 3.
- Resolve specification ambiguities revealed by the second implementation.

## Milestone 1.0 — Draft profile release

- Freeze Level 1–3 behavior.
- Publish conformance results for at least two independent implementations.
- Evaluate provisional HTTP field registration and an Internet-Draft.
