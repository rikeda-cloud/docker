# コンテナOSはdebianを使用
From debian

# コンテナ内にインストールしたいパッケージのリストをコピーする
COPY packages.txt /tmp/packages.txt
COPY .bashrc /root/.bashrc
COPY .tmux.conf /root/.tmux.conf
COPY .tmux.start.conf /root/.tmux.start.conf

# 環境変数を設定して対話的な入力を無効にする
ENV DEBIAN_FRONTEND=noninteractive

# ログイン時にhomeから始める
WORKDIR /home/rikeda

# 必要なパッケージをインストール
RUN apt-get update && \
	apt-get upgrade && \
	xargs -a /tmp/packages.txt apt-get install -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim

# デフォルトでtmuxが動く
CMD ["tmux"]
