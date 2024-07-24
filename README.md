# Docker

## 用途
* サーバの環境を隔離するため
* ソフトウェア１とソフトウェア２が共通して使用するソフトウェア３のバージョンをソフトウェア１の都合で変更したい場合に<br>
ソフトウェア２ではバージョンの変更により上手く動作しなくなる可能性がある。<br>
そのような時に環境単位で隔離できれば自分の環境を自由に使用可能できるようにするため
* 開発を行う際にプロジェクトメンバ全員に同じ環境を用意するため

## 利点
* pythonのライブラリを環境毎に別々のバージョンを使用可能<br>(venvでも同じことが可能だが、venvの場合はpythonの環境のみを対象とし、dockerの場合はサーバの環境全体を対象とする)
* 一台のサーバマシンに同じソフトウェアを複数作成して稼働させることが可能
* 複数のプロジェクトで１台の物理サーバを使用でき、コスト・リスクを減らせる<br>(プロジェクトAとBを同じマシン上で進行する場合にプロジェクトAのメンバがプロジェクトBの環境を触ってしますリスクがある)
* Dockerさえあれば同じ環境を使用できるので物理的な環境の違いやサーバ構成の違いを無視できる
* コンテナの移動が簡単(移動先のホストにDockerEngineをインストールし、元のホストで運用していたコンテナのイメージを使ってコンテナを起動すれば良い)
* カーネルはコンテナ外のLinuxOSのものを使用するので他の仮想化技術に比べて軽い
* 開発環境と本番環境の違いを吸収できる
* 複数のLinuxディストリビューションを使用できる(あくまでもLinuxに限られる)

## ホスト-コンテナ間のファイルコピー
```
ホスト　-> コンテナ
docker run --name app1 -d -p 8086:80 httpd
touch index.html && echo "Hello World!" > index.html
docker container cp index.html app1:/usr/local/apache2/htdocs/

コンテナ -> ホスト
docker cp app1:/usr/local/apache2/htdocs/index.html ./index.html
```

## ENTRYPOINTとCMD命令
* ENTRYPOINT命令はコンテナ起動時にコマンドを実行
* CMD命令はENTRYPOINT命令と組み合わせて使用可能。dockerコマンド実行時に上書き可能。
* 両コマンドともに下記の記法がある
```
ENTRYPOINT ["/bin/bash"] // bashコマンドを直接実行
ENTRYPOINT /bin/bash // bashコマンドをシェルで実行

CMD ["/bin/bash"] // bashコマンドを直接実行
CMD /bin/bash // bashコマンドをシェルで実行
CMD ["-c", "tmux"] // ENTRYPOINTの引数として使用
```

## ONBUILD命令
1. サーバ管理者がベースとなるイメージを作成し、その中でONBUILD命令を用いてアプリ開発者に実行してほしい処理をもとに記述しておく
2. ベースのイメージをビルドする際にはONBUILD命令は動かない
3. ベースイメージから派生したイメージをビルドする際にベースイメージのONBUILD命令が動く。このため、COPY命令などでアプリ開発者が開発したプログラムを派生イメージのビルド段階でCOPY可能

## マルチステージビルド
```
FROM rockylinux:9.0 AS image1
...いろいろな処理後、実行バイナリを作成
FROM rockylinux:9.0 AS images // 同じイメージを使用することで環境の差をなくす
COPY --from=image1 /path/to/実行バイナリ /path/to/実行バイナリ
CMD ["/path/to/実行バイナリ"]
```
* 上記のように１つのDockerfile内で複数のFROM命令を用いてビルドする。
* 実行バイナリのみが含まれたイメージを複数Dockerfileを使用せずに作成可能

## .dockerignoreファイル
* プロジェクトのルートにある.dockerignoreファイルのみが有効
* ビルド時にプロジェクトのルート以下のファイル群はすべてtarでまとめられ、dockerデーモンに転送される。tarファイル内のCOPYやADDされないファイルもdockerデーモン内に転送される
* イメージのサイズ削減が期待できる

## systemdを使用可能なコンテナの作成
systemdをコンテナ内で使用するための条件として
1. /tmpディレクトリがtmpfsとしてマウントされていること
2. /runディレクトリがtmpfsとしてマウントされていること
3. Dockerホストの全デバイスにアクセス可能な権限を所有していること
これらの条件を満たすために
1. `--tmpfs /tmp --tmpfs /run`
2. `--privileged`(コンテナ起動時に子のオプションを付与するとコンテナは特権モードで実行される。ホストOSのハードウェア資源への無制限のアクセスが可能になる)
この2つのオプションを付与してDockerコンテナを起動するとsystemdを動かすことが可能になる

## マウント
* ホスト側のディレクトリをコンテナ内のディレクトリとしてマウントする
```
mkdir dir
docker run --name app1 -d -p 8087:80 -v ./dir:/usr/local/apache2/htdocs httpd
```
* ボリュームを作成してコンテナでそのボリュームをマウントする
```
docker volume create abc
docker run --name app2 -d -p 8080:80 -v abc:/usr/local/apache2/htdocs httpd
```
* mountオプションを用いた、より詳細なマウント
```
// bind mount 読み書き可能
docker run --name app3 -d -p 8081:80 --mount type=bind,src=$HOME/testdir,dst=/root/testdir httpd
// bind mount 書き込み不可
docker run --name app3 -d -p 8081:80 --mount type=bind,src=$HOME/testdir,dst=/root/testdir,readonly httpd
// volume mount 読み書き可能
docker run --name app3 -d -p 8081:80 --mount type=volume,src=vol01,dst=/root/testdir httpd
// volume mount 書き込み不可
docker run --name app3 -d -p 8081:80 --mount type=volume,src=vol01,dst=/root/testdir,readonly httpd
// tmpfs mount
docker run --name app3 -d -p 8081:80 --mount type=tmpfs,dst=/root/testdir,dst=/datadir,tmpfs-mode=1770,tmpfs-size=42949672960 httpd
```

## Docker内でコマンドを実行する
```
docker exec -it apa /bin/bash

// Apache自体は起動しない
docker run --name apa2 -it -p 8080:80 httpd /bin/bash
```

## 簡単なWebサーバの立ち上げから削除まで(一連の操作は`docker run --name WEBSERVER -d -p 8080:80 httpd`で置き換え可能)
1. `docker image pull httpd` イメージをダウンロードする
2. `docker container create --name WEBSERVER -p 8080:80 httpd` イメージからコンテナを作成する
3. `docker container start WEBSERVER` コンテナをバックグラウンドで立ち上げ、ホストから8080ポートで接続可能にする

## Dockerfile
### Dockerfileコマンド一覧
|コマンド|説明|備考|
|:--:|:--:|:--:|
|FROM|コンテナの元にするイメージを指定する||
|COPY|イメージにファイルやディレクトリを追加する|シンプルにファイルをコピーする|
|RUN|イメージをビルドする時にコマンドを実行する||
|ADD|イメージにファイルやディレクトリを追加する|圧縮ファイルは展開してコピーする。リモート上のリソースもpullする|
|CMD|コンテナを起動する時に実行する規定のコマンドを指定する|`docker run`の引数で上書き可能|
|ENTRYPOINT|イメージを実行するときのコマンドを強要する|`docker run`の引数での上書きが基本的に不可|
|ONBUILD|ビルドが完了した際に任意の命令を実行する||
|EXPOSE|コンテナ側のポートを指定する||
|VOLUME|コンテナとホスト間のボリュームについて指定||
|ENV|環境変数を定義||
|WORKDIR|作業ディレクトリの絶対パスを指定||
|SHELL|ビルド時のシェルを指定。指定後、次のSHELL命令があるまで指定されたシェルで命令が実行される。デフォルトはsh||
|LABEL|名前、バージョン番号、製作者等の情報を記述||
|USER|コマンドを実行するユーザーやグループを指定||
|ARG|`docker build`する際に指定できる引数を宣言||
|STOPSIGNAL|`docker stop`する際にコンテナで実行しているプログラムに対して送信するシグナルを変更する||
|HEALTHCHECK|コンテナの死活監視をする方法をカスタマイズ||

## DockerCompose

### docker-composeの使い方
* `docker compose {-f /path/to/docker-compose.yml} up {オプション}` docker-compose.ymlに記述された内容でコンテナを立ち上げる<br>(fオプション無しの場合、カレントディレクトリのdocker-compose.ymlファイルが使用される)

|名前|説明|
|:--:|:--:|
|`-d`|バックグランド実行|
|`--no-color`|白黒画面で表示|
|`--no-deps`|リンクしたサービスを表示しない|
|`--force-recreate`|設定やイメージに変更がなくても、コンテナを再生成する|
|`--no-build`|イメージが見つからなくてもビルドしない|
|`--build`|コンテナを開始前にイメージをビルドする|
|`--abort-on-container-exit`|コンテナが１つでも停止したら全てのコンテナを停止|
|`-t`|コンテナを停止する時のタイムアウト秒数|
|`--remove-orphans`|定義ファイルで定義されていないサービス用のコンテナ削除|
|`--scale`|コンテナの数を変える|

* `docker compose {-f /path/to/docker-compose.yml} down {オプション}`<br>docker-compose.ymlに記述された内容でコンテナとネットワークを停止・削除。ボリュームとイメージは削除しない。

|名前|説明|
|:--:|:--:|
|`--rmi`|削除時にイメージも削除する|
|`-v`|削除時にボリュームも削除する|
|`--remove-orphans`|定義ファイルで定義していないサービスのコンテナも削除|

* `docker compose {-f /path/to/docker-compose.yml} stop {オプション}`<br>docker-compose.ymlに記述された内容でコンテナを停止

### docker composeのコマンド一覧

|名前|説明|
|:--:|:--:|
|up|コンテナを作成、起動する|
|down|コンテナとネットワーク停止および削除|
|ps|コンテナ一覧を表示|
|config|定義ファイルの確認と表示|
|port|ポートの割り当てを表示|
|logs|コンテナの出力を表示|
|start|コンテナを開始|
|stop|コンテナを停止|
|kill|コンテナを強制停止|
|exec|コマンドを実行|
|run|コンテナを実行|
|create|コンテナを作成|
|restart|コンテナを再起動|
|pause|コンテナを一時停止|
|unpause|コンテナを再開|
|rm|停止中のコンテナを削除|
|build|コンテナ用のイメージを構築または再構築|
|pull|コンテナ用のイメージをダウンロード|
|events|コンテナからリアルタイムにイベントを受信|
|help|help|

### docker-compose.yml

大項目
|名前|説明|
|:--:|:--:|
|services|コンテナ関連の定義|
|networks|ネットワーク関連の定義|
|volumes|ボリューム関連の定義|

定義
|名前|説明|備考|
|:--:|:--:|:--:|
|image|利用するイメージを指定||
|networks|接続するネットワークを指定|--net|
|volumes|マウントを設定|-v|
|ports|ポートのマッピングを設定|-p|
|environment|環境変数を設定|-e|
|depends_on|別のサービスに依存することを明示||
|restart|コンテナが停止した時の挙動を設定||
|command|起動時の規定のコマンドを上書き|コマンド引数|
|container_name|起動するコンテナ名を明示的に指定|--name|
|dns|カスタムDNSサーバを明示的に設定|--dns|
|env_file|環境設定情報を書いたファイルを読み込む||
|entrypoint|起動時のENTRYPOINTを上書き|--entrypoint|
|external_links|外部リンクを設定|--link|
|extra_hosts|外部ホストのIPアドレスを明示的に設定|--add-host|
|logging|ログ出力先を設定|--log-driver|
|network_mode|ネットワークモードを設定|--network|

restart
|名前|説明|
|:--:|:--:|
|no|何もしない|
|always|必ず再起動する|
|on-failure|プロセスが０以外のステータスで終了した際に再起動する|
|unless-stopped|停止していた時は再起動せず、それ以外は再起動する|


## LinuxOSでの操作方法

システム関連
|コマンド|説明|
|:--:|:--:|
|`sudo systemctl start docker`|DockerEngineの起動|
|`sudo systemctl stop docker`|DockerEngineの終了|
|`sudo systemctl enable docker`|DockerEngineの自動起動設定|
|`docker version`|Dockerの情報を表示する|
|`docker login`|Dockerレジストリにログインする|
|`docker logout`|Dockerレジストリからログアウトする|
|`docker search`|Dockerレジストリで検索する|
|`docker stats`|Dockerのリソース使用状況を表示|

コンテナ関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`docker container run`|Imageを用いてコンテナを実行| `docker image pull`<br>`docker container create`<br>`docker container start`<br>の一連の操作をまとめたもの|
|`docker container start`|イメージをコンテナとして開始する||
|`docker container stop`|コンテナを停止する||
|`docker container create`|Dockerイメージからコンテナを作成する||
|`docker container rm`|停止したコンテナを削除する|`docker container rm -f` 強制削除|
|`docker container exec`|実行中のコンテナ内でプログラムを実行する||
|`docker container ls`|コンテナ一覧を表示|`docker ps`と同じ<br>`docker ps -a`|
|`docker container cp`|コンテナとホスト間でファイルをコピー||
|`docker container commit`|コンテナをイメージに変換する||
|`docker container attach`|バックグラウンドで稼働しているコンテナ内に入る||

イメージ関連
|コマンド|説明||
|:--:|:--:|:--:|
|`docker image pull`|イメージをダウンロード||
|`docker image rm`|イメージを削除する|`docker image rm -f` 強制削除|
|`docker image ls`|ダウンロードしたイメージ一覧を表示する|`docker images`|
|`docker image build`|Dockerイメージを作成する||

ボリューム関連
|コマンド|説明|
|:--:|:--:|
|`docker volume create`|ボリュームを作成する|
|`docker volume inspect`|ボリュームの詳細情報を表示する|
|`docker volume prune`|現在マウントされていないボリュームを全て削除する|
|`docker volume rm`|ボリュームの削除|

ネットワーク関連
|コマンド|説明|
|:--:|:--:|
|`docker network connect`|コンテナをネットワークに接続する|
|`docker network disconnect`|コンテナをネットワークから切断する|
|`docker network create`|ネットワークを作成する|
|`docker network inspect`|ネットワークの詳細を表示する|
|`docker network ls`|ネットワークの一覧を表示する|
|`docker network prune`|現在コンテナに接続されていないネットワークを全て削除する|
|`docker network rm`|ネットワークを削除する|

オプション
|オプション|説明|備考|
|:--:|:--:|:--:|
|`-d`|バックグラウンドで起動|`--detach`|
|`-i`|コンテナにキーボードを接続する|`--interactive`|
|`-t`|特殊キーを使用可能にする|`--tty`|
|`--name コンテナ名`|コンテナの名前を指定する||
|`-p ホストのポート番号:コンテナのポート番号`|ポートを指定する|`--publish`|
|`-v ホストのディスク:コンテナのディレクトリ`|ボリュームをマウントする|`--volume`|
|`--net=ネットワーク名`|コンテナをネットワークに接続する||
|`-e 環境変数名=値`|環境変数を指定する|`--env`|
|`-help`|help||
|`-h`|ホスト名を指定してコンテナを起動する|`--hostname`|
|`--rm`|コンテナ停止時にコンテナを削除||
|`-w`|コンテナ内に入る際に指定したディレクトリで入る||

## memo
* 作成 -> 起動 -> 停止 -> 破棄 -> 作成 -> ... のような一連の流れをコンテナのライフサイクルという
* 64bit版のOS上でなければ動作しない
* サーバを再起動時にDockerEngineを自動起動する設定は存在するが、コンテナを自動起動する設定は存在しない。コンテナを自動起動させるにはスクリプトを用意すれば可能
* dockerコマンドの基本的な形は `docker コマンド (オプション) 対象 (引数)`
* Dockerイメージはそのイメージから作成されたDockerコンテナが存在しない場合に限り、削除することができる
* イメージのバージョンを指定したい場合は`Image名:バージョン番号`のようにバージョンを指定する
* `docker commit [コンテナID] [新たに作成するイメージ名]` により、稼働しているコンテナをイメージに変換
* 稼働中のコンテナ内でCTRL+P,CTRL+Q を入力するとコンテナ外に出られる

# NGINXでTLSの設定
```
1. Dockerファイル内でopensslコマンドで必要な秘密鍵・CSR・証明書を作成する
FROM alpine:latest

RUN apk update && \
        apk upgrade && \
        apk add bash nginx openssl

RUN mkdir /etc/nginx/certs
COPY ./conf/openssl.cnf /etc/nginx/certs/
COPY ./conf/nginx.conf /etc/nginx/
COPY ./tools/index.html /var/www/html/

# 秘密鍵の作成
RUN openssl genrsa -out /etc/nginx/certs/ca.key 2048 // 認証局の秘密鍵
RUN openssl genrsa -out /etc/nginx/certs/server.key 2048 // Webサーバの秘密鍵
# CSR（証明書署名要求）の作成
RUN openssl req -new -key /etc/nginx/certs/server.key -out /etc/nginx/certs/server.csr -config /etc/nginx/certs/openssl.cnf // WebサーバのCSR
# CRT（SSLサーバ証明書）の作成
RUN openssl req -new -x509 -days 365 -key /etc/nginx/certs/ca.key -out /etc/nginx/certs/ca.crt -subj "/C=JP/ST=Tokyo/L=Minato/O=Example/OU=IT/CN=Example CA" // 認証局の証明書
RUN openssl x509 -req -days 365 -in /etc/nginx/certs/server.csr -CA /etc/nginx/certs/ca.crt -CAkey /etc/nginx/certs/ca.key -CAcreateserial -out　/etc/nginx/certs/server.crt -extfile /etc/nginx/certs/openssl.cnf -extensions req_ext // Webサーバの証明書

ENTRYPOINT /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
```
2. nginx.confファイル内でTLSを使用するための設定を記述する
```
worker_processes  1;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       443 ssl; // sslとすることで暗号化通信
        server_name  rikeda-cloud.com; // server_nameは証明書に載せる情報と同じものにする
        root /var/www/html/;
        ssl_certificate /etc/nginx/certs/server.crt; // Dockerfileで作成したcrtファイルを指定
        ssl_certificate_key /etc/nginx/certs/server.key; // DOckerfile内で作成したWebサーバ用の秘密鍵ファイルを指定

        location / {
                        index index.html;
        }
    }
}
```
3. opensslコマンドのconfigファイルを作成しておく
```
[req]
default_bits        = 2048
default_keyfile     = server.key
distinguished_name = req_distinguished_name
req_extensions      = req_ext
x509_extensions     = v3_ca
prompt = no // Dockerfile内でCSRを作成する時に対話形式だとエラーになる

[req_distinguished_name]
C = JP
ST = Minato
L = Shinjuku
O = 42tokyo
OU = IT
CN = rikeda-cloud.com // 使用したいドメインを記述

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = rikeda-cloud.com
DNS.2 = www.rikeda-cloud.com
```
4. Dockerコンテナを作成し、Dockerfile内で作成した`/etc/nginx/certs/server.crt`と`/etc/nginx/certs/ca.crt`ファイルをホスト側にコピーする
```
docker cp <コンテナ名>:/etc/nginx/certs/server.crt
docker cp <コンテナ名>:/etc/nginx/certs/ca.crt
```
5. ホストOS側に証明書を登録する
```
sudo cp server.crt ca.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust 
```
6. Chromeに証明書を登録する
```
chrome://settings/certificates にアクセス
サーバの欄のインポートで server.crt ファイルを選択
認証局の欄のインポートで ca.crt ファイルを選択
コンテナで公開しているWebサービスにアクセス
```
