# Contributing

Contributions are welcome, especially platform mappings, configuration examples, conformance fixtures, implementation code, and security review.

## Repository rules

1. Normative requirements belong only in `specification/`.
2. Platform documents reference the specification rather than restating it.
3. Implementation documentation describes installation, configuration, and implementation-specific behavior.
4. Examples are non-normative.
5. Do not add new top-level directories without a documented architecture decision.
6. Changes to `OHD-Trace-ID` must preserve its identity relationship with W3C `traceparent` unless the specification explicitly changes.

## Changes to canonical fields

A change to a canonical field name, order, unit, or meaning affects every platform. Proposals should include:

- the operational problem being solved;
- evidence that major platforms can produce the field;
- migration impact;
- updates to platform mappings, examples, schemas, and fixtures.

## Before submitting

Run:

```bash
python3 conformance-tests/scripts/check-markdown-links.py
python3 conformance-tests/scripts/validate-level-1-tsv.py conformance-tests/fixtures/valid-level-1.tsv --enforce-trace-relationship
```

## Security

Do not submit examples containing real credentials, session cookies, tokens, private hostnames, private IP addresses, account identifiers, or customer data.
