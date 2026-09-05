# Design Principles

1. **Build on standards.** Use W3C Trace Context rather than creating a competing propagation protocol.
2. **One identity.** `OHD-Trace-ID` is a projection of the W3C trace ID, never an independent identifier.
3. **Configuration before code.** Document native platform capabilities before creating modules or middleware.
4. **Incremental adoption.** Each OHD level provides value independently while building on lower levels.
5. **Specification once.** Normative requirements appear only in `specification/`.
6. **Secure defaults.** Avoid credentials, cookies, bodies, internal topology, and uncontrolled query capture.
7. **Operational usefulness.** Optimize for support engineers who begin with a raw HTTP request, response, or access-log record.
8. **Stable repository boundaries.** Add content within the frozen structure instead of repeatedly reorganizing the project.
9. **Portable semantics.** Standardize meaning before attempting identical native syntax on every product.
10. **Testable requirements.** Every normative behavior should eventually have a fixture or executable conformance test.
