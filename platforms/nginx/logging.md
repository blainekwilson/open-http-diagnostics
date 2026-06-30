# NGINX Common Access Logging

## Overview

NGINX can achieve OHD Level 1 compliance using configuration alone.

No custom modules or Lua code are required.

This document maps the OHD Common Access Logging Profile to native NGINX logging variables.

See:

../../specification/common-access-logging-profile.md

---

## Core Profile Mapping

| OHD Field | NGINX Variable |
|-----------|----------------|
| timestamp | $time_iso8601 |
| client_ip | $remote_addr |
| method | $request_method |
| host | $host |
| path | $uri |
| status | $status |
| duration | $request_time |
| traceparent | $http_traceparent |

## Recommended Fields

| OHD Field | NGINX Variable |
|-----------|----------------|
| query | $args |
| protocol | $server_protocol |
| bytes_sent | $body_bytes_sent |
| referer | $http_referer |
| user_agent | $http_user_agent |
| tracestate | $http_tracestate |

## Example Configuration

...

## Example Log

...

## Conformance

NGINX can achieve OHD Level 1 using configuration only.

Level 2 and higher require additional implementations such as:

- OpenResty
- Native NGINX module