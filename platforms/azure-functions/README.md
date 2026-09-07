# Azure Functions

Azure Functions is a managed function runtime. HTTP traffic may be recorded by
the Functions host, App Service, Azure Front Door, Application Gateway, or
another ingress. This mapping covers the function runtime and requires the
actual HTTP boundary to be identified.

| OHD level | Status | Method |
|---|---|---|
| 1 | Host/front-door dependent | Azure platform logs, Application Insights, or the selected ingress |
| 2 | Planned | Function middleware, worker integration, or OpenTelemetry integration |
| 3 | Planned | Function response integration |
| 4 | Application-specific | Bounded function diagnostics with explicit redaction and retention |

Start with [Level 1](level-1.md). The [Azure Functions implementation](../../implementations/azure-functions/README.md)
is planned and does not replace access logging owned by a front door.
