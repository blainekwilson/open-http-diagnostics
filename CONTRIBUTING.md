# Contributing

Contributions are welcome.

Good early contributions include:

- Platform-specific logging configuration examples.
- Safe default field mappings.
- Implementations that create or preserve W3C `traceparent`.
- Examples showing how to correlate logs across layers.
- Security reviews of response header behavior.

## Design expectations

- Build on W3C Trace Context.
- Prefer configuration over code where a platform already supports the needed behavior.
- Keep infrastructure identifiers opaque and owner-defined.
- Avoid vendor lock-in.
- Separate normative specification from implementation guidance.
