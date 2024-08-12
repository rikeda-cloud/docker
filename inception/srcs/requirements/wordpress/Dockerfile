FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	php \
	php-fpm \
	php-curl \
	php-mysql \
	php-mbstring \
	php-redis \
	zip \
	unzip \
	curl \
	systemd \
	systemd-sysv && \
	apt-get -y remove --purge apache2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# WordPress初期設定で使用するWP-CLIをインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# WP-CLIコマンドを用いたWordPress初期化用のスクリプト
COPY ./tools/init_wordpress.sh /root/
RUN chmod +x /root/init_wordpress.sh

# 日本語でダウンロード
RUN mkdir -p /var/www/html && \
	wp core download --path=/var/www/html/wordpress --locale=ja --allow-root && \
	chmod -R 777 /var/www/html/wordpress

# configファイルの作成
WORKDIR /var/www/html/wordpress
RUN wp core config \
	--dbname=wordpress \
	--dbuser=wordpress \
	--dbpass=wordpress \
	--dbhost=mariadb \
	--dbprefix=wp_ \
	--skip-check \
	--allow-root

# redis用の設定をconfigファイルに追記
RUN wp config set WP_CACHE "true" --allow-root && \
	wp config set WP_REDIS_HOST "redis" --allow-root && \
	wp config set WP_REDIS_PORT "6379" --allow-root && \
	wp config set WP_REDIS_DATABASE "0" --allow-root

# 設定ファイル等をコピー
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-cli-setup.service /etc/systemd/system/

RUN systemctl enable php7.4-fpm
RUN systemctl enable wp-cli-setup

ENTRYPOINT ["/bin/systemd"]
