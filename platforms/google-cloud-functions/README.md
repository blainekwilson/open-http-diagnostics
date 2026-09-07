# Google Cloud Functions

Google Cloud Functions is a managed function runtime. HTTP traffic may pass
through a Google Cloud load balancer, API Gateway, Cloud Endpoints, or the
Functions endpoint. Second-generation functions run on Cloud Run, but their
function and platform logging contracts still need to be identified.

| OHD level | Status | Method |
|---|---|---|
| 1 | Cloud Logging/front-door dependent | Google Cloud request logs, function logs, or the selected ingress |
| 2 | Planned | Function Framework wrapper or OpenTelemetry integration |
| 3 | Planned | Function response integration |
| 4 | Application-specific | Bounded function diagnostics with explicit redaction and retention |

Start with [Level 1](level-1.md). The [Google Cloud Functions implementation](../../implementations/google-cloud-functions/README.md)
is planned.
