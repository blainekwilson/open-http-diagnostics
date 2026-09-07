# Cloud-native deployments

Kubernetes, containers, and service meshes are deployment environments, not one
HTTP server implementation. OHD ownership should be assigned to the component
that receives or creates each request record.

| Component | Typical OHD responsibility |
|---|---|
| Ingress controller or API gateway | Level 1 access logging at the external boundary; Level 2 when it owns trace-context establishment |
| Sidecar or service-mesh proxy | Level 1 for the hop it handles; preserve the W3C trace relationship across hops |
| Application runtime | Levels 2 and 3 when the application creates the trace context or response header |
| Serverless or managed runtime | Provider-specific access logs plus application integration where headers or response behavior are required |

Existing Envoy, NGINX, and HAProxy mappings apply when those products are the
actual gateway or proxy. A cloud provider, Kubernetes distribution, or service
mesh should not be given a generic OHD mapping until its concrete logging and
trace-propagation behavior is documented.

Serverless functions need an additional boundary decision. API Gateway, an
Application Load Balancer, a Function URL, a Functions host, or a managed
container ingress may own the Level 1 access record, while the function or
container owns Levels 2 and 3. Do not merge front-door and invocation logs
without documenting their relationship.

Avoid producing multiple indistinguishable Level 1 records for the same hop.
Keep the boundary owner, trace fields, duration unit, and field normalization
explicit in the platform mapping.
