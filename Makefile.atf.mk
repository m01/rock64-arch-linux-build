BL31 ?= arm-trusted-firmware/build/$(ATF_PLAT)/release/bl31/bl31.elf

TOOLCHAIN:=/x-tools8/aarch64-unknown-linux-gnueabi/bin/aarch64-unknown-linux-gnueabi-

arm-trusted-firmware/build/$(ATF_PLAT)/release/bl31/bl31.elf: arm-trusted-firmware
	make -C $< realclean
	make -C $< CROSS_COMPILE=$(TOOLCHAIN) M0_CROSS_COMPILE=$(TOOLCHAIN) PLAT=$(ATF_PLAT) CFLAGS="-fno-stack-protector" bl31 ENABLE_STACK_PROTECTOR="0"

arm-trusted-firmware/build/$(ATF_PLAT)/debug/bl31/bl31.elf: arm-trusted-firmware
	make -C $< realclean
	make -C $< CROSS_COMPILE=$(TOOLCHAIN) M0_CROSS_COMPILE=$(TOOLCHAIN) PLAT=$(ATF_PLAT) bl31 DEBUG=1

.PHONY: atf-build
atf-build: $(BL31)

.PHONY: atf-clean
atf-clean:
	rm -rf arm-trusted-firmware/build

