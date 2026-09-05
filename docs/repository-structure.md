# Repository Structure

The repository structure is considered stable.

## Root files

- `README.md` — project landing page and reading order
- `ROADMAP.md` — milestones and sequencing
- `SECURITY.md` — vulnerability reporting and project security principles
- `CONTRIBUTING.md` — contribution rules
- `CHANGELOG.md` — notable project changes

## Directories

### `specification/`

The only normative source. Header formats, level requirements, conformance, and security requirements are defined here.

### `platforms/`

Product-specific configuration, mappings, limitations, and helper scripts. Platform documents link to the specification instead of restating it.

### `implementations/`

Source code for middleware, modules, and other components that add behavior not available through native configuration.

### `examples/`

Sample requests, responses, logs, and configurations. Examples are non-normative.

### `conformance-tests/`

Schemas, fixtures, and executable validators.

### `docs/`

Architecture, rationale, design principles, standards research, and FAQ.

## Change rule

Do not add another top-level directory unless existing boundaries cannot reasonably hold the work and an architecture decision explains why.
