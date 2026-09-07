# IIS Level 1 Configuration

IIS 8.5 and later can log custom request headers in W3C site logs. OHD uses this capability to record `traceparent`, `tracestate`, and `OHD-Trace-ID`.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

## Important native-format limitation

IIS controls W3C names and ordering. IIS therefore conforms through a documented semantic mapping rather than reproducing the OHD positional TSV layout.

## Mapping

| OHD field | IIS W3C source |
|---|---|
| `timestamp` | `date` and `time` |
| `client_ip` | `c-ip` |
| `method` | `cs-method` |
| `host` | `cs-host` |
| `path` | `cs-uri-stem` |
| `status` | `sc-status` |
| `duration` | `time-taken`; milliseconds, normalized downstream if decimal seconds are required |
| `traceparent` | Custom `RequestHeader` source `traceparent` |
| `tracestate` | Custom `RequestHeader` source `tracestate` |
| `ohd_trace_id` | Custom `RequestHeader` source `OHD-Trace-ID` |
| `query` | `cs-uri-query` |
| `bytes_sent` | `sc-bytes` |
| `referer` | `cs(Referer)` |
| `user_agent` | `cs(User-Agent)` |

## Automated configuration

Run from an elevated Windows PowerShell 5.1 session on the IIS server. The all-site script configures every IIS website that uses W3C logging:

```powershell
.\scripts\Configure-OhdIisLogging.ps1 -EnableRecommendedW3CFields
```

IIS keeps the logs in its native per-site W3C directories, normally:

```text
C:\inetpub\logs\LogFiles\W3SVC<site-id>\
```

This avoids mixing records from different sites and requires no custom log service. Validate every site and send the test request with:

```powershell
\.scripts\Verify-OhdIisLogging.ps1 -FailOnNonConformance
```

The existing `Enable-OhdIisLogging.ps1` and `Test-OhdIisLogging.ps1` scripts remain available for single-site administration.

Remove only OHD custom fields:

```powershell
.\scripts\Disable-OhdIisLogging.ps1 -SiteName "Default Web Site"
```

## Manual configuration

In IIS Manager, select the site, open **Logging**, select **W3C**, open **Select Fields**, and add three custom fields with source type **Request Header**:

| Log field name | Source name |
|---|---|
| `traceparent` | `traceparent` |
| `tracestate` | `tracestate` |
| `ohd_trace_id` | `OHD-Trace-ID` |

The user-facing log name `ohd_trace_id` follows OHD's canonical log naming while the source remains the HTTP field `OHD-Trace-ID`.

## Limitation

Level 1 records incoming values only. It cannot guarantee the fields are present. Level 2 requires middleware, a native module, or application integration.

## References

- Microsoft Enhanced Logging for IIS 8.5: <https://learn.microsoft.com/en-us/iis/get-started/whats-new-in-iis-85/enhanced-logging-for-iis85>
- IIS custom fields configuration: <https://learn.microsoft.com/en-us/iis/configuration/system.applicationhost/sites/site/logfile/customfields/add>
