# NGINX Level 3

Level 3 requires a reliable effective trace ID from Level 2 and emits one `OHD-Trace-ID` response field.

Native `add_header` can emit a configured variable, but creation and validation of that variable require a Level 2 implementation such as OpenResty or a native module.

Authoritative behavior: [Level 3 specification](../../specification/level-3-response-diagnostics.md).
