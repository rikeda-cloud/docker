FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	systemd \
	systemd-sysv \
	mariadb-server \
	mariadb-client

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306
RUN systemctl enable mariadb
ENTRYPOINT ["/usr/lib/systemd/systemd"]
