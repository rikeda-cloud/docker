# ビルドステージ
FROM debian AS build

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	build-essential \
	gcc \
	cmake

# Rustをインストール
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Rustでビルド
RUN mkdir -p /usr/src/rust-server/src/
WORKDIR /usr/src/rust-server
COPY ./conf/Cargo.toml ./
COPY ./tools/main.rs ./src/
RUN /root/.cargo/bin/cargo build --release

# 本番用ステージ
FROM debian AS production

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	curl \
	systemd \
	systemd-sysv

# ビルドステージでビルドしたバイナリをCOPY
COPY --from=build /usr/src/rust-server/target/release/rust-server /usr/local/bin

COPY ./conf/rust-server.service /etc/systemd/system/
RUN systemctl enable rust-server
ENTRYPOINT ["/usr/lib/systemd/systemd"]
