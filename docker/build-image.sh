#!/usr/bin/env bash
docker run --rm --name rock64-arch-linux-build --volume "$(dirname $(pwd))":/rock64-arch-linux-build rock64/rock64-arch-linux-build:latest
