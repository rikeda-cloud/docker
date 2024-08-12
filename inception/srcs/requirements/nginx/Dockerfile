FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	bash \
	nginx \
	nginx-core \
	curl \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/nginx/certs
COPY ./conf/nginx.conf /etc/nginx/
COPY ./tools/server.crt /etc/nginx/certs/
COPY ./tools/server.key /etc/nginx/certs/

RUN systemctl enable nginx

ENTRYPOINT ["/bin/systemd"]
