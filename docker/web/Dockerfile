FROM nginx:1.16.1
USER root
RUN rm -f /etc/nginx/conf.d/*
COPY nginx.conf /etc/nginx/conf.d/app.conf
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
