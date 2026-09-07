# WebSphere

WebSphere is a product family rather than one interchangeable server
configuration. WebSphere traditional and WebSphere Liberty have different
runtime images, access-log configuration, support lifecycles, and deployment
models. This mapping therefore requires the exact product and version to be
selected before configuration is applied.

| OHD level | Status | Method |
|---|---|---|
| 1 | Planned | Product-version-specific HTTP access logging |
| 2 | Planned | Servlet filter, application integration, or supported tracing integration |
| 3 | Planned | Servlet filter or application integration |
| 4 | Planned | Product- and application-specific diagnostics |

The [container harness](scripts/README.md) uses a caller-supplied IBM image;
IBM runtime images may require entitlement and registry authentication. It is
not a replacement for product-specific configuration.

Do not use the Tomcat mapping for WebSphere. Some older WebSphere components
used Tomcat-derived technology, but WebSphere logging and lifecycle support are
product-specific.
