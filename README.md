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

## memo
* 作成 -> 起動 -> 停止 -> 破棄 -> 作成 -> ... のような一連の流れをコンテナのライフサイクルという
* 64bit版のOS上でなければ動作しない
* サーバを再起動時にDockerEngineを自動起動する設定は存在するが、コンテナを自動起動する設定は存在しない。コンテナを自動起動させるにはスクリプトを用意すれば可能
* dockerコマンドの基本的な形は `docker コマンド (オプション) 対象 (引数)`


## LinuxOSでの操作方法

システム関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`sudo systemctl start docker`|DockerEngineの起動||
|`sudo systemctl stop docker`|DockerEngineの終了||
|`sudo systemctl enable docker`|DockerEngineの自動起動設定||
|`docker version`|Dockerの情報を表示する||
|`docker login`|Dockerレジストリにログインする||
|`docker logout`|Dockerレジストリからログアウトする||
|`docker search`|Dockerレジストリで検索する||

コンテナ関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`docker container run`|Imageを用いてコンテナを実行| `docker image pull`<br>`docker container create`<br>`docker container start`<br>の一連の操作をまとめたもの|
|`docker container start`|イメージをコンテナとして開始する||
|`docker container stop`|コンテナを停止する||
|`docker container create`|Dockerイメージからコンテナを作成する||
|`docker container rm`|停止したコンテナを削除する||
|`docker container exec`|実行中のコンテナ内でプログラムを実行する||
|`docker container ls`|コンテナ一覧を表示||
|`docker container cp`|コンテナとホスト間でファイルをコピー||
|`docker container commit`|コンテナをイメージに変換する||

イメージ関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`docker image pull`|イメージをダウンロード||
|`docker image rm`|イメージを削除する||
|`docker image ls`|ダウンロードしたイメージ一覧を表示する||
|`docker image build`|Dockerイメージを作成する||

ボリューム関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`docker volume create`|ボリュームを作成する||
|`docker volume inspect`|ボリュームの詳細情報を表示する||
|`docker volume prune`|現在マウントされていないボリュームを全て削除する||
|`docker volume rm`|ボリュームの削除||

ネットワーク関連
|コマンド|説明|備考|
|:--:|:--:|:--:|
|`docker network connect`|コンテナをネットワークに接続する||
|`docker network disconnect`|コンテナをネットワークから切断する||
|`docker network create`|ネットワークを作成する||
|`docker network inspect`|ネットワークの詳細を表示する||
|`docker network ls`|ネットワークの一覧を表示する||
|`docker network prune`|現在コンテナに接続されていないネットワークを全て削除する||
|`docker network rm`|ネットワークを削除する||

オプション
|オプション|説明|備考|
|:--:|:--:|:--:|
|`-d`|バックグラウンドで起動||
|`-it`|キーボードからの操作を可能にする||
