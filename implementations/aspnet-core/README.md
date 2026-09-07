# ASP.NET Core Implementation

Planned middleware and second independent implementation for OHD Levels 1 through 3.

The Level 1 integration should observe the incoming trace fields and emit the
canonical OHD access-log fields through ASP.NET Core structured logging or a
configured logging provider. It must not create, validate, or propagate Trace
Context.

Levels 2 and 3 should integrate with `System.Diagnostics.Activity` where
practical, derive `OHD-Trace-ID` from the effective W3C trace ID, add it to
downstream requests and responses, and provide logging enrichment.
