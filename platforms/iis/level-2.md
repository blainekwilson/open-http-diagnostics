# IIS Level 2

IIS native W3C logging can observe Trace Context but does not, through logging configuration alone, establish missing W3C Trace Context or derive `OHD-Trace-ID`.

Level 2 requires one of:

- ASP.NET Core middleware for applications hosted behind IIS;
- an IIS native or managed module;
- an upstream proxy that performs OHD Level 2 processing before IIS.

Authoritative behavior: [Level 2 specification](../../specification/level-2-trace-context.md).
