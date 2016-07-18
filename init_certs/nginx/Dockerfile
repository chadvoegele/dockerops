FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY http.conf /etc/nginx/conf.d/
