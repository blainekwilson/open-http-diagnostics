# Platform Support

Platform documents explain how an existing product maps to the OHD specification. They are non-normative and must link to the authoritative specification.

| Platform | Level 1 | Level 2 | Level 3 | Level 4 |
|---|---|---|---|---|
| IIS 8.5+ | Configuration and PowerShell helpers | Requires module or application middleware | Requires module or application middleware | Native FREB mapping and future integration |
| NGINX | Native `log_format` | OpenResty or native module | OpenResty or native module | OpenResty implementation planned |
| Apache HTTP Server | Native `LogFormat` | Module or application support | Module or application support | Planned |
| Envoy | Native access-log formatting | Native tracing/provider configuration requires detailed validation | Filter or application support | Planned |
| HAProxy | Native log formatting | Lua/service support requires detailed validation | Lua/service support | Planned |

A platform can support a level through native features, configuration, scripts, middleware, or a linked reference implementation.
