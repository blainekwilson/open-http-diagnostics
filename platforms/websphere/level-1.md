# WebSphere Level 1 Mapping

WebSphere Level 1 support must be documented against an exact product and
version, such as WebSphere traditional or WebSphere Liberty. The mapping must
identify the native HTTP access-log facility, its field syntax, duration unit,
rotation behavior, and how incoming `traceparent`, `tracestate`, and
`OHD-Trace-ID` headers are recorded.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

No single WebSphere configuration is provided here because applying a Liberty
configuration to WebSphere traditional, or vice versa, would be misleading.
Use the product-specific server documentation and preserve the OHD canonical
field meanings when writing the mapping.
