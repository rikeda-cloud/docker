FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add bash && \
	apk add nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /var/www/html/index.html
ENTRYPOINT /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
