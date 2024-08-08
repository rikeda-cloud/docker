FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install \
	bash \
	dnsmasq \
	dnsutils \
	systemd \
	systemd-sysv

COPY ./conf/dnsmasq.conf /etc/dnsmasq.conf

RUN systemctl enable dnsmasq

ENTRYPOINT ["/usr/lib/systemd/systemd"]
