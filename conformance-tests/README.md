# Conformance Tests

This directory will contain executable tests and fixtures.

Initial Level 1 tests should verify:

- all canonical fields are present;
- field order is correct for positional records;
- `duration` is represented in decimal seconds or is normalized by a documented adapter;
- the observed `traceparent` value is recorded without modification;
- missing values are unambiguous;
- extension fields occur after canonical and recommended fields.
