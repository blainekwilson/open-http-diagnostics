# Google Cloud API Gateway Level 1 Mapping

Use Cloud Logging API Gateway request logs as the boundary record when the
Gateway owns the request. Normalize the exported record to the OHD canonical
fields and document the source and meaning of provider trace metadata before
mapping it to W3C Trace Context fields.

Backend function and service logs represent separate hops. Keep their
correlation explicit and avoid duplicate unbounded request or body capture.

## Header limitation and correlation

Cloud API Gateway request logs use provider-defined structured fields and do
not generally allow arbitrary incoming headers to be appended to the native
record. If the selected log sink cannot emit `traceparent`, `tracestate`, or
`OHD-Trace-ID`, preserve that limitation in the mapping rather than filling the
fields with provider-specific trace values.

Link the gateway record to backend logs with a verified gateway request ID,
backend request ID, or W3C trace ID present in both records. The backend must
log incoming OHD fields when available. Provider IDs are correlation keys only;
they do not replace the OHD trace relationship.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
