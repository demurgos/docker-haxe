FROM debian:stretch

# Firefox installation
RUN echo "deb http://http.debian.net/debian unstable main" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y -t unstable \
    firefox \
  && rm -rf /var/lib/apt/lists/*

ENV LANG en-US

COPY local.conf /etc/fonts/local.conf

ENTRYPOINT [ "/usr/bin/firefox" ]

# docker build -t firefox-debian .
# docker run -e DISPLAY -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host firefox-debian
