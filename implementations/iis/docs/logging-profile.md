# IIS Logging Profile

## Manual configuration

In IIS Manager:

1. Select the server or site.
2. Open **Logging**.
3. Click **Select Fields...**.
4. Click **Add Field...**.
5. Add the following custom fields.

### traceparent

- Field Name: `traceparent`
- Source Type: `Request Header`
- Source: `traceparent`

### tracestate

- Field Name: `tracestate`
- Source Type: `Request Header`
- Source: `tracestate`

### ohd-trace-id

- Field Name: `ohd-trace-id`
- Source Type: `Response Header`
- Source: `OHD-Trace-ID`

### ohd-trace-path

- Field Name: `ohd-trace-path`
- Source Type: `Response Header`
- Source: `OHD-Trace-Path`
