FROM quay.io/letsencrypt/letsencrypt
ARG LE_ENV
ARG EMAIL
COPY download_certs.sh.template /tmp/download_certs.sh.template
RUN \
      apt-get update && \
      apt-get install -y gettext-base
RUN \
    envsubst '${LE_ENV},${EMAIL}' < /tmp/download_certs.sh.template > /usr/bin/download_certs.sh && \
    rm /tmp/download_certs.sh.template && \
    chmod +x /usr/bin/download_certs.sh
