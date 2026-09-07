# Azure API Management Level 1 Mapping

Use API Management gateway diagnostics as the boundary record when the gateway
owns the request. The mapping must identify the selected diagnostic sink,
normalize native names and duration units, and document the availability of
incoming trace headers.

Policy tracing and backend logs are separate diagnostic records. Do not enable
unbounded body or header capture; apply allowlists, redaction, and retention
controls appropriate to the API.

## Header limitation and correlation

Gateway diagnostic resource logs use provider-defined schemas. API Management
policies can add application or gateway diagnostics in selected pipelines, but
that does not change the schema of the native access record. Do not claim that
`traceparent`, `tracestate`, or `OHD-Trace-ID` is present in the native record
unless the selected diagnostic path demonstrably emits it.

Link the gateway record to backend logs with the API Management request ID,
backend request ID, or a verified W3C trace ID present in both records. The
backend should log the incoming OHD headers. Provider request IDs are useful
correlation keys but are not substitutes for the OHD fields.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
