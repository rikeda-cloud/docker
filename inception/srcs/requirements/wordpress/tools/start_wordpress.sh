#!/bin/bash

cd /var/www/html/wordpress

# Wordpressを日本語でダウンロード
mkdir -p /var/www/html && \
	wp core download --path=/var/www/html/wordpress --locale=ja --allow-root && \
	chmod -R 777 /var/www/html/wordpress

export > /root/result_export.txt

# configファイルの作成
wp core config \
	--dbname=${WORDPRESS_DB_NAME} \
	--dbuser=${MARIADB_USER} \
	--dbpass=${MARIADB_PASSWORD} \
	--dbhost=mariadb \
	--dbprefix=wp_ \
	--skip-check \
	--allow-root

# WordPressの初期化
wp core install \
	--url=https://${DOMAIN_NAME} \
	--title=${WORDPRESS_TITLE} \
	--admin_user=${WORDPRESS_ADMIN_USER} \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
	--admin_email=${WORDPRESS_ADMIN_EMAIL} \
	--skip-email \
	--allow-root

# admin以外のuserを追加
wp user create ${WORDPRESS_NORMAL_USER} \
	${WORDPRESS_NORMAL_EMAIL} \
	--role=author \
	--user_pass=${WORDPRESS_NORMAL_PASSWORD} \
	--display_name=${WORDPRESS_NORMAL_USER} \
	--allow-root

# WordPressのスキームの設定
wp theme activate twentytwentytwo --allow-root

# redis用の設定をconfigファイルに追記
wp config set WP_CACHE "true" --allow-root && \
	wp config set WP_REDIS_HOST "redis" --allow-root && \
	wp config set WP_REDIS_PORT "6379" --allow-root && \
	wp config set WP_REDIS_DATABASE "0" --allow-root

# redisプラグインをインストール
wp plugin install redis-cache \
	--path=/var/www/html/wordpress \
	--activate \
	--allow-root
wp redis enable \
	--path=/var/www/html/wordpress \
	--allow-root

echo finish init wordpress

systemctl enable php7.4-fpm
systemctl start php7.4-fpm

echo start wordpress
