FROM alpine:latest

RUN apk update && \
	apk upgrade && \
	apk add bash nginx openssl

RUN mkdir /etc/nginx/certs
COPY ./conf/openssl.cnf /etc/nginx/certs/
COPY ./conf/nginx.conf /etc/nginx/
COPY ./tools/index.html /var/www/html/

# 秘密鍵の作成(オレオレ認証局とWebサーバ用)
RUN openssl genrsa -out /etc/nginx/certs/ca.key 2048
RUN openssl genrsa -out /etc/nginx/certs/server.key 2048
# CSR（証明書署名要求）の作成
RUN openssl req -new -key /etc/nginx/certs/server.key -out /etc/nginx/certs/server.csr -config /etc/nginx/certs/openssl.cnf
# CRT（証明書）の作成(オレオレ認証局とWebサーバ用)
# TODO 認証局用のopenssl.cnfを作成してもよいかも
RUN openssl req -new -x509 -days 365 -key /etc/nginx/certs/ca.key -out /etc/nginx/certs/ca.crt -subj "/C=JP/ST=Tokyo/L=Minato/O=Example/OU=IT/CN=Example CA"
RUN openssl x509 -req -days 365 -in /etc/nginx/certs/server.csr -CA /etc/nginx/certs/ca.crt -CAkey /etc/nginx/certs/ca.key -CAcreateserial -out /etc/nginx/certs/server.crt -extfile /etc/nginx/certs/openssl.cnf -extensions req_ext

ENTRYPOINT /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
