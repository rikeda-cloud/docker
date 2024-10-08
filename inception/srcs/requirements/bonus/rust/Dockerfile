# ビルドステージ
FROM debian:bullseye AS build

RUN apt-get update && apt-get -y install \
	build-essential \
	cmake \
	curl \
	gcc

# Rustをインストール
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Rustでビルド
COPY ./tools/rust-server/ /usr/src/rust-server
WORKDIR /usr/src/rust-server
RUN /root/.cargo/bin/cargo build --release

# 本番用ステージ
FROM debian:bullseye AS production

RUN apt-get update && apt-get -y install \
	curl \
	systemd && \
	rm -rf /var/lib/apt/lists/*

# ビルドステージでビルドしたバイナリをCOPY
COPY --from=build /usr/src/rust-server/target/release/rust-server /usr/local/bin

RUN useradd --no-create-home --shell /bin/false rust-server
COPY ./conf/rust-server.service /etc/systemd/system/
RUN systemctl enable rust-server
ENTRYPOINT ["/bin/systemd"]
