# Deep Diagnostics

## Purpose

Deep diagnostics extend common logging with richer request/response capture for troubleshooting failed or suspicious requests.

## Examples of deep diagnostic data

- Request headers with sensitive values redacted
- Response headers with sensitive values redacted
- Routing decisions
- Upstream selection
- Timing breakdowns
- Rewrite decisions
- Authentication and authorization outcomes
- Error details

## Relationship to FRT

Failed Request Trace concepts are treated as a Level 4 capability in Open HTTP Diagnostics. Level 4 diagnostics should correlate with Level 1 logs using the same `trace_id`.
