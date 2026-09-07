# Azure Functions Implementation

Planned function middleware and worker integration for OHD Levels 2 and 3.

The implementation should preserve W3C Trace Context across supported Azure
Functions language workers, derive `OHD-Trace-ID` from the effective trace ID,
enrich structured invocation logs, and add the response field at Level 3 for
HTTP-triggered functions.

The implementation must document differences between in-process and isolated
worker models and must not assume that an invocation log is the same thing as a
front-door access log.
