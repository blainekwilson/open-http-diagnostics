# FAQ

## Is OHD another logging backend?

No. OHD defines what HTTP layers should record and how they correlate requests. It does not replace Splunk, Elastic, CloudWatch, OpenTelemetry collectors, or other storage and analysis systems.

## Does OHD replace OpenTelemetry?

No. It provides a low-friction operational profile that complements OpenTelemetry and uses W3C Trace Context.

## Why not require JSON?

Many mature platforms already produce W3C-style or delimited access logs. OHD standardizes semantics while allowing native formats.

## Why is the response trace ID optional?

Some organizations do not want client-visible diagnostic identifiers. Level 3 is an explicit policy choice.

## Why is path disclosure not in the initial Level 3 profile?

It creates security and adoption concerns. The project first standardizes the less controversial trace identifier and leaves path hints experimental.
