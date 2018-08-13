#!/usr/bin/env bash
# Exit on error
set -e
# Absolute path to directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -x
# Echo and run build command
cd "${SCRIPT_DIR}" && docker build --tag="demurgos/haxe:3.4" .
