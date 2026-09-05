# OHD for NGINX OpenResty

This directory contains an early reference implementation for OHD Levels 2 and 3 and is the planned destination for migrated Failed Request Trace functionality at Level 4.

## Current prototype

The Lua module:

- parses usable version `00` `traceparent` values;
- creates a new trace when one is absent or unusable;
- derives `OHD-Trace-ID` from the effective trace ID;
- forwards matching request fields to upstream applications;
- returns `OHD-Trace-ID` in the response;
- exposes variables for access logging.

This is a prototype, not a production release. It currently depends on `lua-resty-random` and `lua-resty-string`.

## Files

```text
lua/ohd_trace.lua
nginx/ohd.conf
```

## Example use

Include `nginx/ohd.conf` from the `http` context, then call the access and header-filter hooks in the relevant server or location as shown in that file.

## Security

The implementation does not treat incoming trace data as trusted. It replaces a conflicting `OHD-Trace-ID` with the trace ID from usable W3C Trace Context, or establishes a new trace when no usable context exists.

## Next work

- comprehensive W3C version-forwarding behavior;
- tracestate validation and mutation rules;
- automated integration tests;
- bounded diagnostics and FRT migration;
- packaging and dependency pinning.
