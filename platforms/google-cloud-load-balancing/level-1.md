# Google Cloud Load Balancing Level 1 Mapping

Use the selected Cloud Logging load-balancer request-log category as the
boundary record when the load balancer owns the request. Normalize native
fields, document duration units, and preserve the relationship between any
provider trace metadata and W3C Trace Context.

Cloud Function or Cloud Run logs describe backend hops and must remain distinct
from the load-balancer access record.

## Header limitation and correlation

Cloud Load Balancing request logs use Google-defined structured fields. They do
not provide a general custom access-log format for appending arbitrary incoming
headers such as `traceparent`, `tracestate`, or `OHD-Trace-ID`. Provider trace
metadata must not be renamed to an OHD field without a verified mapping.

Use a documented Google request or trace ID, a backend request ID, or a W3C
trace ID present in both records to link the load-balancer record to Cloud
Functions, Cloud Run, or service logs. The backend layer must log the OHD
headers it receives when available. Time, path, and status are search aids, not
stable correlation identities.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
