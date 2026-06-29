# curl Examples

## Request without traceparent

```bash
curl -i https://example.com/login
```

Expected response when `response_trace_id` is enabled:

```http
Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

## Request with traceparent

```bash
curl -i https://example.com/login \
  -H 'traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01'
```
