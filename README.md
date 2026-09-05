# Open HTTP Diagnostics

Open HTTP Diagnostics (OHD) is a specification-first project for consistent HTTP diagnostics across web infrastructure, reverse proxies, load balancers, web servers, and application frameworks.

OHD builds on W3C Trace Context rather than replacing it. It defines a staged adoption model for common access logging, trace-context establishment, client-visible correlation, and optional deep failed-request diagnostics.

## Start here

Read the project in this order:

1. [Architecture](docs/architecture.md)
2. [Header fields](specification/header-fields.md)
3. [Level 1: Common Access Logging](specification/level-1-common-access-logging.md)
4. [Level 2: Trace Context Establishment](specification/level-2-trace-context.md)
5. [Level 3: Response Diagnostics](specification/level-3-response-diagnostics.md)
6. [Level 4: Deep Diagnostics](specification/level-4-deep-diagnostics.md)
7. Select a product under [`platforms/`](platforms/README.md)
8. Use code under [`implementations/`](implementations/README.md) only when native configuration is insufficient

## The three trace fields

OHD uses one W3C trace identity represented in three HTTP fields:

| Field | Role |
|---|---|
| `traceparent` | Authoritative W3C Trace Context field containing the trace ID, parent ID, and flags |
| `tracestate` | Optional W3C vendor state associated with the trace |
| `OHD-Trace-ID` | OHD convenience field containing only the 32-character trace ID from `traceparent` |

`OHD-Trace-ID` is not a second identifier. When present, it must equal the trace ID in the effective `traceparent`.

## Capability levels

| Level | Capability | Typical adoption method |
|---|---|---|
| 1 | Log `traceparent`, `tracestate`, and `OHD-Trace-ID` with common access fields | Native configuration |
| 2 | Validate or create Trace Context and propagate `OHD-Trace-ID` downstream | Native feature, middleware, or module |
| 3 | Return `OHD-Trace-ID` to the client | Middleware or module |
| 4 | Capture selective deep diagnostics correlated by the same trace ID | Platform-specific implementation |

## Stable repository boundaries

- `specification/` defines **what OHD requires** and is the only normative source.
- `platforms/` explains **how existing products conform** using configuration or available features.
- `implementations/` contains **code that adds missing behavior**.
- `examples/` contains non-normative samples.
- `conformance-tests/` contains fixtures and executable validation helpers.
- `docs/` contains project architecture, rationale, and design decisions.

These top-level boundaries are frozen. New work should be added inside them rather than creating new top-level categories.

## Current focus

The first milestone is a complete Level 1 profile for IIS, NGINX, and Apache, followed by an OpenResty reference implementation for Levels 2 and 3 and migration of Failed Request Trace into Level 4.

## Status

Draft specification and reference implementation work. The behavior may evolve, but the repository structure is considered stable.

## License

MIT. See [LICENSE](LICENSE).
