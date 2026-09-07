# AWS Application Load Balancer Level 1 Mapping

Use ALB access logs as the boundary record when the load balancer owns the
request. Map the native fields to the OHD canonical fields and document any
trace-header values that are supplied by the target or another logging layer.

ALB access logs and Lambda invocation logs describe different hops. Keep both
only when their relationship and retention purpose are explicit.

## Header limitation and correlation

ALB access logs use an AWS-defined schema. They cannot be configured to append
arbitrary fields such as `traceparent`, `tracestate`, or `OHD-Trace-ID`. The
native `trace_id` field records `X-Amzn-Trace-Id`; it is not automatically the
W3C trace ID and must not be renamed to `OHD-Trace-ID`.

Correlate the ALB record with a target record in this order:

1. Use a documented W3C trace ID if the target receives and logs the same
	`traceparent` value and the ALB record exposes a verified equivalent.
2. Otherwise use the ALB request fields together with the target's received
	`X-Amzn-Trace-Id`, request ID, or an application correlation ID, when the
	deployment proves that the value is preserved across the hop.
3. Treat timestamp, client address, and request path alone as an approximate
	search aid, not a reliable identity.

The target or application layer must log incoming `traceparent`, `tracestate`,
and `OHD-Trace-ID` when those fields are available. A target record can satisfy
OHD semantics without changing the fixed ALB record, provided the two records'
hop relationship and correlation key are documented.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
