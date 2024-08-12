FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
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
	apt-get -y autoremove

RUN mkdir -p /var/www/html

# WordPress初期設定で使用するWP-CLIをインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# WP-CLIコマンドを用いたWordPress初期化用のスクリプト
COPY ./tools/init_wordpress.sh /root/
RUN chmod +x /root/init_wordpress.sh

# 日本語でダウンロード
RUN wp core download --path=/var/www/html/wordpress --locale=ja --allow-root
RUN chmod -R 777 /var/www/html/wordpress

# 設定ファイル等をコピー
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./conf/wp-cli-setup.service /etc/systemd/system/

RUN systemctl enable php8.2-fpm
RUN systemctl enable wp-cli-setup

ENTRYPOINT ["/usr/lib/systemd/systemd"]
