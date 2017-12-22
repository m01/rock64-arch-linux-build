Rock64 Arch Linux Image Builder
===============================

Overview
--------
This code will build a pretty "vanilla" Arch Linux ARM image for the Rock64 Single Board Computer.

It builds u-boot using ayufan's scripts (from https://github.com/ayufan-rock64/linux-build/, https://github.com/ayufan-rock64/linux-u-boot/). Then, it use guestfish to create an empty image, partition it as required by the RK3328, format the `boot` and `linux-root` partitions, and extract the [Arch Linux ARM ARMv8 generic](https://archlinuxarm.org/platforms/armv8/generic) tarball into the image. It will then add the u-boot bootloader, extlinux config with the kernel command line args and fix the serial console.

Build procedure
---------------
This is written from the perspective of someone building the image on Arch Linux x86_64.

Install the following prerequisites (mostly required for building u-boot):
* `aarch64-linux-gnu-gcc`
* `guestfish`
* `dtc`
* `git`
* `uboot-tools`
* `swig`
* `make`

Then:
```
make [arch.img]
```

Usage
-----
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
