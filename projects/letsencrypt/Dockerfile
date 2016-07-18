FROM ubuntu:xenial
ARG LE_ENV
ARG LE_FREQ
RUN \
      apt-get update && \
      apt-get install -y cron gettext-base docker.io letsencrypt
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
