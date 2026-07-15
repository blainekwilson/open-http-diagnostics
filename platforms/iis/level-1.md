# IIS Level 1 Configuration

IIS W3C logging can record standard access fields and custom request headers. The `traceparent` and `tracestate` fields can be added as custom fields on IIS 8.5 and later.

Authoritative field definitions: [Level 1 specification](../../specification/level-1-common-access-logging.md).

## Important limitation

IIS W3C field names and ordering are controlled by IIS and do not map perfectly to the OHD canonical positional format. IIS therefore conforms through a documented field mapping rather than by renaming every native W3C column.

## Suggested mapping

| OHD field | IIS W3C source |
|---|---|
| `timestamp` | `date` + `time` |
| `client_ip` | `c-ip` |
| `method` | `cs-method` |
| `host` | `cs-host` |
| `path` | `cs-uri-stem` |
| `status` | `sc-status` |
| `duration` | `time-taken` converted from milliseconds when normalized downstream |
| `traceparent` | Custom field, request header `traceparent` |
| `query` | `cs-uri-query` |
| `protocol` | Custom/server-variable mapping where needed |
| `bytes_sent` | `sc-bytes` |
| `referer` | `cs(Referer)` |
| `user_agent` | `cs(User-Agent)` |
| `tracestate` | Custom field, request header `tracestate` |

Use the scripts in [`scripts/`](scripts/) to add the custom Trace Context fields.
