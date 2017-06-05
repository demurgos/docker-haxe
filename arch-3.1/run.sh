#!/usr/bin/env bash
# Exit on error
set -e
# Echo and run
CMD="docker run -it demurgos/haxe:arch-3.1" && echo "$CMD" && eval "$CMD"
