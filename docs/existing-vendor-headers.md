# Existing Vendor Headers

This document tracks existing diagnostic, tracing, and request identification headers used by common infrastructure platforms.

The goal is to document what already exists before defining new behavior.

## Cloud/CDN/WAF examples to research

- AWS CloudFront
- AWS Application Load Balancer
- AWS API Gateway
- Imperva Cloud WAF
- F5 BIG-IP
- Cloudflare
- Akamai
- Azure Front Door
- Google Cloud Load Balancing

## Web/proxy examples to research

- NGINX
- OpenResty
- Apache HTTP Server
- IIS
- Envoy
- HAProxy
- Caddy

## Application framework examples to research

- ASP.NET Core
- Flask
- Express
- Spring Boot
- FastAPI
- Django

## Documentation format

Each platform entry should include:

```markdown
## Platform name

### Request headers added

### Response headers added

### Trace context support

### Can generate traceparent if missing?

### Can log trace ID?

### Can add response Trace-ID?

### Can add opaque path hint?

### Notes and limitations
```
