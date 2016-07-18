FROM localhost:5000/gogs
RUN \
    sed -i 's/export USER=git/export USER=root/' /app/gogs/docker/s6/gogs/run && \
    sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /app/gogs/docker/sshd_config && \
    sed -i 's/AllowUsers git/AllowUsers root/' /app/gogs/docker/sshd_config
