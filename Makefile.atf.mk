BL31 ?= arm-trusted-firmware/build/$(ATF_PLAT)/release/bl31/bl31.elf

arm-trusted-firmware/build/$(ATF_PLAT)/release/bl31/bl31.elf: arm-trusted-firmware
	make -C $< realclean
	# Note that ENABLE_STACK_PROTECTOR="0" is actually the default,
	# see https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/user-guide.rst
	# However, if $(TOOLCHAIN)gcc has been compiled with --enable-default-ssp,
	# we need to explicitly disable the stack protector, since currently
	# plat_get_stack_protector_canary() is not implemented for the Rock64.
	# See https://github.com/m01/rock64-arch-linux-build/issues/3 for details.
	make -C $< CROSS_COMPILE=$(TOOLCHAIN) M0_CROSS_COMPILE=$(TOOLCHAIN) PLAT=$(ATF_PLAT) CFLAGS="-fno-stack-protector" bl31 ENABLE_STACK_PROTECTOR="none"

arm-trusted-firmware/build/$(ATF_PLAT)/debug/bl31/bl31.elf: arm-trusted-firmware
	make -C $< realclean
	make -C $< CROSS_COMPILE=$(TOOLCHAIN) M0_CROSS_COMPILE=$(TOOLCHAIN) PLAT=$(ATF_PLAT) CFLAGS="-fno-stack-protector" bl31 DEBUG=1 ENABLE_STACK_PROTECTOR="0"

.PHONY: atf-build
atf-build: $(BL31)

.PHONY: atf-clean
atf-clean:
	rm -rf arm-trusted-firmware/build
