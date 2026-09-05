#!/bin/sh
set -eu

httpd -DFOREGROUND &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true' EXIT

attempt=0
until curl --silent --fail http://127.0.0.1:8080/ >/dev/null; do
    if ! kill -0 "$server_pid" 2>/dev/null; then
        echo "Apache exited before becoming ready" >&2
        exit 1
    fi
    attempt=$((attempt + 1))
    if [ "$attempt" -ge 30 ]; then
        echo "Apache did not become ready" >&2
        exit 1
    fi
    sleep 1
done

: > /tmp/ohd-access.log
/usr/local/bin/test-level-1.sh http://127.0.0.1:8080/

printf '%s\n' '#Fields: timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent' > /tmp/ohd-level-1.tsv
cat /tmp/ohd-access.log >> /tmp/ohd-level-1.tsv
python3 /usr/local/bin/validate-level-1-tsv.py --enforce-trace-relationship /tmp/ohd-level-1.tsv

echo "PASS: Apache OHD Level 1 log validated"