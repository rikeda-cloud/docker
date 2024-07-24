FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install bash systemd systemd-sysv mariadb-server mariadb-client

RUN systemctl enable mariadb
ENTRYPOINT ["/usr/lib/systemd/systemd"]
