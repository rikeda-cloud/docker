#!/bin/bash

cd /var/www/html/wordpress

# Wordpressを日本語でダウンロード
mkdir -p /var/www/html && \
	wp core download --path=/var/www/html/wordpress --locale=ja --allow-root && \
	chmod -R 777 /var/www/html/wordpress

# configファイルの作成
wp core config \
	--dbname=wordpress \
	--dbuser=wordpress \
	--dbpass=wordpress \
	--dbhost=mariadb \
	--dbprefix=wp_ \
	--skip-check \
	--allow-root

# WordPressの初期化
wp core install \
	--url="https://rikeda.42.fr" \
	--title="rikeda-cloud" \
	--admin_user="rikeda" \
	--admin_password="rikeda-cloud" \
	--admin_email="longsichitian648@gmail.com" \
	--skip-email \
	--allow-root

# admin以外のuserを追加
wp user create nono nono@gmail.com --role=author --user_pass=password --display_name=NONO --allow-root

# WordPressのスキームの設定
wp theme activate twentytwentytwo --allow-root

# redis用の設定をconfigファイルに追記
wp config set WP_CACHE "true" --allow-root && \
	wp config set WP_REDIS_HOST "redis" --allow-root && \
	wp config set WP_REDIS_PORT "6379" --allow-root && \
	wp config set WP_REDIS_DATABASE "0" --allow-root

# redisプラグインをインストール
wp plugin install redis-cache --path=/var/www/html/wordpress --activate --allow-root
wp redis enable --path=/var/www/html/wordpress --allow-root

echo finish init wordpress

systemctl enable php7.4-fpm
systemctl start php7.4-fpm

echo start wordpress
