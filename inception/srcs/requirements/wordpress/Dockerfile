FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	php \
	php-cgi \
	php-cli \
	php-fpm \
	php-curl \
	php-gd \
	php-mysql \
	php-mbstring \
	zip \
	unzip \
	wget \
	systemd \
	systemd-sysv

# WordPressをダウンロード
RUN wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	mv wordpress/* /var/www/html && \
	rm latest.zip && \
	rm -r wordpress && \
	chown -R www-data:www-data /var/www/html

RUN mkdir -p /run/php && \
	chown -R www-data:www-data /run/php

COPY ./conf/wp-config.php /var/www/html/
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./conf/php-fpm.service /etc/systemd/system/php-fpm.service

RUN systemctl enable php-fpm
EXPOSE 9000
ENTRYPOINT ["/usr/lib/systemd/systemd"]
