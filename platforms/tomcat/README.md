# Apache Tomcat

Apache Tomcat is a Java Servlet and JSP container with native access logging
through `AccessLogValve`. This mapping covers Tomcat itself; application
frameworks and upstream proxies remain separate diagnostic owners.

| OHD level | Status | Method |
|---|---|---|
| 1 | Documented | Native `AccessLogValve` pattern |
| 2 | Planned | Servlet filter, agent, or application tracing integration |
| 3 | Planned | Servlet filter or application integration |
| 4 | Planned | Container- or application-specific diagnostics |

Start with [Level 1](level-1.md).

## JBoss relationship

Tomcat should not be used as the name for all JBoss-family servers. Older JBoss
AS releases used a Tomcat-derived web container, while modern WildFly uses
Undertow and JBoss EAP has its own product and version support boundaries. Those
runtimes should receive a separate `wildfly` or `jboss-eap` mapping when their
native logging is documented.
