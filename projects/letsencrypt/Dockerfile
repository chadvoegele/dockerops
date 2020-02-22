FROM ubuntu:xenial
ARG CERTBOT_VERSION
WORKDIR /tmp
RUN \
      apt-get update && \
      apt-get install -y cron gettext-base docker.io python-dialog && \
      apt-get install -y curl gcc python-setuptools python-dev python-mock libffi-dev libssl-dev && \
      LINK="https://codeload.github.com/certbot/certbot/tar.gz/v${CERTBOT_VERSION}" && \
      DEST="/tmp/certbot-v${CERTBOT_VERSION}.tar.gz" && \
      CERTBOT_SRC="/tmp/certbot-${CERTBOT_VERSION}" && \
      curl -o ${DEST} ${LINK} && \
      tar -xf ${DEST} -C /tmp && \
      cd "${CERTBOT_SRC}" && \
      cd certbot && \
      python setup.py build && \
      python setup.py install --optimize=1 && \
      cd .. && \
      rm -rf "${CERTBOT_SRC}" "${DEST}" && \
      apt-get purge -y curl gcc python-dev libffi-dev libssl-dev
ARG LE_ENV
ARG LE_FREQ
COPY renew.sh.template /tmp/renew.sh.template
COPY crontab_renew.template /tmp/crontab_renew.template
RUN \
      envsubst '${LE_ENV}' < /tmp/renew.sh.template > /usr/bin/renew && \
      envsubst '${LE_FREQ}' < /tmp/crontab_renew.template > /etc/cron.d/renew && \
      chmod a+x /usr/bin/renew && \
      rm /tmp/renew.sh.template /tmp/crontab_renew.template && \
      mkdir -p /tmp/log/letsencrypt && \
      touch /tmp/log/letsencrypt/out.log
ENTRYPOINT [ "/bin/bash", "-c", "/usr/sbin/cron && tail -f /tmp/log/letsencrypt/out.log" ]
