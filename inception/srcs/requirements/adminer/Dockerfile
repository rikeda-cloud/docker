FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	php \
	php-mysqli \
	php-xml \
	php-mbstring \
	php-zip \
	php-json \
	php-gd \
	systemd \
	systemd-sysv && \
	apt-get -y remove --purge apache2 && \
	apt-get -y autoremove

# adminerとadminerのドラキュラテーマをダウンロード
RUN mkdir -p /var/www/html/
WORKDIR /var/www/html/
RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o index.php
RUN curl -L https://raw.githubusercontent.com/vrana/adminer/master/designs/dracula/adminer.css -o adminer.css

COPY ./conf/adminer.service /etc/systemd/system/
RUN systemctl enable adminer
ENTRYPOINT ["/usr/lib/systemd/systemd"]
