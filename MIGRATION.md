# Migration from the Current Repository

This rebuilt package intentionally removes overlapping top-level categories.

## Move or merge

| Current location | New location |
|---|---|
| `profiles/level-1-common-logging.md` | Merge into `specification/level-1-common-access-logging.md` |
| `profiles/level-2-trace-context.md` | Merge into `specification/level-2-trace-context.md` |
| `profiles/level-3-response-diagnostics.md` | Merge into `specification/level-3-response-diagnostics.md` |
| `profiles/level-4-deep-diagnostics.md` | Merge into `specification/level-4-deep-diagnostics.md` |
| `specification/common-access-log.md` | Superseded by the Level 1 specification |
| `specification/common-logging-profile.md` | Superseded by the Level 1 specification |
| `guides/nginx/logging.md` | Replace with `platforms/nginx/level-1.md` |
| `implementations/iis/` configuration and scripts | Move to `platforms/iis/` |
| Existing FRT/OpenResty code | Move under `implementations/nginx-openresty/deep_diagnostics/` and related implementation folders |
| `docs/examples.md` | Move examples into `examples/`; retain rationale only if needed |

## Remove after migration

- `profiles/`
- `guides/`
- duplicate Level 1 specification files
- platform configuration stored under `implementations/`

## Preserve history

For a Git migration, use `git mv` where practical so file history remains visible. Migrate code in a separate commit from documentation rewrites to make review easier.
