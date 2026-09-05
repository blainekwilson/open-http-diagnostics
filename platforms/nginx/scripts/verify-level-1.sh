#!/bin/sh
set -eu

nginx
trap 'nginx -s stop' EXIT

until curl --silent --fail http://127.0.0.1:8080/ >/dev/null; do
    sleep 1
done

: > /tmp/ohd-access.log
/usr/local/bin/test-level-1.sh http://127.0.0.1:8080/

printf '%s\n' '#Fields: timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent' > /tmp/ohd-level-1.tsv
cat /tmp/ohd-access.log >> /tmp/ohd-level-1.tsv
python3 /usr/local/bin/validate-level-1-tsv.py --enforce-trace-relationship /tmp/ohd-level-1.tsv

python3 - /tmp/ohd-access.log <<'PY'
import csv
import sys

with open(sys.argv[1], newline="") as log_file:
    row = next(csv.reader(log_file, delimiter="\t"))

assert row[1] == "127.0.0.1", row
assert row[2] == "GET", row
assert row[4] == "/", row
assert row[5] == "200", row
assert row[7] == "00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01", row
assert row[8] == "ohd=test", row
assert row[9] == "4bf92f3577b34da6a3ce929d0e0e4736", row
print("PASS: NGINX OHD Level 1 log values verified")
PY