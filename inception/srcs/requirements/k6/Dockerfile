FROM debian:bullseye

RUN apt-get update && apt-get -y install \
	curl \
	apt-transport-https \
	gnupg \
	systemd \
	systemd-sysv

# k6のインストール
RUN curl -s https://dl.k6.io/key.gpg | apt-key add - && \
	echo "deb https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list && \
	apt-get update && \
	apt-get -y install k6 && \
	rm -rf /var/lib/apt/lists/*

# 負荷テスト用のスクリプトを用意
RUN mkdir -p /etc/k6/scripts/
COPY ./tools/test.js /etc/k6/scripts/

COPY ./conf/k6.service /etc/systemd/system/
RUN systemctl enable k6
ENTRYPOINT ["/bin/systemd"]
