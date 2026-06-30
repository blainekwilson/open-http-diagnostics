# Conformance

This document will define conformance levels for Open HTTP Diagnostics.

## Level 1 conformance

A platform is Level 1 conformant when it can log the required Common HTTP Diagnostics fields available to that platform, including the `traceparent` request header where supported.

## Level 2 conformance

A platform is Level 2 conformant when it can create a valid `traceparent` if one is missing or invalid, preserve valid incoming `traceparent` values, and log the resulting trace context.

## Level 3 conformance

A platform is Level 3 conformant when it supports optional response diagnostics such as `OHD-Trace-ID` and, if enabled, `OHD-Trace-Path`.

## Level 4 conformance

A platform is Level 4 conformant when it supports deep diagnostics correlated by the same trace ID used in Level 1 logs.
