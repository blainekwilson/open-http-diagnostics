# Conformance Tests

This directory contains schemas, fixtures, and executable validators.

## Level 1 TSV

```bash
python3 conformance-tests/scripts/validate-level-1-tsv.py \
  conformance-tests/fixtures/valid-level-1.tsv \
  --enforce-trace-relationship
```

The missing-trace fixture is valid at Level 1 because Level 1 observes fields but does not guarantee their presence:

```bash
python3 conformance-tests/scripts/validate-level-1-tsv.py \
  conformance-tests/fixtures/valid-level-1-missing-trace.tsv
```

The mismatch fixture is useful for testing relationship enforcement:

```bash
python3 conformance-tests/scripts/validate-level-1-tsv.py \
  conformance-tests/fixtures/invalid-level-1-ohd-mismatch.tsv \
  --enforce-trace-relationship
```

## Markdown links

```bash
python3 conformance-tests/scripts/check-markdown-links.py
```

Future tests should cover Level 2 propagation, Level 3 response behavior, native platform mappings, and Level 4 redaction.
