#!/bin/sh
set -eu

: > /tmp/haproxy-access.log
: > /tmp/ohd-access.log
nginx &
nginx_pid=$!
haproxy -f /etc/haproxy/haproxy.cfg -db > /tmp/haproxy-access.log 2>&1 &
haproxy_pid=$!
trap 'kill "$haproxy_pid" "$nginx_pid" 2>/dev/null || true' EXIT

until curl --silent --fail http://127.0.0.1:8080/ >/dev/null; do
    sleep 1
done

/usr/local/bin/test-level-1.sh http://127.0.0.1:8080/

grep -Fq '4bf92f3577b34da6a3ce929d0e0e4736' /tmp/haproxy-access.log
grep -Fq '4bf92f3577b34da6a3ce929d0e0e4736' /tmp/ohd-access.log
echo "PASS: HAProxy proxy and Nginx backend received OHD trace values"