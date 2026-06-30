# Examples

## Request with existing trace context

```http
GET /checkout HTTP/1.1
Host: example.com
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

## Response with trace ID

```http
HTTP/1.1 200 OK
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

## Optional response path

```http
HTTP/1.1 200 OK
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
OHD-Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```
