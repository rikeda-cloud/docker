FROM debian:bullseye
ARG WEB_SERVER_CERT_PATH
ARG WEB_SERVER_KEY_PATH

RUN apt-get update && apt-get -y install \
	bash \
	curl \
	nginx \
	nginx-core \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs
COPY ./conf/nginx.conf /etc/nginx/
COPY ${WEB_SERVER_CERT_PATH} ${WEB_SERVER_KEY_PATH} /etc/nginx/certs/

RUN systemctl enable nginx

ENTRYPOINT ["/bin/systemd"]
