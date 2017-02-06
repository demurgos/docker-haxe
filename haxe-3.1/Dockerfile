FROM debian:stretch
MAINTAINER Charles Samborski <demurgos@demurgos.net>

# Build:
# docker build -t haxe-3.1 .
# Run:
# docker run -it haxe-3.1
# Run with GUI support:
# xhost local:docker && docker run -it -e DISPLAY -v $HOME/.Xauthority:/home/root/.Xauthority --net=host haxe-3.1

# Firefox installation
RUN echo "deb http://http.debian.net/debian unstable main" >> /etc/apt/sources.list.d/firefox.list \
  && apt-get update \
  && apt-get install --no-install-recommends --assume-yes \
    ca-certificates \
    dirmngr \
    gnupg \
    hicolor-icon-theme \
    libasound2 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
	&& apt-get install --no-install-recommends --assume-yes --target-release unstable \
    firefox \
	&& rm -rf /var/lib/apt/lists/*

# TODO: Add this to the firefox block:
RUN apt-get update \
  && apt-get install --no-install-recommends --assume-yes \
    dbus \
	&& rm -rf /var/lib/apt/lists/*

# Global dependencies
# Jessie contrib for flashplugin-nonfree
RUN echo "deb http://deb.debian.org/debian jessie contrib" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --assume-yes \
    apache2-dev \
    camlp4 \
    cmake \
    flashplugin-nonfree \
    git \
    libgc-dev \
    libgtk2.0-dev \
    libmariadb-client-lgpl-dev-compat \
    libmbedtls-dev \
    libpcre3-dev \
    libsqlite3-dev \
    libssl-dev \
    make \
    ocaml \
    xvfb \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Neko installation from source
RUN NEKO_SRC_PATH="/src/neko/" \
  && NEKO_REPOSITORY="https://github.com/HaxeFoundation/neko.git" \
  && NEKO_BRANCH="master" \
  && git clone --branch "$NEKO_BRANCH" "$NEKO_REPOSITORY" "$NEKO_SRC_PATH" \
  && cd "$NEKO_SRC_PATH" \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make \
  && make install

# Haxe 3.1_bugfix installation from source
# HAXE_STD_PATH is required for Haxelib and normal execution
ENV HAXE_STD_PATH /usr/lib/haxe/std/:.
# HAXELIB_REPOSITORY_PATH points to the root of Haxelib's local repository
ENV HAXELIB_REPOSITORY_PATH /usr/lib/haxe/lib/
RUN HAXE_SRC_PATH="/src/haxe/" \
  && HAXE_REPOSITORY="https://github.com/demurgos/haxe.git" \
  && HAXE_BRANCH="3.1_bugfix" \
  && git clone --recursive --branch "$HAXE_BRANCH" "$HAXE_REPOSITORY" "$HAXE_SRC_PATH" \
  && cd "$HAXE_SRC_PATH" \
  && make \
  && make install \
  # Haxelib configuration, must be executed outside of the Haxe sources
  && cd / \
  && echo "$HAXELIB_REPOSITORY_PATH" | haxelib setup

# Haxelib packages
RUN haxelib install lime 2.3.3 \
  && haxelib install munit 2.1.2 \
  && haxelib install openfl 3.0.1 \
  && haxelib install svg 1.1.1

CMD ["/bin/bash"]
