FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	prometheus \
	systemd \
	systemd-sysv

COPY ./conf/prometheus.yml /etc/prometheus/

COPY ./conf/prometheus.service /etc/systemd/system/
RUN systemctl enable prometheus
ENTRYPOINT ["/usr/lib/systemd/systemd"]
