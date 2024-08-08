FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	curl \
	apt-transport-https \
	software-properties-common \
	systemd \
	systemd-sysv

RUN curl -fsSL https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list
RUN apt-get -y update && apt-get -y install grafana

RUN systemctl enable grafana-server

ENTRYPOINT ["/usr/lib/systemd/systemd"]
