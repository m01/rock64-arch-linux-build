#!/usr/bin/env bash
docker stop rock64-arch-linux-build
docker rm rock64-arch-linux-build
docker run --name rock64-arch-linux-build rock64/rock64-arch-linux-build:latest bash -c "(cd /home/rock64/ && ./make.sh)"
docker cp rock64-arch-linux-build:/home/rock64/rock64-arch-linux-build/arch.img arch.img