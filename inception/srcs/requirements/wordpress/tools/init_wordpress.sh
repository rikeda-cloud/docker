#!/bin/bash

# 日本語でダウンロード
wp core download --path=/var/www/html/wordpress --locale=ja --allow-root

cd /var/www/html/wordpress

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

# WordPressのスキームの設定
wp theme activate twentytwentytwo --allow-root
