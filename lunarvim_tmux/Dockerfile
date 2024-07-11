FROM alpine:latest
ARG USER=please_set_user_environ

COPY .profile .bashrc .tmux.conf .tmux.start.conf /home/${USER}/

# 必要なパッケージのインストールとユーザーの追加
COPY packages.txt /tmp/packages.txt
RUN xargs -a /tmp/packages.txt apk add --no-cache \
    && adduser -D -S ${USER} --shell /bin/bash

# LunarVimのインストール
RUN su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-install-dependencies" ${USER}

USER ${USER}
WORKDIR /home/${USER}
CMD ["/bin/bash", "--login"]
