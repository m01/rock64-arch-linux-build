Rock64 Arch Linux Image Builder
===============================

Overview
--------
This code will build a pretty "vanilla" Arch Linux ARM image for the Rock64 Single Board Computer.

It builds u-boot using ayufan's scripts (from https://github.com/ayufan-rock64/linux-build/, https://github.com/ayufan-rock64/linux-u-boot/). Then, it use guestfish to create an empty image, partition it as required by the RK3328, format the `boot` and `linux-root` partitions, and extract the [Arch Linux ARM ARMv8 generic](https://archlinuxarm.org/platforms/armv8/generic) tarball into the image. It will then add the u-boot bootloader, extlinux config with the kernel command line args and fix the serial console.

Build procedure (native)
------------------------
This is written from the perspective of someone building the image on Arch Linux x86_64. See below for Dockerised version.

Install the following prerequisites (mostly required for building u-boot):
* `guestfish` (part of `libguestfs` package)
* `dtc` version `1.4.5-1`
* `git`
* `uboot-tools`
* `swig`
* `make`

And one of the following toolchains for cross-compilation (see issue #3):
* `aarch64-linux-gnu-gcc`, and
* `aarch64-linux-gnu-binutils` version `2.29.1-1` (tested) or `>=2.31` (presumed). `2.30` does not work, see the issue mentioned above.
OR:
* ARMv8 pre-built toolchain from https://archlinuxarm.org/wiki/Distcc_Cross-Compiling

Ensure the `TOOLCHAIN` variable in the `Makefile` is set appropriately.

Then:
```
make [arch.img]
```

Build procedure (using Docker)
------------------------------

1. Build docker image
2. Build Arch Linux Rock64 image

```
./docker/build-docker-image.sh
./docker/build-rock64-image.sh
```

Rock64 image usage
------------------
Burn image to sdcard or eMMC. Boot.

username/password: `alarm`/`alarm`
`root` password: `root`

When using SSH, login as `alarm` first, then `su root`.

Known/potential issues
------------
* If you suffer from network performance issues, [try disabling rx and tx pauses using ethtool](https://github.com/ayufan-rock64/linux-build/blob/master/package/root/etc/network/if-up.d/rock64-offload)

Things to do
------------
In no particular order:

- [ ] Figure out how to install extra packages (currently, guestfish's `command` running ability cannot be used because of the mismatch in architectures in the guest image and host)
- [ ] Create systemd unit file for the ethtool setup (see above)
- [ ] Contribute Arch Linux support back into ayufan's [linux-build](https://github.com/ayufan-rock64/linux-build/) repo, assuming it's desired.
- [ ] Build Arch Linux packages for ayufan's kernels.

Credits
-------
* ayufan for his excellent work on building Rock64 images. Many parts of this repo are inspired by his [linux-build](https://github.com/ayufan-rock64/linux-build/) and other code. The following are (almost) directly taken from his code:
  * `extlinux.conf`
  * `Makefile.*.mk`
* Rockchip for caring about mainline support for their chips
* Arch Linux ARM for the distribution
* [Arch Linux Wiki page on banana pi](https://wiki.archlinux.org/index.php/Banana_Pi) for a pointer on fixing python library loading issues when building u-boot
* picodotdev for setting up a Dockerfile & associated scripts for building the rock64 image
* Everyone who's reported issues and helped me fix them!
