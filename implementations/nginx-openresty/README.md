# NGINX/OpenResty Implementation

This directory will contain the first reference implementation for Open HTTP Diagnostics.

The initial implementation will migrate the existing Failed Request Trace NGINX/OpenResty prototype and extend it to support the broader project scope.

## Planned capabilities

- Validate incoming W3C `traceparent`.
- Generate `traceparent` when missing or invalid.
- Log common access fields in JSON.
- Add `Trace-ID` response header when enabled.
- Optionally add `Trace-Path` response header with opaque labels.
- Optionally capture deep diagnostics using the FRT module.

## Proposed config

```yaml
open_http_diagnostics:
  trace_context:
    enabled: true
    create_if_missing: true
    replace_invalid: true

  access_logging:
    enabled: true
    format: json

  response_trace_id:
    enabled: true
    header_name: Trace-ID

  trace_path:
    enabled: false
    layer: proxy
    node_id: proxy-01

  deep_diagnostics:
    enabled: false
```

## Migration target

Existing FRT files should be moved here:

```text
implementations/nginx-openresty/lua/
implementations/nginx-openresty/nginx.conf
implementations/nginx-openresty/Dockerfile
```
