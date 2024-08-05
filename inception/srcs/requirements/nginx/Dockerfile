FROM debian

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install bash nginx openssl curl systemd systemd-sysv

RUN mkdir /etc/nginx/certs
COPY ./conf/nginx.conf /etc/nginx/
COPY ./tools/server.crt /etc/nginx/certs/
COPY ./tools/server.key /etc/nginx/certs/

RUN systemctl enable nginx

ENTRYPOINT ["/usr/lib/systemd/systemd"]
