FROM archlinux:base

# Avoid interactive prompts
ENV TERM=xterm

RUN pacman -Syu --noconfirm;
RUN pacman -S --noconfirm neovim;
RUN pacman -S --noconfirm git;
RUN pacman -S --noconfirm curl;
RUN pacman -S --noconfirm unzip;
RUN pacman -S --noconfirm bash;
RUN pacman -S --noconfirm gcc;
RUN pacman -S --noconfirm make;
RUN pacman -S --noconfirm go;
RUN pacman -S --noconfirm nodejs;
RUN pacman -S --noconfirm npm;
RUN pacman -S --noconfirm python;
RUN pacman -S --noconfirm python-pip;
RUN pacman -S --noconfirm wget;
RUN pacman -S --noconfirm rustup;
RUN pacman -S --noconfirm lua;
RUN pacman -S --noconfirm ruby;
RUN pacman -S --noconfirm composer;
RUN pacman -S --noconfirm php;
RUN pacman -S --noconfirm jdk-openjdk;
RUN pacman -S --noconfirm julia;
RUN pacman -S --noconfirm tree-sitter-cli;
RUN pacman -S --noconfirm ripgrep;
RUN pacman -S --noconfirm fd;
RUN pacman -S --noconfirm python-black;
RUN pacman -S --noconfirm python-isort;
RUN pacman -S --noconfirm python-pynvim;
RUN pacman -S --noconfirm mdformat;
RUN pacman -S --noconfirm luarocks;
RUN pacman -S --noconfirm perl;
RUN pacman -S --noconfirm cpanminus;
RUN pacman -Scc --noconfirm;

RUN rustup default stable;
RUN npm install -g @fsouza/prettierd;
RUN /usr/bin/vendor_perl/cpanm -n Neovim::Ext;
RUN gem install neovim;

ENTRYPOINT ["nvim"]
