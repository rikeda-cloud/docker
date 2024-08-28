FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	mariadb-server \
	systemd && \
	rm -rf /var/lib/apt/lists/*

ARG WORDPRESS_DB_NAME \
	MARIADB_USER \
	MARIADB_PASSWORD \
	MARIADB_ROOT_PASSWORD

RUN for var in WORDPRESS_DB_NAME \
	MARIADB_USER \
	MARIADB_PASSWORD \
	MARIADB_ROOT_PASSWORD; \
	do \
	if [ -z "$(eval echo \$$var)" ]; then \
	echo "$var is not set" && exit 1; \
	fi; \
	done

# mariadbの初期設定
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN service mariadb start && \
	timeout 10s sh -c 'until mysqladmin ping -uroot --silent; do sleep 1; done' && \
	mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" && \
	mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};" && \
	mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';" && \
	mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${MARIADB_USER}'@'%';" && \
	mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
RUN service mariadb stop

RUN systemctl enable mariadb
ENTRYPOINT ["/bin/systemd"]
