#!/usr/bin/env bash
set -euo pipefail

config_path="${1:-/etc/nginx/nginx.conf}"
snippet_path="${2:-/etc/nginx/conf.d/ohd-level-1.conf}"
log_path="${3:-/var/log/nginx/ohd-access.log}"

if [[ ! -f "$config_path" ]]; then
    echo "NGINX configuration not found: $config_path" >&2
    exit 1
fi

snippet_directory="${snippet_path%/*}"
mkdir -p "$snippet_directory"

cat > "$snippet_path" <<'EOF'
log_format ohd_tsv
    '$time_iso8601\t'
    '$remote_addr\t'
    '$request_method\t'
    '$host\t'
    '$uri\t'
    '$status\t'
    '$request_time\t'
    '$http_traceparent\t'
    '$http_tracestate\t'
    '$http_ohd_trace_id\t'
    '$args\t'
    '$server_protocol\t'
    '$body_bytes_sent\t'
    '$http_referer\t'
    '$http_user_agent';

EOF

printf 'access_log %s ohd_tsv;\n' "$log_path" >> "$snippet_path"

include_line="    include ${snippet_path};"
if ! grep -Fqx "$include_line" "$config_path"; then
    temporary_config="$(mktemp)"
    trap 'rm -f "$temporary_config"' EXIT
    awk -v include_line="$include_line" '
        !inserted && $0 ~ /^[[:space:]]*http[[:space:]]*\{[[:space:]]*$/ {
            print
            print include_line
            inserted = 1
            next
        }
        { print }
        END {
            if (!inserted) {
                exit 1
            }
        }
    ' "$config_path" > "$temporary_config" || {
        echo "Could not find the http context in: $config_path" >&2
        exit 1
    }
    chmod --reference="$config_path" "$temporary_config" 2>/dev/null || true
    mv "$temporary_config" "$config_path"
fi

echo "Configured OHD Level 1 logging in $config_path"
echo "OHD logging snippet: $snippet_path"