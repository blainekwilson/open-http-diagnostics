# Apache Implementation

This directory will contain Apache HTTP Server configuration examples and optional modules/helpers for Open HTTP Diagnostics.

Planned Level 1 example:

```apache
LogFormat "%h %l %u %t \"%r\" %>s %b %{traceparent}i %{OHD-Trace-ID}o %{OHD-Trace-Path}o" ohd
CustomLog logs/ohd_access.log ohd
```
