# AWS API Gateway Level 1 Mapping

Use API Gateway stage access logs as the boundary record when API Gateway owns
the request. Export the configured JSON or text fields, normalize them to the
OHD canonical names, and preserve the incoming W3C trace headers when the
configured log format exposes them.

The Lambda or backend invocation log is a separate record and must not be
presented as the API Gateway access record without documenting the relationship.

## Header limitation and correlation

API Gateway access-log formats are limited to the provider's supported context
variables and format rules. They should not be treated as a general mechanism
for appending arbitrary incoming headers. If the selected access-log format
cannot expose `traceparent`, `tracestate`, or `OHD-Trace-ID`, do not add empty
or renamed fields and claim Level 1 conformance.

Use the API Gateway request ID or extended request ID to link the gateway
record to the Lambda or backend record when that identifier is propagated or
captured by the integration. If a verified W3C trace ID is present in both
records, prefer it as the correlation key. Provider request IDs are correlation
keys only; they are not replacements for `traceparent` or `OHD-Trace-ID`.

The backend layer should log the incoming OHD fields and its own request ID.
The gateway record can remain a documented partial mapping when its fixed
schema lacks those fields.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
