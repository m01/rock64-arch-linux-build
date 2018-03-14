#!/usr/bin/env bash
su - rock64 -c "git clone https://github.com/m01/rock64-arch-linux-build.git"
su - rock64 -c "(cd rock64-arch-linux-build && make arch.img)"
