FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	curl \
	prometheus \
	systemd && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/prometheus.yml /etc/prometheus/

COPY ./conf/prometheus.service /etc/systemd/system/
RUN systemctl enable prometheus
ENTRYPOINT ["/bin/systemd"]
