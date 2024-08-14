FROM debian:bullseye
ARG FTP_USER
ARG FTP_PASSWORD

RUN apt-get update && apt-get -y install \
	ftp \
	vsftpd \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

# FTP操作用のユーザーを作成
RUN mkdir -p /var/www/html && \
	useradd ${FTP_USER} -d /var/www/html && \
	echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd && \
	chmod -R 755 /var/www/html && \
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html

COPY ./conf/vsftpd.conf /etc/

RUN systemctl enable vsftpd
ENTRYPOINT ["/bin/systemd"]
