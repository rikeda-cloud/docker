FROM debian:bullseye
ARG DOMAIN_NAME
ARG WORDPRESS_DB_NAME
ARG MARIADB_USER
ARG MARIADB_PASSWORD
ARG WORDPRESS_TITLE
ARG WORDPRESS_ADMIN_USER
ARG WORDPRESS_ADMIN_PASSWORD
ARG WORDPRESS_ADMIN_EMAIL
ARG WORDPRESS_NORMAL_USER
ARG WORDPRESS_NORMAL_PASSWORD
ARG WORDPRESS_NORMAL_EMAIL

RUN apt-get update && apt-get -y install \
	curl \
	gettext-base \
	php \
	php7.4-fpm \
	php-curl \
	php-mysql \
	php-mbstring \
	php-redis \
	systemd && \
	apt-get -y remove --purge apache2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# WordPress初期設定で使用するWP-CLIをインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# WP-CLIコマンドを用いたWordPress立ち上げ用のスクリプトの準備し、環境変数を置換
COPY ./tools/start_wordpress.sh /tmp/
RUN envsubst < /tmp/start_wordpress.sh > /usr/local/bin/start_wordpress.sh && \
	chmod +x /usr/local/bin/start_wordpress.sh

# Wordpressを日本語でダウンロード && 権限の付与
RUN mkdir -p /var/www/html/wordpress && \
	wp core download --path=/var/www/html/wordpress --locale=ja --allow-root && \
	chown -R www-data /var/www/html/wordpress && \
	chmod -R 777 /var/www/html/wordpress && \
	chown -R www-data /var/log/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/php7.4-fpm.service /etc/systemd/system/
RUN systemctl enable php7.4-fpm
ENTRYPOINT ["/bin/systemd"]
