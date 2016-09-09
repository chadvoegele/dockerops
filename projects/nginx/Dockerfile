FROM nginx
RUN \
      apt-get update && \
      apt-get install -y openssl git
ARG DOMAIN
ARG GIT_DOMAIN
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY http.conf /etc/nginx/conf.d/http.conf
COPY projects_https.conf.template /tmp/nginx/projects_https.conf.template
COPY git_https.conf.template /tmp/nginx/git_https.conf.template
RUN \
      git clone https://github.com/chadvoegele/chadvoegele.github.io.git /usr/share/chadvoegele.github.io && \
      envsubst '${DOMAIN}' < /tmp/nginx/projects_https.conf.template > /etc/nginx/conf.d/projects_https.conf && \
      rm /tmp/nginx/projects_https.conf.template && \
      envsubst '${GIT_DOMAIN}' < /tmp/nginx/git_https.conf.template > /etc/nginx/conf.d/git_https.conf && \
      rm /tmp/nginx/git_https.conf.template && \
      mkdir -p /etc/nginx/ssl && \
      openssl dhparam -dsaparam -out /etc/nginx/ssl/dhparam.pem 4096
