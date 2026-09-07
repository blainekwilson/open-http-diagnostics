# Apache Tomcat Level 1 Configuration

Tomcat can record the OHD Level 1 fields with an `AccessLogValve`. The valve
observes incoming trace headers; it does not create, validate, or propagate
Trace Context.

Authoritative requirements: [Level 1](../../specification/level-1-common-access-logging.md) and [Header Fields](../../specification/header-fields.md).

## Example valve

Place this valve inside the relevant `<Host>` element in `conf/server.xml`:

```xml
<Valve className="org.apache.catalina.valves.AccessLogValve"
       directory="logs"
       prefix="ohd-access"
       suffix=".log"
      buffered="false"
       pattern="%{yyyy-MM-dd'T'HH:mm:ssXXX}t&#9;%a&#9;%m&#9;%{Host}i&#9;%U&#9;%s&#9;%D&#9;%{traceparent}i&#9;%{tracestate}i&#9;%{OHD-Trace-ID}i&#9;%q&#9;%H&#9;%b&#9;%{Referer}i&#9;%{User-Agent}i"
       />
```

The pattern fields are ordered as follows:

```text
timestamp client_ip method host path status duration traceparent tracestate ohd_trace_id query protocol bytes_sent referer user_agent
```

## Native differences

- `%D` is request duration in microseconds; normalize it to decimal seconds.
- `%b` records response bytes, excluding the response headers.
- `%q` records the query string with a leading `?` when present.
- The valve writes a native access-log file; the log pipeline should add the
  OHD field header and normalize missing values to `-` where necessary.

## References

- Tomcat `AccessLogValve`: <https://tomcat.apache.org/tomcat-10.1-doc/config/valve.html#Access_Log_Valve>
