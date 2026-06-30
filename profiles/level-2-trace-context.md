# Level 2: Trace Context Enforcement

Level 2 ensures every participating request has trace context.

## Required behavior

- Validate incoming `traceparent` where possible.
- Preserve valid incoming `traceparent` values.
- Generate a new valid `traceparent` if missing or invalid and the platform is capable of doing so.
- Forward the resulting `traceparent` to downstream systems.
- Log the trace context.

## Recommended behavior

- Record whether the trace context was received or generated.
- Use cryptographically strong randomness for generated trace and span IDs.
