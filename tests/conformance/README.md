# Conformance Tests

Future conformance tests should validate that implementations:

- Preserve valid `traceparent` headers.
- Generate valid `traceparent` when missing if configured.
- Replace invalid `traceparent` when configured.
- Log `trace_id` using the common field name.
- Return `Trace-ID` when configured.
- Do not expose unsafe values in `Trace-Path` examples.
