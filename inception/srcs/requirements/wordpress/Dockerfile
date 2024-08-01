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

RUN wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	rm latest.zip && \
	mv wordpress /var/www/html && \
	chown -R www-data:www-data /var/www/html/wordpress

RUN mkdir -p /run/php && \
	chown -R www-data:www-data /run/php

WORKDIR /var/www/html/wordpress/
COPY ./conf/wp-config.php /var/www/html/wordpress/
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
EXPOSE 9000
# COPY ./conf/php-fpm.service /etc/systemd/system/php-fpm.service
# RUN systemctl enable php-fpm
# ENTRYPOINT ["/usr/lib/systemd/systemd"]
ENTRYPOINT ["php-fpm8.2", "-F"]
# ENTRYPOINT ["php", "-S", "0.0.0.0:9000"]
