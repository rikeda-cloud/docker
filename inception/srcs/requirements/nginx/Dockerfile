FROM debian:bullseye
ARG WEB_SERVER_CERT_PATH
ARG WEB_SERVER_KEY_PATH
ARG DOMAIN_NAME
ARG DOMAIN_NAME_BONUS

RUN apt-get update && apt-get -y install \
	bash \
	curl \
	gettext-base \
	nginx \
	nginx-core \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs
COPY ${WEB_SERVER_CERT_PATH} ${WEB_SERVER_KEY_PATH} /etc/nginx/certs/

# 用意したnginx.confの環境変数を置換
COPY ./conf/nginx.conf /tmp/
RUN envsubst '$$DOMAIN_NAME $$DOMAIN_NAME_BONUS' < /tmp/nginx.conf > /etc/nginx/nginx.conf

RUN systemctl enable nginx

ENTRYPOINT ["/bin/systemd"]
