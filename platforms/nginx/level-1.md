# NGINX Level 1 Configuration

NGINX can produce the OHD Level 1 Common Access Log using native configuration. No custom module or Lua code is required.

Authoritative field definitions: [Level 1 specification](../../specification/level-1-common-access-logging.md).

## Field mapping

| OHD field | NGINX variable |
|---|---|
| `timestamp` | `$time_iso8601` |
| `client_ip` | `$remote_addr` |
| `method` | `$request_method` |
| `host` | `$host` |
| `path` | `$uri` |
| `status` | `$status` |
| `duration` | `$request_time` |
| `traceparent` | `$http_traceparent` |
| `query` | `$args` |
| `protocol` | `$server_protocol` |
| `bytes_sent` | `$body_bytes_sent` |
| `referer` | `$http_referer` |
| `user_agent` | `$http_user_agent` |
| `tracestate` | `$http_tracestate` |

## Recommended tab-separated format

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
    '$args\t'
    '$server_protocol\t'
    '$body_bytes_sent\t'
    '$http_referer\t'
    '$http_user_agent\t'
    '$http_tracestate';

access_log /var/log/nginx/ohd-access.log ohd_tsv;
```

NGINX renders absent variables as `-` in log output, which matches the OHD recommendation for missing values.

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
      '"query":"$args",'
      '"protocol":"$server_protocol",'
      '"bytes_sent":$body_bytes_sent,'
      '"referer":"$http_referer",'
      '"user_agent":"$http_user_agent",'
      '"tracestate":"$http_tracestate"'
    '}';
```

## Validation

After reloading NGINX, send a request containing a test `traceparent` and verify that the value appears in the eighth TSV column or the `traceparent` JSON property.

Level 1 does not generate a missing `traceparent`. That behavior belongs to Level 2.
