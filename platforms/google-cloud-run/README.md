# Google Cloud Run

Cloud Run is a managed serverless container platform rather than a function
runtime. It is included because it can own an HTTP request boundary and is the
execution substrate for some second-generation function deployments.

| OHD level | Status | Method |
|---|---|---|
| 1 | Managed request-log or application dependent | Cloud Run request logs, load balancer logs, or application logging |
| 2 | Planned | Application middleware or OpenTelemetry integration |
| 3 | Planned | Application response integration |
| 4 | Application-specific | Bounded container diagnostics with explicit redaction and retention |

Start with [Level 1](level-1.md). The [Cloud Run implementation](../../implementations/google-cloud-run/README.md)
is planned.
