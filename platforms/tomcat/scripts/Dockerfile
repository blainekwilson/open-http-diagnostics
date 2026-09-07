FROM tomcat:10.1-jdk17-temurin

RUN apt-get update \
    && apt-get install -y --no-install-recommends bash curl python3 \
    && rm -rf /var/lib/apt/lists/*

COPY platforms/tomcat/scripts/configure-level-1.sh /usr/local/bin/configure-level-1.sh
COPY platforms/tomcat/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py

RUN chmod +x /usr/local/bin/configure-level-1.sh /usr/local/bin/verify-level-1.sh /usr/local/bin/test-level-1.sh \
    && /usr/local/bin/configure-level-1.sh /usr/local/tomcat/conf/server.xml /tmp \
    && touch /tmp/ohd-access.log \
    && mkdir -p /usr/local/tomcat/webapps/ROOT \
    && printf 'ok\n' > /usr/local/tomcat/webapps/ROOT/index.html \
    && catalina.sh configtest \
    && groupadd --system ohd \
    && useradd --system --gid ohd --home-dir /usr/local/tomcat --shell /usr/sbin/nologin ohd \
    && chown -R ohd:ohd /usr/local/tomcat /tmp/ohd-access.log

EXPOSE 8080

USER ohd

CMD ["/usr/local/bin/verify-level-1.sh"]
