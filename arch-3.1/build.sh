#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Echo and run build command
CMD="cd \"$SCRIPT_DIR\" && docker build --tag=\"demurgos/haxe:arch-3.1\" ." && echo "$CMD" && eval "$CMD"
