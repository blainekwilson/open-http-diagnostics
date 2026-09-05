# ASP.NET Core Implementation

Planned middleware and second independent implementation for OHD Levels 2 and 3.

The implementation should integrate with `System.Diagnostics.Activity` where practical, derive `OHD-Trace-ID` from the effective W3C trace ID, add it to downstream requests and responses, and provide logging enrichment.
