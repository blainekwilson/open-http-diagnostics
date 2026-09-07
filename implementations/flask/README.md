# Flask Implementation

Planned WSGI middleware for OHD Levels 1 through 3.

The Level 1 integration should observe incoming trace fields and emit the
canonical OHD access-log fields. It must not create, validate, or propagate
Trace Context.

Levels 2 and 3 should validate or establish W3C Trace Context, derive
`OHD-Trace-ID`, enrich structured logs, and return the matching response field.
