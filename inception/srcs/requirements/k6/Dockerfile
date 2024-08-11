FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	apt-transport-https \
	software-properties-common \
	systemd \
	systemd-sysv

# k6のインストール
RUN gpg -k && \
	gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69 && \
	echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list && \
	apt-get update && \
	apt-get install k6

# 負荷テスト用のスクリプトを用意
RUN mkdir -p /etc/k6/scripts/
COPY ./tools/test.js /etc/k6/scripts/

COPY ./conf/k6.service /etc/systemd/system/
RUN systemctl enable k6
ENTRYPOINT ["/usr/lib/systemd/systemd"]
