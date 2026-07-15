# Conformance

Conformance is declared per level and per implementation or platform configuration.

## Level 1

A conforming Level 1 deployment:

- produces the eight canonical fields defined by Level 1;
- preserves their defined meaning;
- uses canonical field names in structured formats;
- places extension fields after canonical and recommended fields in positional formats;
- documents missing-value and unit behavior.

## Level 2

A conforming Level 2 implementation also validates, creates when necessary, propagates, and logs W3C Trace Context.

## Level 3

A conforming Level 3 implementation follows the response trace identifier rules and documents whether the feature is enabled by default.

## Level 4

A conforming Level 4 implementation correlates deep diagnostic output with the effective trace ID and implements the security controls in the Level 4 and security documents.

## Claims

Projects should make scoped claims such as:

> NGINX configuration example conforms to OHD Level 1 Draft 0.3.

They should not claim broad platform conformance when support depends on optional modules or application code.
