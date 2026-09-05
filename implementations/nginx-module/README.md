# Native NGINX Module

Planned C implementation for environments that cannot use OpenResty.

Target capabilities:

- Level 2 Trace Context establishment and propagation;
- Level 3 `OHD-Trace-ID` response field;
- variables for native access logging;
- a bounded subset of Level 4 diagnostics.

The module should follow the NGINX development guide and avoid reimplementing normative behavior outside `specification/`.
