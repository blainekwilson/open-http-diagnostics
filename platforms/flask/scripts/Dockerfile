FROM python:3.13-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends bash curl \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir Flask \
    && groupadd --system flask \
    && useradd --system --gid flask --home-dir /usr/local/src --shell /usr/sbin/nologin flask

COPY implementations/flask/ohd_logging.py /usr/local/src/ohd_logging.py
COPY platforms/flask/scripts/app.py /usr/local/src/app.py
COPY platforms/flask/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py

RUN chmod +x /usr/local/bin/verify-level-1.sh /usr/local/bin/test-level-1.sh

EXPOSE 8080

USER flask

CMD ["/usr/local/bin/verify-level-1.sh"]
