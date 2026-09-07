# WebSphere container harness

The WebSphere Dockerfile is intentionally parameterized. IBM WebSphere images
are distributed through IBM registries and may require an entitlement, license
acceptance, and authentication. The harness cannot select or redistribute a
runtime image for the operator.

Build with an approved image:

```sh
docker build \
  --build-arg WEBSPHERE_BASE_IMAGE=icr.io/appcafe/websphere-liberty:full-java17-openj9-ubi \
  --file platforms/websphere/scripts/Dockerfile \
  --tag ohd-websphere-level-1 .
```

The supplied image must expose a working HTTP listener on port 9080 and write
an OHD-compatible access log to `/tmp/ohd-access.log`. The verification script
checks the resulting record with the shared Level 1 validator; it does not
configure an unknown WebSphere product version automatically.
