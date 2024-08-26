# Docker

## 簡単なWebサーバの立ち上げから削除まで(一連の操作は`docker run --name WEBSERVER -d -p 8080:80 httpd`で置き換え可能)
1. `docker image pull httpd` イメージをダウンロードする
2. `docker container create --name WEBSERVER -p 8080:80 httpd` イメージからコンテナを作成する
3. `docker container start WEBSERVER` コンテナをバックグラウンドで立ち上げ、ホストから8080ポートで接続可能にする

## memo
* 作成 -> 起動 -> 停止 -> 破棄 -> 作成 -> ... のような一連の流れをコンテナのライフサイクルという
* 64bit版のOS上でなければ動作しない
* dockerコマンドの基本的な形は `docker コマンド (オプション) 対象 (引数)`
* イメージのバージョンを指定したい場合は`Image名:バージョン番号`のようにバージョンを指定する
* `docker commit [コンテナID] [新たに作成するイメージ名]` により、稼働しているコンテナをイメージに変換
* 稼働中のコンテナ内でCTRL+P,CTRL+Q を入力するとコンテナ外に出られる

## images
![container](https://github.com/user-attachments/assets/58b236ad-f230-441c-8e59-d720442fd303)

![structure](https://github.com/user-attachments/assets/9bca2e35-e7bc-4337-924c-02a1df0c6c5d)

![bonus](https://github.com/user-attachments/assets/17a49f66-9c3a-47d6-8459-88c9a1308a1d)
