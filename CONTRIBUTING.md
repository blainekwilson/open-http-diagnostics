# Contributing

Contributions are welcome, especially platform mappings, configuration examples, conformance fixtures, and security review.

## Repository rules

1. Normative requirements belong only in `specification/`.
2. Platform documents must reference the specification rather than restating it.
3. Implementation documentation should describe installation, configuration, and behavior specific to that implementation.
4. Examples are non-normative.
5. Do not add new top-level directories without an architecture decision record.

## Changes to canonical fields

A change to a canonical field name, order, unit, or meaning affects every platform. Proposals should include:

- the operational problem being solved;
- evidence that major platforms can produce the field;
- migration impact;
- updates to conformance fixtures.

## Security

Do not submit examples containing real credentials, session cookies, tokens, private hostnames, private IP addresses, account identifiers, or customer data.
