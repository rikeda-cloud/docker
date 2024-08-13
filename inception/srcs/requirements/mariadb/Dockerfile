FROM debian:bullseye
ARG WORDPRESS_DB_NAME
ARG MARIADB_USER
ARG MARIADB_PASSWORD

RUN apt-get update && apt-get -y install \
	mariadb-server \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# mariadbの初期設定

RUN service mariadb start && \
	timeout 10s sh -c 'until mysqladmin ping -uroot --silent; do sleep 1; done' && \
	mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};" && \
	mariadb -uroot -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';" && \
	mariadb -uroot -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${MARIADB_USER}'@'%';" && \
	mariadb -uroot -e "FLUSH PRIVILEGES;" && \
	service mariadb stop

RUN systemctl enable mariadb
ENTRYPOINT ["/bin/systemd"]
