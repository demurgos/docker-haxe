FROM base/archlinux:latest
MAINTAINER Charles Samborski <demurgos@demurgos.net>

# Build:
# docker build -t haxe-3.4 .
# Run:
# docker run -it haxe-3.4
# Run with GUI support:
# xhost local:docker && docker run -it -e DISPLAY -v $HOME/.Xauthority:/home/root/.Xauthority --net=host haxe-3.4

# Packages (for Flash development with Haxe)
# Utils: git, coreutils (provides `timeout` and `true`), expect
# Haxe compilation: camlp4, gcc (provides `as`), make, neko, ocaml, pcre, zlib
# Flash dev: firefox, flashpluginm, xorg-server-xvfb
RUN pacman -Syu --quiet --noconfirm --noprogressbar \
  && pacman -S --quiet --noconfirm --noprogressbar \
    camlp4 \
    coreutils \
    expect \
    firefox \
    flashplugin \
    gcc \
    git \
    make \
    neko \
    nodejs \
    npm \
    ocaml \
    pcre \
    xorg-server-xvfb \
    yarn \
    zlib

# Initialize firefox by running it once
RUN timeout 20s xvfb-run firefox; true

# Haxe 3.4_bugfix installation from source
# HAXE_STD_PATH is required for Haxelib and normal execution
ENV HAXE_STD_PATH /usr/lib/haxe/std/:.
# HAXELIB_REPOSITORY_PATH points to the root of Haxelib's local repository
ENV HAXELIB_REPOSITORY_PATH /usr/lib/haxe/lib/
RUN HAXE_SRC_PATH="/src/haxe/" \
  && HAXE_REPOSITORY="https://github.com/HaxeFoundation/haxe.git" \
  && HAXE_BRANCH="3.4_bugfix" \
  && git clone --recursive --branch "${HAXE_BRANCH}" "${HAXE_REPOSITORY}" "${HAXE_SRC_PATH}" \
  && cd "${HAXE_SRC_PATH}" \
  # Haxe 3 is incompatible with safe-string
  && OCAMLPARAM="safe-string=0,_" make \
  && make install \
  # Haxelib configuration, must be executed outside of the Haxe sources
  && cd / \
  && echo "${HAXELIB_REPOSITORY_PATH}" | haxelib setup

RUN cd "${HAXELIB_REPOSITORY_PATH}"
  && cd hxcpp/git
  && cd tools/hxcpp
  && haxe compile.hxml

RUN npm install -g npm gulp-cli

CMD ["/bin/bash"]
