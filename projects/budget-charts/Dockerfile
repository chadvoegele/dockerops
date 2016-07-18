FROM ubuntu:xenial
RUN \
      apt-get update && \
      apt-get install -y npm closure-compiler nginx git nginx gettext-base openssl
ARG DOMAIN
COPY nginx.conf /etc/nginx/nginx.conf
COPY https.conf.template /tmp/nginx/https.conf.template
RUN envsubst '${DOMAIN}' < /tmp/nginx/https.conf.template > /etc/nginx/conf.d/https.conf
RUN rm /tmp/nginx/https.conf.template
WORKDIR /usr/share
RUN \
      git clone https://github.com/chadvoegele/budget-charts.git && \
      cd budget-charts && \
      npm install && \
      mkdir /usr/share/java/closure-compiler && \
      ln -s /usr/share/java/closure-compiler-v20130227.jar /usr/share/java/closure-compiler/closure-compiler.jar && \
      nodejs node_modules/grunt/bin/grunt build && \
      ln -sf /dev/stdout /var/log/nginx/access.log && \
      ln -sf /dev/stderr /var/log/nginx/error.log && \
      mkdir -p /etc/nginx/ssl && \
      openssl dhparam -dsaparam -out /etc/nginx/ssl/dhparam.pem 4096
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
