# Azure Application Gateway Level 1 Mapping

Use Application Gateway diagnostic access logs as the boundary record when the
gateway owns the request. Normalize the exported record to the OHD canonical
fields and document trace-header availability and duration units.

Backend application or function logs represent a different hop. Keep their
relationship to the gateway record explicit and avoid treating both as one
access record.

## Header limitation and correlation

Application Gateway diagnostic access logs use fixed provider schemas and do
not generally allow arbitrary incoming headers to be appended. If the selected
category cannot emit `traceparent`, `tracestate`, or `OHD-Trace-ID`, do not
represent a provider request ID or trace field as one of those OHD fields.

Use a verified W3C trace ID, gateway request ID, backend request ID, or an
explicit application correlation ID to link the gateway record to the backend
record. The backend layer should log the OHD headers it receives. Timestamps,
client addresses, and paths may narrow a search but cannot establish identity
on their own.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
