FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	ftp \
	gettext-base \
	vsftpd \
	systemd && \
	rm -rf /var/lib/apt/lists/*

ARG FTP_USER \
	FTP_PASSWORD \
	FTP_PASSIVE_ADDRESS

RUN for var in FTP_USER \
	FTP_PASSWORD \
	FTP_PASSIVE_ADDRESS; \
	do \
	if [ -z "$(eval echo \$$var)" ]; then \
	echo "$var is not set" && exit 1; \
	fi; \
	done

# FTP操作用のユーザーを作成
RUN mkdir -p /var/www/html && \
	useradd ${FTP_USER} -d /var/www/html && \
	echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd && \
	chmod -R 755 /var/www/html && \
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html

COPY ./conf/vsftpd.conf /tmp/
RUN envsubst < /tmp/vsftpd.conf > /etc/vsftpd.conf

# 自動起動するMTAをdisable
RUN systemctl disable exim4

COPY ./conf/vsftpd.service /etc/systemd/system/
RUN systemctl enable vsftpd
ENTRYPOINT ["/bin/systemd"]
