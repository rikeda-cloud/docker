FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	ftp \
	gettext-base \
	vsftpd \
	systemd && \
	rm -rf /var/lib/apt/lists/*

# FTP操作用のユーザーを作成
ARG FTP_USER
ARG FTP_PASSWORD
RUN mkdir -p /var/www/html && \
	useradd ${FTP_USER} -d /var/www/html && \
	echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd && \
	chmod -R 755 /var/www/html && \
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html

ARG FTP_PASSIVE_ADDRESS
COPY ./conf/vsftpd.conf /tmp/
RUN envsubst < /tmp/vsftpd.conf > /etc/vsftpd.conf

# 自動起動するMTAをdisable
RUN systemctl disable exim4

RUN systemctl enable vsftpd
ENTRYPOINT ["/bin/systemd"]
