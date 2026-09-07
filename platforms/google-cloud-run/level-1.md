# Google Cloud Run Level 1 Mapping

Cloud Run can produce managed request logs, but the deployment must identify
whether Cloud Run, a Google Cloud load balancer, an API gateway, or the
application owns the canonical OHD access record. Avoid counting the same
request once at every boundary without documenting the hop.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized Level 1 record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
