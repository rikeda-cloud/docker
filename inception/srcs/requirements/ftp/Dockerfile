FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	telnet \
	vsftpd \
	systemd \
	systemd-sysv

COPY ./conf/vsftpd.conf /etc/
RUN mkdir -p /var/www/html

# FTP操作用のユーザーとなるftpuserを作成
RUN useradd ftpuser -d /var/www/html
RUN echo "ftpuser:ftpuser_password" | chpasswd
RUN chmod -R 755 /var/www/html
RUN chown -R ftpuser:ftpuser /var/www/html

RUN systemctl enable vsftpd
ENTRYPOINT ["/usr/lib/systemd/systemd"]
