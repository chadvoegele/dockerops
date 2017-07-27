FROM alpine:3.5
ADD https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64 /usr/sbin/gosu
RUN \
    chmod +x /usr/sbin/gosu && \
    apk --no-cache --no-progress add ca-certificates bash git linux-pam s6 curl openssh socat gettext tar
ENV GOGS_CUSTOM /data/gogs
WORKDIR /tmp
RUN \
     curl -o /tmp/gogs.tar.gz https://codeload.github.com/gogits/gogs/tar.gz/v0.11.19 && \
     mkdir -p /tmp/gogs-extract && \
     tar -xf /tmp/gogs.tar.gz -C /tmp/gogs-extract && \
     mkdir -p /app/gogs/build && \
     cp -r /tmp/gogs-extract/gogs-0.11.19/* /app/gogs/build && \
     cp /app/gogs/build/docker/nsswitch.conf /etc/nsswitch.conf && \
     rm -r /tmp/gogs.tar.gz /tmp/gogs-extract
WORKDIR /app/gogs/build
RUN    ./docker/build-go.sh \
    && ./docker/build.sh \
    && ./docker/finalize.sh

EXPOSE 22 3000
ENTRYPOINT ["/app/gogs/docker/start.sh"]
CMD ["/bin/s6-svscan", "/app/gogs/docker/s6/"]
