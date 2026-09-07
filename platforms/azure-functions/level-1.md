# Azure Functions Level 1 Mapping

Azure Functions Level 1 support depends on the trigger and ingress path. The
mapping must identify whether the canonical access record comes from the
Functions host, App Service logs, Application Insights, Azure Front Door,
Application Gateway, or another proxy.

Function invocation logs are not automatically a complete HTTP access record.
When a function emits application records, document which canonical fields come
from the front door and which come from the function runtime.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Validate an exported, normalized Level 1 record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
