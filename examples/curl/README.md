# curl Examples

## Request with traceparent

```bash
curl -i https://example.com/ \
  -H 'traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01'
```

## Expected response diagnostic header

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```
