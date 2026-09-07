#!/usr/bin/env bash
set -euo pipefail

server_xml="${1:-/usr/local/tomcat/conf/server.xml}"
log_directory="${2:-/tmp}"

if [[ ! -f "$server_xml" ]]; then
    echo "Tomcat server.xml not found: $server_xml" >&2
    exit 1
fi

if grep -q 'ohd-access' "$server_xml"; then
    echo "OHD Level 1 valve already configured in $server_xml"
    exit 0
fi

valve="    <Valve className=\"org.apache.catalina.valves.AccessLogValve\" directory=\"${log_directory}\" prefix=\"ohd-access\" suffix=\".log\" rotatable=\"false\" buffered=\"false\" pattern=\"%{yyyy-MM-dd'T'HH:mm:ssXXX}t&#9;%a&#9;%m&#9;%{Host}i&#9;%U&#9;%s&#9;%D&#9;%{traceparent}i&#9;%{tracestate}i&#9;%{OHD-Trace-ID}i&#9;%q&#9;%H&#9;%b&#9;%{Referer}i&#9;%{User-Agent}i\" />"

temporary_file="$(mktemp)"
trap 'rm -f "$temporary_file"' EXIT
awk -v valve="$valve" '
    !inserted && /<\/Host>/ {
        print valve
        inserted = 1
    }
    { print }
    END {
        if (!inserted) exit 1
    }
' "$server_xml" > "$temporary_file" || {
    echo "Could not find a Host element in: $server_xml" >&2
    exit 1
}

mv "$temporary_file" "$server_xml"
trap - EXIT
printf 'Configured OHD Level 1 AccessLogValve in %s\n' "$server_xml"
