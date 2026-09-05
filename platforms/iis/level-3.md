# IIS Level 3

IIS logging configuration alone cannot guarantee an `OHD-Trace-ID` response field matching effective W3C Trace Context.

Use application middleware, an IIS module, or a conforming upstream component. IIS 8.5+ can optionally log a response field as a custom field, but logging it is separate from generating it correctly.

Authoritative behavior: [Level 3 specification](../../specification/level-3-response-diagnostics.md).
