FROM debian:oldstable

RUN apt-get update && apt-get -y install \
	curl \
	php \
	php-mysqli \
	php-xml \
	php-mbstring \
	php-zip \
	php-json \
	php-gd \
	systemd \
	systemd-sysv && \
	apt-get -y remove --purge apache2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

# adminerとadminerのドラキュラテーマをダウンロード
RUN mkdir -p /var/www/html/
WORKDIR /var/www/html/
RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o index.php && \
	curl -L https://raw.githubusercontent.com/vrana/adminer/master/designs/dracula/adminer.css -o adminer.css

COPY ./conf/adminer.service /etc/systemd/system/
RUN systemctl enable adminer
ENTRYPOINT ["/bin/systemd"]
