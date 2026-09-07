#!/usr/bin/env bash
set -euo pipefail

url="${1:-http://127.0.0.1:9080/}"
log_path="${OHD_WEBSPHERE_ACCESS_LOG:-/tmp/ohd-access.log}"

if [[ ! -f "$log_path" ]]; then
    echo "WebSphere OHD access log not found: $log_path" >&2
    echo "Configure the selected WebSphere product/version before running this harness." >&2
    exit 1
fi

/usr/local/bin/test-level-1.sh "$url"
sleep 1

printf '%s\n' '#Fields: timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent' > /tmp/ohd-level-1.tsv
cat "$log_path" >> /tmp/ohd-level-1.tsv
python3 /usr/local/bin/validate-level-1-tsv.py --enforce-trace-relationship /tmp/ohd-level-1.tsv

echo "PASS: WebSphere OHD Level 1 log validated"
