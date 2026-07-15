# Design Principles

1. **Build on standards.** Use W3C Trace Context rather than a competing request identifier.
2. **Configuration before code.** Document native platform capabilities before creating libraries or modules.
3. **Smallest useful common profile.** Require only fields major platforms can produce.
4. **One source of truth.** Field names and behavior are defined only in `specification/`.
5. **Incremental adoption.** Each level provides value independently.
6. **Secure defaults.** Do not collect or disclose sensitive infrastructure or application data by default.
7. **Stable structure.** Add content inside established categories rather than reorganizing the repository.
8. **Operational usefulness.** Optimize for troubleshooting real HTTP requests across layers.
