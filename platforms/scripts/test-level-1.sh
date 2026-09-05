#!/usr/bin/env bash
set -euo pipefail

url="${1:-http://127.0.0.1/}"
trace_id="4bf92f3577b34da6a3ce929d0e0e4736"
traceparent="00-${trace_id}-00f067aa0ba902b7-01"

curl --fail-with-body --silent --show-error --output /dev/null \
  -H "traceparent: ${traceparent}" \
  -H "tracestate: ohd=test" \
  -H "OHD-Trace-ID: ${trace_id}" \
  "$url"

echo "Sent OHD Level 1 test request to $url"
echo "Expected trace ID: $trace_id"