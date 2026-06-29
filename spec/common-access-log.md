# Common Access Log

## Purpose

The Common Access Log defines consistent field names for HTTP access logging across web servers, reverse proxies, WAFs, load balancers, application frameworks, and cloud infrastructure.

The goal is not to replace every native log format. The goal is to make key diagnostic fields consistent enough that teams can search across layers using the same field names.

## Minimum recommended fields

```json
{
  "timestamp": "2026-06-29T17:00:00Z",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "span_id": "00f067aa0ba902b7",
  "trace_context_source": "generated",
  "layer": "proxy",
  "component": "nginx-openresty",
  "node_id": "proxy-01",
  "client_ip": "203.0.113.10",
  "method": "GET",
  "scheme": "https",
  "host": "example.com",
  "path": "/login",
  "query_present": true,
  "status": 200,
  "duration_ms": 23,
  "bytes_sent": 1024,
  "user_agent_present": true
}
```

## Field guidance

### `trace_id`

The W3C trace ID. This should be the primary correlation key across logs.

### `layer`

The logical layer that produced the log entry.

Suggested values:

- `edge`
- `cdn`
- `waf`
- `load_balancer`
- `proxy`
- `ingress`
- `application`
- `service`

### `component`

The implementation or platform that produced the log entry.

Examples:

- `nginx-openresty`
- `apache`
- `iis`
- `aspnet-core`
- `flask`
- `imperva-cloud-waf`
- `aws-alb`

### `node_id`

An owner-defined identifier for the logical component instance. It should be safe for logs. If reused in response headers, it must be opaque and must not disclose sensitive infrastructure details.

### `query_present`

Boolean value indicating whether a query string was present. This avoids logging sensitive query parameters by default.

### `user_agent_present`

Boolean value indicating whether a user agent was present. Full user-agent logging should be configurable.

## Sensitive data

The common access log should avoid sensitive data by default. Deep diagnostics may capture additional data only with explicit redaction and allowlist controls.
