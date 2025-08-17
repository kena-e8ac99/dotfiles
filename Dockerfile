FROM archlinux:base

ARG username
RUN : ${username?}

# Package install
RUN <<EOF
pacman -Syu --noconfirm
pacman -S --noconfirm \
  bash-completion git vim bash-language-server shellcheck shfmt
pacman -Scc
EOF

# User switch
RUN <<EOF
useradd -m $username
chown -R $username:$username /home/$username
EOF

WORKDIR /home/$username
USER $username

CMD ["bash", "-i"]

