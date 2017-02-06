FROM debian:sid
MAINTAINER Jessie Frazelle <jess@linux.com>

RUN apt-get update && apt-get install -y \
    dirmngr \
    gnupg \
    --no-install-recommends \
  && echo "deb http://http.debian.net/debian unstable main" >> /etc/apt/sources.list.d/firefox.list \
	&& apt-get update && apt-get install -y \
    ca-certificates \
    hicolor-icon-theme \
    libasound2 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    --no-install-recommends \
	&& apt-get install -y -t unstable \
    firefox \
    --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG en-US

COPY local.conf /etc/fonts/local.conf

ENTRYPOINT [ "/usr/bin/firefox" ]

# docker build -t firefox .
# xhost local:docker && docker run -e DISPLAY -v $HOME/.Xauthority:/home/root/.Xauthority --net=host firefox
