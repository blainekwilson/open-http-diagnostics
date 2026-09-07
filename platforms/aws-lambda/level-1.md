# AWS Lambda Level 1 Mapping

AWS Lambda does not guarantee one native access-log record containing the OHD
canonical fields. The HTTP front door should normally own Level 1:

- API Gateway access logs for API Gateway requests;
- Application Load Balancer access logs for ALB targets; or
- Function URL and runtime logs when a Function URL is the documented boundary.

Lambda application logs may add invocation context, but they must not be
mistaken for a complete access record unless the deployment documents the
missing fields and their source.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

Do not substitute AWS X-Ray's `X-Amzn-Trace-Id` for W3C `traceparent`. A Level
2 integration must preserve the OHD relationship to the effective W3C trace ID.

Validate an exported, normalized Level 1 record with:

```sh
./scripts/verify-level-1.sh path/to/exported-level-1.tsv
```
