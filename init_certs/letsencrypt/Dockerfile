FROM ubuntu:xenial
ARG CERTBOT_VERSION
WORKDIR /tmp
RUN \
      apt-get update && \
      apt-get install -y cron gettext-base docker.io python-dialog && \
      apt-get install -y curl gcc python-setuptools python-dev libffi-dev libssl-dev
RUN \
      LINK="https://codeload.github.com/certbot/certbot/tar.gz/v${CERTBOT_VERSION}" && \
      DEST="/tmp/certbot-v${CERTBOT_VERSION}.tar.gz" && \
      CERTBOT_SRC="/tmp/certbot-${CERTBOT_VERSION}" && \
      curl -o ${DEST} ${LINK} && \
      tar -xf ${DEST} -C /tmp && \
      cd "${CERTBOT_SRC}" && \
      python setup.py build && \
      python setup.py install --optimize=1 && \
      cd .. && \
      rm -rf "${CERTBOT_SRC}" "${DEST}" && \
      apt-get purge -y curl gcc python-dev libffi-dev libssl-dev
ARG LE_ENV
ARG EMAIL
COPY download_certs.sh.template /tmp/download_certs.sh.template
RUN \
    envsubst '${LE_ENV},${EMAIL}' < /tmp/download_certs.sh.template > /usr/bin/download_certs.sh && \
    rm /tmp/download_certs.sh.template && \
    chmod +x /usr/bin/download_certs.sh
