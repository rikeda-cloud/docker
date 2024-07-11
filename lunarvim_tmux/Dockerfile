FROM alpine:latest

# 引数でユーザ名を指定してbuildしてください
ARG USER=please_set_user_environ

# 必要なパッケージのインストール
COPY packages.txt /tmp/packages.txt
RUN xargs -a /tmp/packages.txt apk add --no-cache

# ユーザの追加
RUN adduser -D -S ${USER} --shell /bin/bash

# LunarVimのインストール
RUN su -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-install-dependencies" ${USER}

# configfileのCOPY
COPY .profile .bashrc .tmux.conf .tmux.start.conf /home/${USER}/

# Nerd Font をダウンロードしてインストール
RUN mkdir -p /usr/share/fonts/nerd-fonts \
    && curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip -o /tmp/nerd-font.zip \
    && unzip -q /tmp/nerd-font.zip -d /usr/share/fonts/nerd-fonts \
    && /usr/bin/fc-cache -fv

# StarShipプリセットを選択
# RUN starship preset jetpack -o /home/${USER}/.config/starship.toml
COPY starship.toml /home/${USER}/.config/starship.toml

USER ${USER}
WORKDIR /home/${USER}
CMD ["/bin/bash", "--login"]
