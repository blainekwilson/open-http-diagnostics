# Open HTTP Diagnostics

Open HTTP Diagnostics (OHD) is a specification-first project for consistent HTTP diagnostics across web infrastructure, reverse proxies, load balancers, web servers, and application frameworks.

OHD builds on W3C Trace Context rather than replacing it. The project defines a staged adoption model for common access logging, trace-context enforcement, optional client-visible diagnostics, and deep failed-request diagnostics.

## Start here

Read the project in this order:

1. [Project architecture](docs/architecture.md)
2. [Level 1: Common Access Logging](specification/level-1-common-access-logging.md)
3. [Level 2: Trace Context](specification/level-2-trace-context.md)
4. [Level 3: Response Diagnostics](specification/level-3-response-diagnostics.md)
5. [Level 4: Deep Diagnostics](specification/level-4-deep-diagnostics.md)
6. Select a platform under [`platforms/`](platforms/README.md)
7. Use an implementation under [`implementations/`](implementations/README.md) only when native configuration is insufficient

## Capability levels

| Level | Capability | Typical adoption method |
|---|---|---|
| 1 | Common access logging | Native configuration |
| 2 | Ensure and propagate W3C Trace Context | Native feature, middleware, or module |
| 3 | Optional response diagnostics | Middleware or module |
| 4 | Deep failed-request diagnostics | Platform-specific implementation |

## Stable repository boundaries

- `specification/` defines **what OHD requires** and is the only normative source.
- `platforms/` explains **how existing products conform** using configuration or available features.
- `implementations/` contains **code that adds missing behavior**.
- `examples/` contains non-normative samples.
- `conformance-tests/` contains validation plans and future executable tests.
- `docs/` contains project architecture, rationale, and design decisions.

These boundaries are intentionally fixed. New platforms and implementations should be added within them rather than creating new top-level categories.

## Current focus

The initial focus is Level 1 support for IIS and NGINX, followed by a reusable OpenResty implementation for Levels 2 through 4.

## Status

Early draft and reference implementation work. The behavior is expected to evolve, but the repository structure is considered stable.

## License

MIT. See [LICENSE](LICENSE).
