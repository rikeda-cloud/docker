FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	curl \
	build-essential \
	gcc \
	cmake \
	systemd \
	systemd-sysv

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR /usr/src/rust
RUN mkdir src
COPY ./conf/Cargo.toml ./
COPY ./tools/main.rs ./src/
RUN /root/.cargo/bin/cargo build --release

COPY ./conf/rust-app.service /etc/systemd/system/rust-app.service
RUN systemctl enable rust-app
ENTRYPOINT ["/usr/lib/systemd/systemd"]
