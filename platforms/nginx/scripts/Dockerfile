FROM nginx:1.27-alpine

RUN apk add --no-cache bash curl python3

COPY platforms/nginx/scripts/configure-level-1.sh /usr/local/bin/configure-level-1.sh
COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY platforms/nginx/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py

RUN chmod +x /usr/local/bin/configure-level-1.sh /usr/local/bin/test-level-1.sh /usr/local/bin/verify-level-1.sh \
    && printf '%s\n' \
        'pid /tmp/nginx.pid;' \
        'error_log /dev/stderr notice;' \
        'worker_processes 1;' \
        'events { worker_connections 16; }' \
        'http {' \
        '    server {' \
        '        listen 8080;' \
        '        location / { return 200 "ok\n"; }' \
        '    }' \
        '}' > /etc/nginx/nginx.conf \
    && /usr/local/bin/configure-level-1.sh /etc/nginx/nginx.conf /etc/nginx/conf.d/ohd-level-1.conf /tmp/ohd-access.log \
    && chmod 644 /etc/nginx/nginx.conf /etc/nginx/conf.d/ohd-level-1.conf \
    && chmod 755 /etc/nginx /etc/nginx/conf.d \
    && touch /tmp/ohd-access.log \
    && chown nginx:nginx /tmp/ohd-access.log \
    && touch /tmp/nginx.pid \
    && chown nginx:nginx /tmp/nginx.pid \
    && nginx -t

USER nginx

CMD ["/usr/local/bin/verify-level-1.sh"]
