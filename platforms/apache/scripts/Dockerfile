FROM httpd:2.4-alpine

RUN apk add --no-cache bash curl python3 \
    && sed -i 's/^Listen 80$/Listen 8080/' /usr/local/apache2/conf/httpd.conf \
    && printf '%s\n' 'ServerName localhost' 'PidFile /tmp/httpd.pid' 'ErrorLog /dev/stderr' >> /usr/local/apache2/conf/httpd.conf

COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY platforms/apache/scripts/configure-level-1.sh /usr/local/bin/configure-level-1.sh
COPY platforms/apache/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py

RUN chmod +x /usr/local/bin/test-level-1.sh /usr/local/bin/configure-level-1.sh /usr/local/bin/verify-level-1.sh \
    && /usr/local/bin/configure-level-1.sh /usr/local/apache2/conf/httpd.conf /tmp/ohd-access.log \
    && touch /tmp/ohd-access.log \
    && chown daemon:daemon /tmp/ohd-access.log \
    && httpd -t

EXPOSE 8080

USER daemon

CMD ["/usr/local/bin/verify-level-1.sh"]