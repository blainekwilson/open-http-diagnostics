# Level 3 — Response Diagnostics

**Status:** Draft 0.4  
**Level:** 3

## 1. Purpose

Level 3 returns the trace identifier used by the participating infrastructure so a client, support engineer, or automated test can report the exact value used for log correlation.

## 2. Response field

A Level 3 participant returns:

```http
OHD-Trace-ID: 4bf92f3577b34da6a3ce929d0e0e4736
```

The value must comply with [OHD HTTP Header Fields](header-fields.md) and equal the effective trace ID established at Level 2.

## 3. Required behavior

A Level 3 participant:

1. obtains the effective trace ID from its Level 2 processing context;
2. sets one `OHD-Trace-ID` response field;
3. does not append multiple values;
4. replaces a conflicting upstream value with the authoritative effective trace ID;
5. treats the field as diagnostic data only.

An implementation may allow response emission to be disabled by policy, but enabled is the recommended OHD profile.

## 4. Why the complete `traceparent` is not returned

The parent ID can change between hops. Returning only the trace ID provides stable correlation without exposing span-specific state or trace flags.

## 5. Browser access

Browser JavaScript may require:

```http
Access-Control-Expose-Headers: OHD-Trace-ID
```

for cross-origin responses. The exact CORS policy remains under application-owner control.

## 6. Caching

`OHD-Trace-ID` is request-specific. Shared caches must not replay a cached diagnostic identifier as though it belonged to a later request. Implementations should add or replace the field after cache lookup when possible, or disable it where the caching architecture cannot preserve correct semantics.

## 7. Path diagnostics

Infrastructure-path disclosure is not part of the initial Level 3 profile. It remains an experimental future extension requiring separate security and interoperability review.
