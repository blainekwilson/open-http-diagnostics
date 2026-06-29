# Migration from Failed Request Trace

Failed Request Trace began as a focused NGINX/OpenResty diagnostic tool inspired by IIS Failed Request Tracing.

Open HTTP Diagnostics expands that work into a broader framework:

- W3C Trace Context profile
- Common HTTP access logging
- Response Trace ID
- Optional Trace-Path diagnostic header
- Optional deep diagnostics / FRT module

## Migration plan

Move existing FRT code into:

```text
implementations/nginx-openresty/
```

Preserve FRT as the deep diagnostics capability within the broader project.

## Old repository note

The old FRT repository should be reduced to a README that points to the new location.

Suggested text:

```markdown
# Failed Request Trace has moved

This project has moved to:

https://github.com/blainekwilson/open-http-diagnostics

Failed Request Trace is now part of the Open HTTP Diagnostics project as the deep diagnostics module.
```
