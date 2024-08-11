FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	apt-transport-https \
	software-properties-common \
	systemd \
	systemd-sysv

# grafanaをインストール
RUN curl -fsSL https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null && \
	echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list && \
	apt-get -y update && \
	apt-get -y install grafana

# grafana立ち上げ時にdashboardを表示できるように設定ファイルを配置
COPY ./conf/dashboard.yml /etc/grafana/provisioning/dashboards/
COPY ./conf/datasource.yml /etc/grafana/provisioning/datasources/
COPY ./conf/nginx-prometheus-exporter.json /var/lib/grafana/dashboards/

RUN systemctl enable grafana-server
ENTRYPOINT ["/usr/lib/systemd/systemd"]
