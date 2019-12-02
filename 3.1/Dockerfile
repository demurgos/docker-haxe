FROM archlinux:latest
MAINTAINER Charles Samborski <demurgos@demurgos.net>

# Build:
# docker build -t haxe-3.1 .
# Run:
# docker run -it haxe-3.1
# Run with GUI support:
# xhost local:docker && docker run -it -e DISPLAY -v $HOME/.Xauthority:/home/root/.Xauthority --net=host haxe-3.1

# Packages (for Flash development with Haxe)
# Utils: git, coreutils (provides `timeout` and `true`), expect
# Haxe compilation: camlp4, gcc (provides `as`), make, neko, ocaml, pcre, zlib
# Flash dev: firefox, flashpluginm, xorg-server-xvfb
RUN pacman -Syu --quiet --noconfirm --noprogressbar \
  && pacman -S --quiet --noconfirm --noprogressbar \
    base \
    base-devel \
    camlp4 \
    coreutils \
    expect \
    fakeroot \
    ffmpeg \
    flashplugin \
    gcc \
    git \
    jq \
    make \
    neko \
    nodejs \
    npm \
    ocaml \
    pcre \
    sudo \
    xorg-server-xvfb \
    yarn \
    zlib

# Haxe 3.1_bugfix installation from source
# HAXE_STD_PATH is required for Haxelib and normal execution
ENV HAXE_STD_PATH /usr/lib/haxe/std/:.
# HAXELIB_REPOSITORY_PATH points to the root of Haxelib's local repository
ENV HAXELIB_REPOSITORY_PATH /usr/lib/haxe/lib/
RUN HAXE_SRC_PATH="/src/haxe/" \
  && HAXE_REPOSITORY="https://github.com/HaxeFoundation/haxe.git" \
  && HAXE_BRANCH="3.1_bugfix" \
  && git clone --recursive --branch "${HAXE_BRANCH}" "${HAXE_REPOSITORY}" "${HAXE_SRC_PATH}" \
  && cd "${HAXE_SRC_PATH}" \
  # Haxe 3 is incompatible with safe-string
  && OCAMLPARAM="safe-string=0,_" make \
  && make install \
  # Haxelib configuration, must be executed outside of the Haxe sources
  && cd / \
  && echo "${HAXELIB_REPOSITORY_PATH}" | haxelib setup

# Passwordless sudo for the user `aur`
COPY sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers
RUN groupadd sudo && useradd --create-home -G sudo -s /bin/bash aur

# Use the `aur` user to install `firefox-esr-bin`
RUN FIREFOX_ESR_BIN_PATH="/src/firefox-esr-bin/" \
  && FIREFOX_ESR_BIN_REPOSITORY="https://aur.archlinux.org/firefox-esr-bin.git" \
  && git clone "${FIREFOX_ESR_BIN_REPOSITORY}" "${FIREFOX_ESR_BIN_PATH}" \
  && chown -R aur "${FIREFOX_ESR_BIN_PATH}" \
  && su -l aur -c "cd \"${FIREFOX_ESR_BIN_PATH}\" && makepkg --noconfirm --syncdeps --install"

# Initialize firefox by running it once
RUN timeout 20s xvfb-run firefox-esr; true

# Use the `aur` user to install `swfmill
RUN SWFMILL_PATH="/src/swfmill/" \
  && SWFMILL_REPOSITORY="https://aur.archlinux.org/swfmill.git" \
  && git clone "${SWFMILL_REPOSITORY}" "${SWFMILL_PATH}" \
  && chown -R aur "${SWFMILL_PATH}" \
  && su -l aur -c "cd \"${SWFMILL_PATH}\" && makepkg --noconfirm --syncdeps --install"

RUN npm install -g gulp-cli

CMD ["/bin/bash"]
