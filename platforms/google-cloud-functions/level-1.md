# Google Cloud Functions Level 1 Mapping

Google Cloud Functions Level 1 support depends on the generation, trigger,
and ingress path. The mapping must identify whether the canonical access record
comes from Google Cloud request logs, a load balancer, API Gateway, or the
function's structured logs.

Cloud Trace fields and Google-specific trace metadata must not be substituted
for W3C `traceparent`, `tracestate`, or `OHD-Trace-ID` without a documented
mapping to the effective W3C trace ID.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized Level 1 record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
