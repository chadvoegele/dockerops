FROM localhost:5000/gogs
ARG DOMAIN
COPY app.ini.template /tmp/app.ini.template
COPY gogs_strap.sh.template /tmp/gogs_strap.sh.template
RUN \
      envsubst '${DOMAIN}' < /tmp/app.ini.template > /etc/gogs_app.ini && \
      envsubst '${DOMAIN}' < /tmp/gogs_strap.sh.template > ./gogs_strap.sh && \
      chmod +x ./gogs_strap.sh && \
      rm /tmp/app.ini.template && \
      rm /tmp/gogs_strap.sh.template
ENTRYPOINT ["./gogs_strap.sh"]
CMD ["/bin/s6-svscan", "/app/gogs/docker/s6/"]
