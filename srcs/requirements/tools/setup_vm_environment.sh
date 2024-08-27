#!/bin/bash

CA_KEY="ca.key"
CA_CRT="ca.crt"
CA_CONFIG="ca_openssl.cnf"

SERVER_KEY="server.key"
SERVER_CSR="server.csr"
SERVER_CRT="server.crt"
SERVER_CONFIG="server_openssl.cnf"

KEY_LENGTH="2048"
VALIDITY_DAYS="365"

# dataディレクトリの作成
mkdir -p ${HOME}/data/{mariadb,wordpress}

# 秘密鍵の作成
openssl genrsa -out ${CA_KEY} ${KEY_LENGTH}
openssl genrsa -out ${SERVER_KEY} ${KEY_LENGTH}

# 証明書署名要求の作成
openssl req -new -key ${SERVER_KEY} -out ${SERVER_CSR} -config ${SERVER_CONFIG}

# 証明書の作成
openssl req -new -x509 -days ${VALIDITY_DAYS} -key ${CA_KEY} -out ${CA_CRT} -config ${CA_CONFIG}
openssl x509 -req -days ${VALIDITY_DAYS} -in ${SERVER_CSR} -CA ${CA_CRT} -CAkey ${CA_KEY} -CAcreateserial -out ${SERVER_CRT} -extfile ${SERVER_CONFIG} -extensions req_ext

# 証明書をバックアップ
BACKUP_DIR=${HOME}/Backup/certs/
mkdir -p ${BACKUP_DIR}
cp ${CA_KEY} ${CA_CRT} ${SERVER_KEY} ${SERVER_CSR} ${SERVER_CRT} ${BACKUP_DIR}

# ホストに証明書を登録する
sudo cp ${SERVER_CRT} ${CA_CRT} /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust

# /etc/hostsファイル内に名前解決用のレコードを追記
echo "127.0.0.1 rikeda.42.fr" | sudo tee -a "/etc/hosts" >> /dev/null
echo "127.0.0.1 bonus.rikeda.42.fr" | sudo tee -a "/etc/hosts" >> /dev/null
