#!/usr/bin/env bash
set -euo pipefail

config_path="${1:-/usr/local/apache2/conf/httpd.conf}"
log_path="${2:-/tmp/ohd-access.log}"

if [[ ! -f "$config_path" ]]; then
    echo "Apache configuration not found: $config_path" >&2
    exit 1
fi

cat >> "$config_path" <<EOF

LogFormat "%{%Y-%m-%dT%H:%M:%S%z}t\\t%a\\t%m\\t%v\\t%U\\t%>s\\t%D\\t%{traceparent}i\\t%{tracestate}i\\t%{OHD-Trace-ID}i\\t%q\\t%H\\t%B\\t%{Referer}i\\t%{User-Agent}i" ohd_tsv
CustomLog "$log_path" ohd_tsv
EOF

echo "Configured OHD Level 1 logging in $config_path"