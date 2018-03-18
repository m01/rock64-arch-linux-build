#!/usr/bin/env bash
DIR="$(dirname $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd))"
docker run --rm --name rock64-arch-linux-build --volume "$DIR":/rock64-arch-linux-build rock64/rock64-arch-linux-build:latest
