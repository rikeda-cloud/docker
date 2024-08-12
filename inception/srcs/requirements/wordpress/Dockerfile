FROM debian:bullseye

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
COPY ./tools/start_wordpress.sh /root/
RUN chmod +x /root/start_wordpress.sh

# 設定ファイル等をコピー
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./conf/wordpress.service /etc/systemd/system/
RUN systemctl disable php7.4-fpm
RUN systemctl enable wordpress
ENTRYPOINT ["/bin/systemd"]
