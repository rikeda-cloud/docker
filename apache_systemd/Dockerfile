# docker build -f ./Dockerfile -t apav2 .
# docker run -itd --tmpfs /tmp --tmpfs /run --privileged --stop-signal SIGRTMIN+3 --name web0001 -h web0001 -p 8081:80 apav2 /usr/lib/systemd/systemd
FROM debian

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apache2 iproute2 systemd systemd-sysv
RUN echo "Hello Container!" > /var/www/html/index.html
RUN systemctl enable apache2
