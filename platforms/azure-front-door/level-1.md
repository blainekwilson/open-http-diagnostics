# Azure Front Door Level 1 Mapping

Use the selected Azure Front Door diagnostic access-log category as the
boundary record when Front Door owns the request. Export it, map native names
to the OHD canonical fields, and document which trace fields are observed at
the edge versus added by the backend.

Do not combine Front Door records with Functions or App Service records as one
request record. They represent separate hops unless a correlation mapping is
explicitly documented.

## Header limitation and correlation

Front Door diagnostic access-log categories use provider-defined schemas. They
do not provide a general facility for adding arbitrary incoming headers to the
native record. If the selected category cannot emit `traceparent`, `tracestate`,
or `OHD-Trace-ID`, record that limitation instead of renaming a provider field.

Link the edge record to the backend record with a verified Front Door request
ID, backend request ID, or W3C trace ID that is present at both layers. The
backend must log incoming `traceparent`, `tracestate`, and `OHD-Trace-ID` when
available. Request time, host, path, and status are useful search attributes
but are not sufficient as a stable correlation identity.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
