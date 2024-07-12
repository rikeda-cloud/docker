FROM archlinux:latest

# 引数でユーザ名を指定してbuildしてください
ARG USER=please_set_user_environ

# 必要なパッケージのインストール
COPY packages.txt /tmp/packages.txt
RUN pacman -Syu --noconfirm && pacman -S --noconfirm $(cat /tmp/packages.txt | xargs)

# ユーザの追加
RUN useradd -m -s /bin/bash ${USER}

# LunarVimのインストール
RUN su ${USER} -c "bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/release-1.4/neovim-0.9/utils/installer/install.sh) --no-install-dependencies"

# configfileのCOPY
COPY .profile .bashrc .tmux.conf .tmux.start.conf /home/${USER}/

# StarShipプリセットを選択
RUN su - ${USER} -c "starship preset no-runtime-versions -o /home/${USER}/.config/starship.toml"

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja

WORKDIR /home/${USER}
USER ${USER}
CMD ["/bin/bash", "--login"]
