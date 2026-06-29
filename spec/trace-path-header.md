# Trace-Path Header

## Status

Optional diagnostic extension. Disabled by default.

## Purpose

`Trace-Path` is an optional response header that provides response-visible diagnostic path hints. It is intended for environments where infrastructure owners want a safe, high-level indication of the logical path a request traversed.

It is not required for core Open HTTP Diagnostics adoption.

## Header

```http
Trace-Path: edge="a1"; waf="b2"; proxy="c3"; app="123"
```

## Security model

`Trace-Path` values must be opaque owner-defined labels. They must not reveal hostnames, IP addresses, cloud resource identifiers, product internals, account IDs, or sensitive topology details.

Good:

```http
Trace-Path: edge="a1"; waf="b2"; app="123"
```

Bad:

```http
Trace-Path: edge="cloudfront-distro-E123"; waf="imperva-proxy-iad-17"; app="prod-web-04.internal"
```

## Recommended default

```yaml
trace_path:
  enabled: false
```

## Use cases

- Confirm that traffic passed through the expected logical layers.
- Quickly detect bypass or unexpected routing.
- Provide a lightweight map of the request path during troubleshooting.
- Combine with `Trace-ID` to find detailed logs.

## Relationship to logs

`Trace-Path` is a summary. Logs remain the source of detailed truth.

The response header answers:

```text
Which logical layers handled this request?
```

The trace ID answers:

```text
Which log entries belong to this request?
```
