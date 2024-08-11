FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	systemd \
	systemd-sysv

# アーキテクチャに合わせてnginx-prometheus-exporterをダウンロード
RUN if [ "$(uname -m)" = "aarch64" ]; then \
	curl -L -o exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_arm64.tar.gz; \
	else \
	curl -L -o exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz; \
	fi && \
	tar -xzf exporter.tar.gz && \
	mv nginx-prometheus-exporter /usr/bin/nginx-prometheus-exporter && \
	rm exporter.tar.gz

COPY ./conf/exporter.service /etc/systemd/system/
RUN systemctl enable exporter
ENTRYPOINT ["/usr/lib/systemd/systemd"]
