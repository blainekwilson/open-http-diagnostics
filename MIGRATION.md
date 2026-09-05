# Migration Notes for Draft 0.4

The uploaded repository already uses the stable top-level structure. No directory redesign is required.

## Specification changes

- Add `specification/header-fields.md` as the single authoritative definition of `traceparent`, `tracestate`, and `OHD-Trace-ID` use within OHD.
- Add `tracestate` and `ohd_trace_id` to the Level 1 canonical fields.
- Update Levels 2–4 to use the same trace identity.

## Platform changes

- IIS scripts now configure all three request-header logging fields.
- NGINX and Apache examples now log all three fields in the same canonical positions.

## Fixture changes

Level 1 positional records now begin with:

```text
timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id
```

Recommended fields follow, and platform extension fields remain at the end.

## Deployment caution

Level 1 only records incoming fields. Adding `OHD-Trace-ID` to logging does not guarantee it exists. Deploy Level 2 at an appropriate trusted layer to establish and propagate the value.
