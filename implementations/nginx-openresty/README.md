# OHD for NGINX/OpenResty

This directory is the planned first reference implementation for OHD Levels 2 through 4.

## Planned modules

- `trace_context/` — validate, generate, and propagate W3C Trace Context.
- `response_diagnostics/` — return `OHD-Trace-ID` when enabled.
- `deep_diagnostics/` — migrated Failed Request Trace functionality.
- `logging/` — shared variables and structured diagnostic output that complement native NGINX access logs.

Level 1 should normally be implemented with native NGINX configuration documented under `platforms/nginx/level-1.md`.

The original FRT code should be migrated here without changing the top-level repository structure.
