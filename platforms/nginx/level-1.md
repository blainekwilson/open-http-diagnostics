# NGINX Level 1 Configuration

NGINX can produce an OHD Level 1 access log using native `log_format` configuration. No custom module or Lua code is required.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

## Mapping

| OHD field | NGINX variable |
|---|---|
| `timestamp` | `$time_iso8601` |
| `client_ip` | `$remote_addr` |
| `method` | `$request_method` |
| `host` | `$host` |
| `path` | `$uri` |
| `status` | `$status` |
| `duration` | `$request_time` in decimal seconds |
| `traceparent` | `$http_traceparent` |
| `tracestate` | `$http_tracestate` |
| `ohd_trace_id` | `$http_ohd_trace_id` |
| `query` | `$args` |
| `protocol` | `$server_protocol` |
| `bytes_sent` | `$body_bytes_sent` |
| `referer` | `$http_referer` |
| `user_agent` | `$http_user_agent` |

NGINX maps request-field names to `$http_` variables by lowercasing names and replacing hyphens with underscores. Therefore `OHD-Trace-ID` is available as `$http_ohd_trace_id`.

## Tab-separated format

```nginx
log_format ohd_tsv
    '$time_iso8601\t'
    '$remote_addr\t'
    '$request_method\t'
    '$host\t'
    '$uri\t'
    '$status\t'
    '$request_time\t'
    '$http_traceparent\t'
    '$http_tracestate\t'
    '$http_ohd_trace_id\t'
    '$args\t'
    '$server_protocol\t'
    '$body_bytes_sent\t'
    '$http_referer\t'
    '$http_user_agent';

access_log /var/log/nginx/ohd-access.log ohd_tsv;
```

## JSON alternative

```nginx
log_format ohd_json escape=json
    '{'
      '"timestamp":"$time_iso8601",'
      '"client_ip":"$remote_addr",'
      '"method":"$request_method",'
      '"host":"$host",'
      '"path":"$uri",'
      '"status":$status,'
      '"duration":$request_time,'
      '"traceparent":"$http_traceparent",'
      '"tracestate":"$http_tracestate",'
      '"ohd_trace_id":"$http_ohd_trace_id",'
      '"query":"$args",'
      '"protocol":"$server_protocol",'
      '"bytes_sent":$body_bytes_sent,'
      '"referer":"$http_referer",'
      '"user_agent":"$http_user_agent"'
    '}';
```

## Validation

```bash
nginx -t
sudo nginx -s reload
./scripts/test-level-1.sh https://example.com
```

Level 1 records incoming values only. Level 2 requires OpenResty, njs, a native module, or another tracing-capable layer.

## Reference

- NGINX log module: <https://nginx.org/en/docs/http/ngx_http_log_module.html>
