#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker build -t rock64/rock64-arch-linux-build:latest "$DIR"
