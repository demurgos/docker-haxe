FROM debian:stretch

# Global dependencies
RUN echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list \
  && echo "deb http://http.debian.net/debian unstable main" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y -t unstable \
    firefox
  && apt-get install -y \
    apache2-dev \
    camlp4 \
    ca-certificates \
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

# Neko configuration
ENV NEKO_SRC_PATH /src/neko
ENV NEKO_REPOSITORY https://github.com/HaxeFoundation/neko.git
ENV NEKO_BRANCH master

# Build Neko
RUN git clone --branch $NEKO_BRANCH $NEKO_REPOSITORY $NEKO_SRC_PATH
WORKDIR $NEKO_SRC_PATH
RUN mkdir build \
  && cd build \
  && cmake .. \
  && make \
  && make install

# Haxe configuration
ENV HAXE_SRC_PATH /src/haxe
ENV HAXE_REPOSITORY https://github.com/demurgos/haxe.git
ENV HAXE_BRANCH 3.1_bugfix
# HAXE_STD_PATH is also required for execution
ENV HAXE_STD_PATH /usr/lib/haxe/std/:.
ENV HAXELIB_REPOSITORY_PATH /usr/lib/haxe/lib/

# Build Haxe
RUN git clone --recursive --branch $HAXE_BRANCH $HAXE_REPOSITORY $HAXE_SRC_PATH
WORKDIR $HAXE_SRC_PATH
RUN make \
  && make install
# Haxelib configuration (must be executed outside of the Haxe sources)
WORKDIR /
RUN echo $HAXELIB_REPOSITORY_PATH | haxelib setup

# Haxelib packages
RUN haxelib install lime 2.3.3 \
  && haxelib install munit 2.1.2 \
  && haxelib install openfl 3.0.1 \
  && haxelib install svg 1.1.1

CMD ["/bin/bash"]
