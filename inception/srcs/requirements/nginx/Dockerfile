FROM debian:bullseye
ARG WEB_SERVER_CERT_PATH
ARG WEB_SERVER_KEY_PATH
ARG DOMAIN_NAME

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

# systemd起動時に環境変数を設定
RUN echo DefaultEnvironment="DOMAIN_NAME=${DOMAIN_NAME}" >> /etc/systemd/system.conf

RUN systemctl enable nginx

ENTRYPOINT ["/bin/systemd"]
