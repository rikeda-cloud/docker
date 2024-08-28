FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	curl \
	gettext-base \
	nginx \
	nginx-core \
	systemd && \
	rm -rf /var/lib/apt/lists/*

ARG WEB_SERVER_CERT_PATH \
	WEB_SERVER_KEY_PATH \
	DOMAIN_NAME \
	DOMAIN_NAME_BONUS

RUN for var in WEB_SERVER_CERT_PATH \
	WEB_SERVER_KEY_PATH \
	DOMAIN_NAME \
	DOMAIN_NAME_BONUS; \
	do \
	if [ -z "$(eval echo \$$var)" ]; then \
	echo "$var is not set" && exit 1; \
	fi; \
	done

RUN mkdir -p /etc/nginx/certs
COPY ${WEB_SERVER_CERT_PATH} ${WEB_SERVER_KEY_PATH} /etc/nginx/certs/

# 用意したnginx.confの環境変数を置換
COPY ./conf/nginx.conf /tmp/
RUN envsubst '$$DOMAIN_NAME $$DOMAIN_NAME_BONUS' < /tmp/nginx.conf > /etc/nginx/nginx.conf

RUN systemctl enable nginx

ENTRYPOINT ["/bin/systemd"]
