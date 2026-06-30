# NGINX/OpenResty Logging Profile

Example log fields:

```nginx
log_format ohd_json escape=json '{'
  '"traceparent":"$http_traceparent",'
  '"method":"$request_method",'
  '"host":"$host",'
  '"path":"$uri",'
  '"status":$status,'
  '"duration_ms":$request_time,'
  '"ohd_trace_id":"$sent_http_ohd_trace_id",'
  '"ohd_trace_path":"$sent_http_ohd_trace_path"'
'}';
```
