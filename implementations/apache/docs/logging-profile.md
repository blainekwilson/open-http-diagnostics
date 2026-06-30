# Apache Logging Profile

Apache can log request and response headers using `LogFormat` directives.

- `%{traceparent}i` logs the incoming request header.
- `%{OHD-Trace-ID}o` logs the outgoing response header.
- `%{OHD-Trace-Path}o` logs the outgoing response header.
