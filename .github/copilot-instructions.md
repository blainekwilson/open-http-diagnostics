# Open HTTP Diagnostics Contribution Instructions

Open HTTP Diagnostics (OHD) is a specification-first project for portable HTTP diagnostics. Preserve the existing structure, terminology, and concise technical style when adding or changing content.

## Source of truth

- Put normative requirements only in `specification/`.
- Put architecture, rationale, standards research, design principles, and FAQs in `docs/`.
- Put product-specific mappings, native configuration, limitations, and helper scripts in `platforms/`.
- Put middleware, modules, and other behavior-adding code in `implementations/` only when native configuration is insufficient.
- Put non-normative sample requests, responses, logs, and configurations in `examples/`.
- Put schemas, fixtures, and executable validators in `conformance-tests/`.
- Do not add a top-level directory unless an architecture decision demonstrates that the existing boundaries cannot hold the work.

## Specification workflow

1. Identify the normative behavior and update the relevant document in `specification/` first.
2. Update affected platform mappings, implementation documentation, examples, schemas, fixtures, and tests.
3. Keep platform and implementation documents linked to the specification; do not create competing definitions by copying normative text.
4. For changes to a canonical field name, order, unit, or meaning, document the operational problem, platform evidence, migration impact, and every affected artifact.
5. Describe partial support and draft-version support explicitly. Use the version-claim format in `specification/conformance.md`.

## OHD semantics

- Build on W3C Trace Context rather than inventing a competing propagation protocol.
- Treat `OHD-Trace-ID` as a projection of the effective W3C trace ID, never as an independent identifier.
- Preserve the relationship between `traceparent` and `OHD-Trace-ID` unless the specification explicitly changes it.
- Prefer portable meaning over identical product-specific syntax.
- Favor configuration and native platform capabilities before proposing custom code.
- Design each capability level to provide independent value while building on lower levels.

## Documentation style

- Use short, descriptive headings and direct technical prose.
- Start documents with their purpose, status, and scope when relevant.
- Use Markdown tables for stable field mappings, support matrices, and comparisons.
- Use fenced code blocks for configuration, requests, responses, logs, and commands; label the language where possible.
- Keep examples concrete and operationally useful to an engineer starting from a raw HTTP request, response, or access-log record.
- Link to the authoritative local document instead of restating requirements. Use repository-relative links and preserve the existing reading order.
- Distinguish normative language (`MUST`, `MUST NOT`, `SHOULD`, `MAY`) from explanatory prose. Do not make examples or platform notes normative accidentally.
- Keep draft status and version references consistent with the surrounding documents.

## Security and operational defaults

- Never add real credentials, session cookies, tokens, customer data, account identifiers, private hostnames, or private IP addresses to examples or fixtures.
- Dockerfiles MUST run their final containers as a non-root user. Root MAY be used during image construction for package installation and file ownership setup, but every Dockerfile MUST declare or inherit an explicit non-root runtime user.
- Avoid recommending unrestricted body capture, uncontrolled query capture, internal topology disclosure, or sensitive header logging.
- Make capture bounded, selective, and explicit when documenting deeper diagnostics.
- Explain privacy, retention, access-control, and redaction implications when a proposal adds diagnostic data.

## Validation

Run focused validation for the files changed, then the repository checks when applicable:

```bash
python3 conformance-tests/scripts/check-markdown-links.py
python3 conformance-tests/scripts/validate-level-1-tsv.py conformance-tests/fixtures/valid-level-1.tsv --enforce-trace-relationship
```

For platform scripts or configurations, validate syntax and run the smallest available integration test. For canonical field changes, check every platform mapping, example, schema, fixture, and validator that depends on the field order or meaning.

## Change discipline

- Prefer the smallest change that fully expresses the requirement.
- Preserve existing public names, field order, paths, and document organization unless the task requires a migration.
- Do not perform unrelated formatting or repository reorganizations.
- When a requirement is ambiguous, identify the owning normative document and resolve the ambiguity there before updating derived documentation.