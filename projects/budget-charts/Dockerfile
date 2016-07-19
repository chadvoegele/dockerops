FROM localhost:5000/budget-charts
RUN \
      apt-get update && \
      apt-get install -y nginx gettext-base openssl
ARG DOMAIN
COPY nginx.conf /etc/nginx/nginx.conf
COPY https.conf.template /tmp/nginx/https.conf.template
RUN envsubst '${DOMAIN}' < /tmp/nginx/https.conf.template > /etc/nginx/conf.d/https.conf
RUN rm /tmp/nginx/https.conf.template
RUN \
      ln -sf /dev/stdout /var/log/nginx/access.log && \
      ln -sf /dev/stderr /var/log/nginx/error.log && \
      mkdir -p /etc/nginx/ssl && \
      openssl dhparam -dsaparam -out /etc/nginx/ssl/dhparam.pem 4096
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
