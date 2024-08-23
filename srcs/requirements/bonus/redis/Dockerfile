FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	curl \
	redis \
	systemd && \
	rm -rf /var/lib/apt/lists/*

# 外部からの接続を可能にする設定を付与
RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0 ::0/' /etc/redis/redis.conf && \
	sed -i 's/protected-mode yes/protected-mode no/' /etc/redis/redis.conf

RUN systemctl enable redis-server
ENTRYPOINT ["/bin/systemd"]
