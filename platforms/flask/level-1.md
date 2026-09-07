# Flask Level 1 Integration

Flask does not provide a native access-log format with the OHD canonical field
set. A WSGI middleware or application logging integration must observe the
request and response and emit the fields defined by [Level 1](../../specification/level-1-common-access-logging.md).

The Level 1 integration must only record incoming `traceparent`, `tracestate`,
and `OHD-Trace-ID` values. It must not create, validate, or propagate Trace
Context.

The deployment server may also emit access logs. Operators should choose one
canonical OHD record per request and avoid treating both the Flask middleware
and the deployment server as independent OHD records.
