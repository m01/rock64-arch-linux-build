UBOOT_DEFCONFIG ?= rock64-rk3328_defconfig
UBOOT_DIR ?= u-boot
PYTHON ?= python2
ATF_PLAT ?= rk3328
BOARD_TARGET = rock64
BOARD_CHIP = rk3328
# TOOLCHAIN ?= aarch64-unknown-linux-gnueabi-
TOOLCHAIN ?= aarch64-linux-gnu-

arch.img: sync u-boot-venv ArchLinuxARM-aarch64-latest.tar.gz out/u-boot-rock64/idbloader.img
	guestfish -N arch.img=disk:2048M -a out/u-boot-rock64/idbloader.img --rw -f create.gfs

arch.img.xz: arch.img
	xz $<

ArchLinuxARM-aarch64-latest.tar.gz:
	curl -LO http://archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz

arm-trusted-firmware:
	git clone https://github.com/ARM-software/arm-trusted-firmware.git

u-boot:
	# poor man's XML parser ;-)
	BRANCH=$$(curl -s https://raw.githubusercontent.com/ayufan-rock64/linux-manifests/default/default.xml | grep linux-u-boot | egrep -o  'revision=\"([^\"]+)\"' | cut -d'"' -f2); \
	git clone --depth=1 --branch $$BRANCH https://github.com/ayufan-rock64/linux-u-boot.git u-boot; \
	sed -i 's/#!\/usr\/bin.*python[2]*/#!\/usr\/bin\/env python2/' $$(egrep -l '#\!.*python' -r u-boot | grep -v -i README)
	# ^ fix interpreter.. but even that's not enough

u-boot-venv:
	virtualenv -p python2 u-boot-venv

rkbin:
	git clone https://github.com/ayufan-rock64/rkbin.git

sync: rkbin arm-trusted-firmware ArchLinuxARM-aarch64-latest.tar.gz u-boot

clean:
	rm -rfv arch.img out tmp

superclean: clean
	rm -rf arm-trusted-firmware u-boot rkbin \
		ArchLinuxARM-aarch64-latest.tar.gz u-boot-venv

include Makefile.atf.mk
include Makefile.uboot.mk
