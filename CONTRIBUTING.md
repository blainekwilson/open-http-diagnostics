# Contributing

Contributions are welcome, especially around standards alignment, implementation safety, and platform support.

## Contribution areas

- Specification feedback
- Security review
- NGINX/OpenResty implementation
- Apache implementation
- IIS implementation
- Application framework middleware
- Sample logs and responses
- Conformance tests
- Documentation of existing vendor headers

## Design principles

- Build on existing standards, especially W3C Trace Context.
- Prefer safe defaults.
- Do not expose infrastructure details in response headers.
- Keep optional diagnostics clearly separated from core logging behavior.
- Use consistent field names across platforms.
- Make features independently configurable.

## Pull request expectations

- Include documentation for new behavior.
- Include examples when adding or changing header behavior.
- Include security considerations for any response-visible data.
- Avoid vendor-specific assumptions in the core specification.
