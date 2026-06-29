# Examples

## Request without traceparent

```http
GET /login HTTP/1.1
Host: example.com
```

Participating component generates trace context before forwarding:

```http
GET /login HTTP/1.1
Host: example.com
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

Response returns the trace ID:

```http
HTTP/1.1 200 OK
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

## Common access log

```json
{
  "timestamp": "2026-06-29T17:00:00Z",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "span_id": "00f067aa0ba902b7",
  "trace_context_source": "generated",
  "layer": "proxy",
  "component": "nginx-openresty",
  "node_id": "proxy-01",
  "method": "GET",
  "host": "example.com",
  "path": "/login",
  "status": 200,
  "duration_ms": 23
}
```

## Optional Trace-Path

When enabled:

```http
HTTP/1.1 200 OK
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```

This tells the infrastructure owner the request passed through logical layers represented by opaque labels.
