# Level 1: Common HTTP Diagnostics Logging

Level 1 is the recommended starting point for adoption.

## Intent

Configure existing infrastructure and application logs to include common HTTP diagnostic fields. Where W3C Trace Context is present, log the `traceparent` request header.

## Required behavior

- Log the request method, host, path, status, and timestamp.
- Log `traceparent` if present.
- Do not log sensitive headers by default.
- Avoid raw query string logging unless explicitly allowed.

## Optional behavior

- Extract `trace_id` from `traceparent`.
- Log response diagnostic headers such as `OHD-Trace-ID`.
- Log an opaque `node_id` or `layer` label.
