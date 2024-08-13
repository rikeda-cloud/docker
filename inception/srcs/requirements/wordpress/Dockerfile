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
	php \
	php-fpm \
	php-curl \
	php-mysql \
	php-mbstring \
	php-redis \
	unzip \
	zip \
	systemd \
	systemd-sysv && \
	apt-get -y remove --purge apache2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# WordPress初期設定で使用するWP-CLIをインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# WP-CLIコマンドを用いたWordPress立ち上げ用のスクリプトの準備
COPY ./tools/start_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_wordpress.sh

# 設定ファイルをコピー
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# systemd起動時に環境変数を設定
RUN echo DefaultEnvironment=\
	"DOMAIN_NAME=${DOMAIN_NAME} \
	WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME} \
	MARIADB_USER=${MARIADB_USER} \
	MARIADB_PASSWORD=${MARIADB_PASSWORD} \
	WORDPRESS_TITLE=${WORDPRESS_TITLE} \
	WORDPRESS_ADMIN_USER=${WORDPRESS_ADMIN_USER} \
	WORDPRESS_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD} \
	WORDPRESS_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL} \
	WORDPRESS_NORMAL_USER=${WORDPRESS_NORMAL_USER} \
	WORDPRESS_NORMAL_PASSWORD=${WORDPRESS_NORMAL_PASSWORD} \
	WORDPRESS_NORMAL_EMAIL=${WORDPRESS_NORMAL_EMAIL}" >> /etc/systemd/system.conf

# start_wordpress.shでphp-fpmを起動するため自動起動させない設定
RUN systemctl disable php7.4-fpm

COPY ./conf/wordpress.service /etc/systemd/system/
RUN systemctl enable wordpress
ENTRYPOINT ["/bin/systemd"]
