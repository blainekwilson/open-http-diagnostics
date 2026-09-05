# Apache HTTP Server Level 1 Configuration

Apache HTTP Server can log OHD Level 1 fields using `mod_log_config`.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

## Mapping

| OHD field | Apache format expression |
|---|---|
| `timestamp` | `%{iso}t` |
| `client_ip` | `%a` |
| `method` | `%m` |
| `host` | `%v` or `%{Host}i` according to deployment needs |
| `path` | `%U` |
| `status` | `%>s` |
| `duration` | `%D` in microseconds; normalize downstream to decimal seconds |
| `traceparent` | `%{traceparent}i` |
| `tracestate` | `%{tracestate}i` |
| `ohd_trace_id` | `%{OHD-Trace-ID}i` |
| `query` | `%q` includes the leading `?`; normalize downstream if required |
| `protocol` | `%H` |
| `bytes_sent` | `%B` |
| `referer` | `%{Referer}i` |
| `user_agent` | `%{User-Agent}i` |

## Example format

```apache
LogFormat "%{iso}t\t%a\t%m\t%v\t%U\t%>s\t%D\t%{traceparent}i\t%{tracestate}i\t%{OHD-Trace-ID}i\t%q\t%H\t%B\t%{Referer}i\t%{User-Agent}i" ohd_tsv
CustomLog logs/ohd-access.log ohd_tsv
```

## Native differences

- `%D` is microseconds rather than decimal seconds.
- `%q` includes a leading `?` when a query exists.
- Missing request fields are commonly represented as `-`.

These differences must be documented or normalized by the log pipeline.

## Reference

- Apache `mod_log_config`: <https://httpd.apache.org/docs/current/mod/mod_log_config.html>
