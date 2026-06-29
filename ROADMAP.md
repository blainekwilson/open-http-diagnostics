# Roadmap

## Phase 1: Project foundation

- Define project scope and terminology.
- Draft the core specification documents.
- Establish repository structure.
- Document security requirements and non-goals.
- Migrate existing Failed Request Trace work into `implementations/nginx-openresty/`.

## Phase 2: Trace Context and logging profile

- Implement W3C `traceparent` validation.
- Generate `traceparent` when missing or invalid.
- Preserve existing trace context when valid.
- Define common log field names.
- Produce sample JSON access logs.

## Phase 3: Response Trace ID

- Add optional `Trace-ID` response header.
- Return the active trace ID to clients for support correlation.
- Ensure existing response headers are not overwritten unless explicitly configured.
- Document CORS considerations for browser clients.

## Phase 4: Optional diagnostic path hints

- Define `Trace-Path` response header semantics.
- Keep `Trace-Path` disabled by default.
- Require opaque deployment-defined identifiers.
- Document safe and unsafe examples.

## Phase 5: Deep diagnostics

- Integrate Failed Request Trace-style request capture.
- Include request/response metadata, timing, upstream selection, and redacted headers.
- Correlate deep diagnostics with the same trace ID used in access logs.

## Phase 6: Additional implementations

Potential reference implementations:

- NGINX/OpenResty
- Apache HTTP Server
- IIS
- ASP.NET Core
- Flask
- Express
- Envoy
- HAProxy
