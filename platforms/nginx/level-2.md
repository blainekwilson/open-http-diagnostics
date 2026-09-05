# NGINX Level 2

Native NGINX configuration can log and forward incoming fields, but it does not by itself provide the complete OHD Level 2 behavior for validating or establishing W3C Trace Context with cryptographically suitable trace and parent identifiers.

Use one of these implementations:

- [NGINX OpenResty](../../implementations/nginx-openresty/README.md)
- [Native NGINX module](../../implementations/nginx-module/README.md) — planned

Authoritative behavior: [Level 2 specification](../../specification/level-2-trace-context.md).
