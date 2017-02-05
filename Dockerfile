FROM debian:stretch

# Global dependencies
RUN apt-get update \
  && apt-get install -y \
    camlp4 \
    firefox-esr \
    git \
    make \
    neko \
    ocaml \
    xvfb \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Haxe configuration
ENV HAXE_SRC_PATH /src/haxe
ENV HAXE_REPOSITORY https://github.com/demurgos/haxe.git
ENV HAXE_BRANCH 3.1_bugfix
ENV HAXE_STD_PATH /usr/lib/haxe/std/:.
ENV HAXELIB_REPOSITORY_PATH /usr/lib/haxe/lib/

# Build Haxe
RUN git clone --recursive --branch $HAXE_BRANCH $HAXE_REPOSITORY $HAXE_SRC_PATH
WORKDIR $HAXE_SRC_PATH
RUN make \
  && make install
# Haxelib confguration (must be executed outside of the Haxe sources)
WORKDIR /
RUN echo $HAXELIB_REPOSITORY_PATH | haxelib setup

# Haxelib packages
RUN haxelib install lime 2.3.3 \
  && haxelib install munit 2.1.2 \
  && haxelib install openfl 3.0.1 \
  && haxelib install svg 1.1.1

CMD ["/bin/bash"]
