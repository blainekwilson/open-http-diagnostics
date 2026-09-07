#!/usr/bin/env bash
set -euo pipefail

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 path/to/exported-level-1.tsv" >&2
    exit 2
fi

input_path="$1"
if [[ ! -f "$input_path" ]]; then
    echo "Level 1 export not found: $input_path" >&2
    exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
python3 "$repo_root/conformance-tests/scripts/validate-level-1-tsv.py" \
    --enforce-trace-relationship \
    "$input_path"
