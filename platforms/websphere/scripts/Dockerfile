ARG WEBSPHERE_BASE_IMAGE=icr.io/appcafe/websphere-liberty:full-java17-openj9-ubi
FROM ${WEBSPHERE_BASE_IMAGE}

USER root
RUN dnf install -y bash curl python3 \
    && dnf clean all

COPY platforms/websphere/scripts/verify-level-1.sh /usr/local/bin/verify-level-1.sh
COPY platforms/scripts/test-level-1.sh /usr/local/bin/test-level-1.sh
COPY conformance-tests/scripts/validate-level-1-tsv.py /usr/local/bin/validate-level-1-tsv.py

RUN chmod +x /usr/local/bin/verify-level-1.sh /usr/local/bin/test-level-1.sh

EXPOSE 9080

USER default

CMD ["/usr/local/bin/verify-level-1.sh"]
