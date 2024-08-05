FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	curl \
	redis \
	systemd \
	systemd-sysv

RUN systemctl enable redis-server

RUN sed -i 's/bind 127.0.0.1 -::1/bind 0.0.0.0 ::0/' /etc/redis/redis.conf
RUN sed -i 's/protected-mode yes/protected-mode no/' /etc/redis/redis.conf

ENTRYPOINT ["/usr/lib/systemd/systemd"]
