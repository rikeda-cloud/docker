FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	mariadb-server \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# mariadbの初期設定

RUN service mariadb start && \
	timeout 10s sh -c 'until mysqladmin ping -uroot --silent; do sleep 1; done' && \
	mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS wordpress;" && \
	mariadb -uroot -e "CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'wordpress';" && \
	mariadb -uroot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';" && \
	mariadb -uroot -e "FLUSH PRIVILEGES;" && \
	service mariadb stop

RUN systemctl enable mariadb
ENTRYPOINT ["/bin/systemd"]
