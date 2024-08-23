#!/bin/bash

# 秘密鍵の作成
openssl genrsa -out ./ca.key 2048
openssl genrsa -out ./server.key 2048

# 証明書署名要求の作成
openssl req -new -key ./server.key -out ./server.csr -config ./openssl.cnf

# 証明書の作成
openssl req -new -x509 -days 365 -key ./ca.key -out ./ca.crt -subj "/C=JP/ST=Tokyo/L=Minato/O=Example/OU=IT/CN=Example CA"
openssl x509 -req -days 365 -in ./server.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out ./server.crt -extfile ./openssl.cnf -extensions req_ext

# dataディレクトリの作成
mkdir -p ${HOME}/data/{mariadb,wordpress}

# ホストに証明書を登録する
# sudo cp ./server.crt ./ca.crt /etc/pki/ca-trust/source/anchors/
# sudo update-ca-trust
## sudo echo "127.0.0.1 登録したいドメイン名" >> /etc/hosts
