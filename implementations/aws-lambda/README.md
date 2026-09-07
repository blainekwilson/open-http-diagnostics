# AWS Lambda Implementation

Planned Lambda wrapper and runtime integration for OHD Levels 2 and 3.

The implementation should accept or establish W3C Trace Context according to
the OHD level, derive `OHD-Trace-ID` from the effective W3C trace ID, preserve
that relationship in downstream calls, and add the response field at Level 3.
It should work with the selected HTTP front door rather than creating a second
unrelated access-log identity.

AWS X-Ray context and W3C Trace Context must be mapped explicitly. They must
not be treated as interchangeable identifiers without documented evidence.
