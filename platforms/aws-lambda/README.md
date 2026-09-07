# AWS Lambda

AWS Lambda is a managed function runtime, not a complete HTTP boundary by
itself. HTTP requests may enter through API Gateway, an Application Load
Balancer, a Lambda Function URL, or another service. This mapping covers the
Lambda runtime and identifies the front door that owns each access record.

| OHD level | Status | Method |
|---|---|---|
| 1 | Provider/front-door dependent | API Gateway, ALB, Function URL, and CloudWatch logs must be mapped per deployment |
| 2 | Planned | Lambda wrapper, runtime integration, or supported OpenTelemetry integration |
| 3 | Planned | Handler response integration |
| 4 | Application-specific | Bounded function diagnostics with explicit redaction and retention |

Start with [Level 1](level-1.md). The [AWS Lambda implementation](../../implementations/aws-lambda/README.md)
is planned and does not replace the access log owned by the HTTP front door.
