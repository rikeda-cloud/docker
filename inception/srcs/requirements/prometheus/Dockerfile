FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	curl \
	prometheus \
	systemd \
	systemd-sysv

COPY ./conf/prometheus.service /etc/systemd/system/
COPY ./conf/prometheus.yml /etc/prometheus/

RUN systemctl enable prometheus

ENTRYPOINT ["/usr/lib/systemd/systemd"]
