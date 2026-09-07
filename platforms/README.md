# Platform Support

Platform documents explain how an existing product maps to the OHD specification. They are non-normative and must link to the authoritative specification.

| Platform | Level 1 | Level 2 | Level 3 | Level 4 |
|---|---|---|---|---|
| IIS 8.5+ | Configuration and PowerShell helpers | Requires module or application middleware | Requires module or application middleware | Native FREB mapping and future integration |
| NGINX | Native `log_format` | OpenResty or native module | OpenResty or native module | OpenResty implementation planned |
| Apache HTTP Server | Native `LogFormat` | Module or application support | Module or application support | Planned |
| Envoy | Native access-log formatting | Native tracing/provider configuration requires detailed validation | Filter or application support | Planned |
| HAProxy | Native log formatting | Lua/service support requires detailed validation | Lua/service support | Planned |
| ASP.NET Core Kestrel | Planned ASP.NET Core logging or middleware | Planned ASP.NET Core middleware | Planned ASP.NET Core middleware | Application-specific diagnostics |
| Apache Tomcat | Native `AccessLogValve` | Servlet filter, agent, or application support | Servlet filter or application support | Planned |
| Flask | WSGI middleware | Flask or WSGI middleware | Flask or WSGI middleware | Application-specific diagnostics |
| WebSphere | Planned product-version-specific access logging | Planned application or tracing integration | Planned application integration | Planned |
| WildFly / JBoss EAP | Planned | Planned | Planned | Planned |
| AWS Lambda | Provider/front-door access logs | Planned runtime wrapper or tracing integration | Planned handler integration | Provider- and application-specific diagnostics |
| Azure Functions | Host/platform logs | Planned function middleware or tracing integration | Planned function integration | Provider- and application-specific diagnostics |
| Google Cloud Functions | Cloud Logging/front-door logs | Planned function wrapper or tracing integration | Planned function integration | Provider- and application-specific diagnostics |
| Google Cloud Run | Managed request logs or application logging | Planned application middleware | Planned application integration | Application-specific diagnostics |
| AWS API Gateway | Native access logging | Native tracing plus integration validation | Integration-specific | Planned |
| AWS Application Load Balancer | Native access logging | Trace propagation requires target integration | Target integration | Planned |
| Azure Front Door | Azure diagnostics access logs | Trace propagation requires backend integration | Backend integration | Planned |
| Azure Application Gateway | Azure diagnostics access logs | Trace propagation requires backend integration | Backend integration | Planned |
| Azure API Management | Native gateway diagnostics | Policy or backend integration | Policy or backend integration | Planned |
| Google Cloud Load Balancing | Cloud Logging request logs | Trace propagation requires backend integration | Backend integration | Planned |
| Google Cloud API Gateway | Cloud Logging request logs | Gateway/backend integration | Backend integration | Planned |

A platform can support a level through native features, configuration, scripts, middleware, or a linked reference implementation.

Cloud-native deployments should map the concrete ingress, gateway, proxy, service
mesh, or application runtime that owns the request at each hop. See the
[cloud-native guidance](cloud-native/README.md) for the recommended ownership
model.
