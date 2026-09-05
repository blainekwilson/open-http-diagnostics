#!/bin/sh
set -eu

: > /tmp/envoy-access.log
: > /tmp/ohd-access.log
nginx &
nginx_pid=$!
envoy -c /etc/envoy/envoy.yaml --log-path /tmp/envoy-error.log &
envoy_pid=$!
trap 'kill "$envoy_pid" "$nginx_pid" 2>/dev/null || true' EXIT

until curl --silent --fail http://127.0.0.1:8080/ >/dev/null; do
    sleep 1
done

/usr/local/bin/test-level-1.sh http://127.0.0.1:8080/

kill "$envoy_pid"
sleep 1

wait_for_trace() {
    log_path="$1"
    attempt=0
    while ! grep -Fq '4bf92f3577b34da6a3ce929d0e0e4736' "$log_path"; do
        attempt=$((attempt + 1))
        if [ "$attempt" -ge 10 ]; then
            echo "Trace ID was not written to $log_path" >&2
            cat "$log_path" >&2
            exit 1
        fi
        sleep 1
    done
}

test -s /tmp/envoy-access.log
wait_for_trace /tmp/ohd-access.log
echo "PASS: Envoy proxy and Nginx backend received OHD trace values"