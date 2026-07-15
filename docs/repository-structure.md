# Repository Structure

The following top-level structure is frozen for the initial project lifecycle:

```text
specification/       Normative OHD behavior
platforms/           Product-specific conformance guides
implementations/     Code that adds missing behavior
examples/            Non-normative samples
conformance-tests/   Validation fixtures and tests
docs/                Architecture and rationale
```

## Placement rules

- A new normative requirement goes in `specification/`.
- A configuration recipe for a product goes in `platforms/<product>/`.
- New executable middleware, modules, or libraries go in `implementations/<name>/`.
- Sample logs and configurations go in `examples/`.
- Tests for specification claims go in `conformance-tests/`.
- Design rationale and project history go in `docs/`.

`profiles/` and `guides/` are intentionally not used because they previously overlapped with specification and platform documentation.
