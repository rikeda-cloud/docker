FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	apt-transport-https \
	curl \
	gpg \
	sqlite3 \
	systemd

ARG GRAFANA_ADMIN_USER \
	GRAFANA_ADMIN_PASSWORD

RUN for var in GRAFANA_ADMIN_USER \
	GRAFANA_ADMIN_PASSWORD; \
	do \
	if [ -z "$(eval echo \$$var)" ]; then \
	echo "$var is not set" && exit 1; \
	fi; \
	done

# grafanaをインストール
RUN mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null && \
	echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list && \
	apt-get update && \
	apt-get -y install grafana && \
	rm -rf /var/lib/apt/lists/*

# grafana立ち上げ時にdashboardを表示できるように設定ファイルを配置
COPY ./conf/dashboard.yml /etc/grafana/provisioning/dashboards/
COPY ./conf/datasource.yml /etc/grafana/provisioning/datasources/
COPY ./conf/nginx-prometheus-exporter.json /var/lib/grafana/dashboards/

# VM使用時にgrafanaコンテナの立ち上げ時のmigrationに時間がかかり過ぎる問題への解決策
# migration済みのDBファイルをコピーしてmigration工程をなくす
COPY ./conf/grafana.db /var/lib/grafana/
RUN chown grafana:grafana /var/lib/grafana/grafana.db && \
	chmod 660 /var/lib/grafana/grafana.db

RUN grafana-cli admin reset-admin-password ${GRAFANA_ADMIN_PASSWORD}
RUN sqlite3 /var/lib/grafana/grafana.db "UPDATE user SET login='${GRAFANA_ADMIN_USER}' WHERE login='admin';"

COPY ./conf/grafana-server.service /etc/systemd/system/
RUN systemctl enable grafana-server
ENTRYPOINT ["/bin/systemd"]
