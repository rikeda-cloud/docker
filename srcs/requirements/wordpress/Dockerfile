FROM debian:bullseye

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

ARG DOMAIN_NAME \
	WORDPRESS_DB_NAME \
	MARIADB_USER \
	MARIADB_PASSWORD \
	WORDPRESS_TITLE \
	WORDPRESS_ADMIN_USER \
	WORDPRESS_ADMIN_PASSWORD \
	WORDPRESS_ADMIN_EMAIL \
	WORDPRESS_NORMAL_USER \
	WORDPRESS_NORMAL_PASSWORD \
	WORDPRESS_NORMAL_EMAIL

RUN for var in DOMAIN_NAME \
	WORDPRESS_DB_NAME \
	MARIADB_USER \
	MARIADB_PASSWORD \
	WORDPRESS_TITLE \
	WORDPRESS_ADMIN_USER \
	WORDPRESS_ADMIN_PASSWORD \
	WORDPRESS_ADMIN_EMAIL \
	WORDPRESS_NORMAL_USER \
	WORDPRESS_NORMAL_PASSWORD \
	WORDPRESS_NORMAL_EMAIL; \
	do \
	if [ -z "$(eval echo \$$var)" ]; then \
	echo "$var is not set" && exit 1; \
	fi; \
	done

# WordPress初期設定で使用するWP-CLIをインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Wordpressを日本語でダウンロード && 権限の付与
RUN mkdir -p /var/www/html/wordpress && \
	wp core download --path=/var/www/html/wordpress --locale=ja --allow-root && \
	chown -R www-data /var/www/html/wordpress && \
	chmod -R 777 /var/www/html/wordpress && \
	chown -R www-data /var/log/

# WP-CLIコマンドを用いたWordPress立ち上げ用のスクリプトの準備し、環境変数を置換
COPY ./tools/start_wordpress.sh /tmp/
RUN envsubst < /tmp/start_wordpress.sh > /usr/local/bin/start_wordpress.sh && \
	chmod +x /usr/local/bin/start_wordpress.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/php7.4-fpm.service /etc/systemd/system/
RUN systemctl enable php7.4-fpm
ENTRYPOINT ["/bin/systemd"]
