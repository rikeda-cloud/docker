#!/bin/bash

cd /var/www/html/wordpress

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

# redisプラグインをインストール
wp redis enable --path=/var/www/html/wordpress --allow-root
wp plugin install redis-cache --path=/var/www/html/wordpress --activate --allow-root

# userを追加
wp user create nono nono@gmail.com --role=author --user_pass=password --display_name=NONO
