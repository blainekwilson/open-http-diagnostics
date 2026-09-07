# ASP.NET Core Kestrel

ASP.NET Core Kestrel is the HTTP server used by the ASP.NET Core runtime,
including the ASP.NET Core Runtime container image. This platform mapping
covers the ASP.NET Core hosting stack and application integration around
Kestrel; Kestrel is not treated as a separate diagnostic protocol or as a
standalone product.

| OHD level | Status | Method |
|---|---|---|
| 1 | Planned | ASP.NET Core logging or middleware producing the OHD Level 1 field set |
| 2 | Planned | ASP.NET Core middleware using `System.Diagnostics.Activity` and W3C Trace Context |
| 3 | Planned | ASP.NET Core middleware |
| 4 | Application-specific | Selective diagnostic capture by the application or hosting environment |

The planned [ASP.NET Core implementation](../../implementations/aspnet-core/README.md)
is the reference path for Levels 1 through 3. Normative behavior is defined by the
[OHD specifications](../../specification/README.md), not by Kestrel-specific
configuration.