#!/usr/bin/env bash
# Exit on error
set -ex
xhost local:docker && docker run -it -e DISPLAY -v $HOME/.Xauthority:/home/root/.Xauthority --net=host demurgos/haxe:3.4
