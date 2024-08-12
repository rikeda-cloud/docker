FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	ftp \
	vsftpd \
	systemd \
	systemd-sysv && \
	rm -rf /var/lib/apt/lists/*

# FTP操作用のユーザーとなるftpuserを作成
RUN mkdir -p /var/www/html && \
	useradd ftpuser -d /var/www/html && \
	echo "ftpuser:ftpuser_password" | chpasswd && \
	chmod -R 755 /var/www/html && \
	chown -R ftpuser:ftpuser /var/www/html

COPY ./conf/vsftpd.conf /etc/

RUN systemctl enable vsftpd
ENTRYPOINT ["/bin/systemd"]
