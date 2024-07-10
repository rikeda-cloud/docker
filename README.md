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
|SHELL|ビルド時のシェルを指定||
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
