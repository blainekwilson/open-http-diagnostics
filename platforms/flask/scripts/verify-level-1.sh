#!/usr/bin/env bash
set -euo pipefail

python3 /usr/local/src/app.py &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true' EXIT

attempt=0
until curl --silent --fail http://127.0.0.1:8080/ >/dev/null; do
    if ! kill -0 "$server_pid" 2>/dev/null; then
        echo "Flask exited before becoming ready" >&2
        exit 1
    fi
    attempt=$((attempt + 1))
    if [[ "$attempt" -ge 30 ]]; then
        echo "Flask did not become ready" >&2
        exit 1
    fi
    sleep 1
done

/usr/local/bin/test-level-1.sh http://127.0.0.1:8080/
sleep 1

printf '%s\n' '#Fields: timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent' > /tmp/ohd-level-1.tsv
cat /tmp/ohd-access.tsv >> /tmp/ohd-level-1.tsv
python3 /usr/local/bin/validate-level-1-tsv.py --enforce-trace-relationship /tmp/ohd-level-1.tsv

echo "PASS: Flask OHD Level 1 log validated"
