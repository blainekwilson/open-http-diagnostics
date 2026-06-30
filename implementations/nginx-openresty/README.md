# NGINX/OpenResty Implementation

This implementation is intended to become the first full reference implementation for Levels 1-4.

Planned capabilities:

- Log W3C `traceparent`.
- Generate `traceparent` when missing.
- Emit `OHD-Trace-ID` response header.
- Optionally emit `OHD-Trace-Path` using safe opaque labels.
- Support Level 4 deep diagnostics based on the existing FRT work.
