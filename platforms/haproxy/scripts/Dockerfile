FROM haproxy:3.0-alpine

USER root
RUN apk add --no-cache bash curl nginx python3 \
    && rm -f /etc/nginx/http.d/default.conf

COPY platforms/nginx/scripts/configure-level-1.sh /usr/local/bin/configure-nginx-level-1.sh
COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY platforms/haproxy/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py
COPY platforms/haproxy/scripts/haproxy.cfg /etc/haproxy/haproxy.cfg

RUN chmod +x /usr/local/bin/configure-nginx-level-1.sh /usr/local/bin/test-level-1.sh /usr/local/bin/verify-level-1.sh \
    && printf '%s\n' \
        'pid /tmp/nginx.pid;' \
        'error_log /tmp/nginx-error.log notice;' \
        'worker_processes 1;' \
        'events { worker_connections 16; }' \
        'http {' \
        '    server { listen 8081; location / { return 200 "ok\n"; } }' \
        '}' > /etc/nginx/nginx.conf \
    && /usr/local/bin/configure-nginx-level-1.sh /etc/nginx/nginx.conf /etc/nginx/conf.d/ohd-level-1.conf /tmp/ohd-access.log \
    && chmod 644 /etc/nginx/nginx.conf /etc/nginx/conf.d/ohd-level-1.conf \
    && chmod 755 /etc/nginx /etc/nginx/conf.d \
    && chmod 755 /var/log/nginx \
    && touch /var/log/nginx/error.log /tmp/nginx.pid /tmp/nginx-error.log /tmp/ohd-access.log /tmp/haproxy-access.log \
    && chown haproxy:haproxy /var/log/nginx/error.log /tmp/nginx.pid /tmp/nginx-error.log /tmp/ohd-access.log /tmp/haproxy-access.log \
    && chown -R haproxy:haproxy /var/lib/nginx \
    && nginx -t \
    && haproxy -c -f /etc/haproxy/haproxy.cfg

USER haproxy
EXPOSE 8080
CMD ["/usr/local/bin/verify-level-1.sh"]