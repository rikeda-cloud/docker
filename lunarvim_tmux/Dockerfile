FROM alpine:latest

# 引数でユーザ名を指定してbuildしてください
ARG USER=please_set_user_environ

# 必要なパッケージのインストール
COPY packages.txt /tmp/packages.txt
RUN apk update && apk upgrade && xargs -a /tmp/packages.txt apk add --no-cache

# ユーザの追加
RUN adduser -D -S ${USER} --shell /bin/bash

# LunarVimのインストール
RUN su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-install-dependencies" ${USER}

# configfileのCOPY
COPY .profile .bashrc .tmux.conf .tmux.start.conf /home/${USER}/

# StarShipプリセットを選択
RUN starship preset no-runtime-versions -o /home/${USER}/.config/starship.toml

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

WORKDIR /home/${USER}
USER ${USER}
CMD ["/bin/bash", "--login"]
