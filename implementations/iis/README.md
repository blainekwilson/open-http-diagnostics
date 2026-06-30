# IIS Implementation

The IIS implementation starts with Level 1 Common HTTP Diagnostics Logging.

IIS 8.5 and later supports custom W3C logging fields. This allows IIS to log the W3C `traceparent` request header without installing code.

## Included scripts

- `scripts/Enable-OhdIisLogging.ps1` adds custom IIS logging fields.
- `scripts/Test-OhdIisLogging.ps1` checks whether the fields are configured.
- `scripts/Disable-OhdIisLogging.ps1` removes the OHD custom fields.

## Default fields

| Field name | Source type | Source |
|---|---|---|
| `traceparent` | Request Header | `traceparent` |
| `tracestate` | Request Header | `tracestate` |
| `ohd-trace-id` | Response Header | `OHD-Trace-ID` |
| `ohd-trace-path` | Response Header | `OHD-Trace-Path` |

## Notes

Level 1 configuration only logs headers. Level 2 behavior, such as creating `traceparent` when missing, requires middleware, a reverse proxy, or another participating layer capable of modifying requests.
