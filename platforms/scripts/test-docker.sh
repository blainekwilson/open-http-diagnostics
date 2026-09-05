#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

dockerfiles=(
    "platforms/nginx/scripts/Dockerfile:ohd-nginx-level-1"
    "platforms/apache/scripts/Dockerfile:ohd-apache-level-1"
    "platforms/envoy/scripts/Dockerfile:ohd-envoy-level-1"
    "platforms/haproxy/scripts/Dockerfile:ohd-haproxy-level-1"
)

build_images() {
    for dockerfile in "${dockerfiles[@]}"; do
        path="${dockerfile%%:*}"
        image="${dockerfile##*:}"
        echo "Building $image from $path"
        docker build --file "$repo_root/$path" --tag "$image" "$repo_root"
    done
}

run_images() {
    for dockerfile in "${dockerfiles[@]}"; do
        image="${dockerfile##*:}"
        echo "Running $image"
        docker run --rm "$image"
    done
}

mode="${1:-all}"
case "$mode" in
    build)
        build_images
        ;;
    run)
        run_images
        ;;
    all)
        build_images
        run_images
        ;;
    *)
        echo "Usage: $0 [build|run|all]" >&2
        exit 2
        ;;
esac