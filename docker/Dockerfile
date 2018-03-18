FROM archlinux/base:latest

RUN echo "" >> /etc/pacman.conf && \
    echo "[archlinuxfr]" >> /etc/pacman.conf && \
    echo "SigLevel=Optional TrustAll" >> /etc/pacman.conf && \
    echo "Server=http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel aarch64-linux-gnu-gcc dtc git uboot-tools swig openssh python-virtualenv yaourt 

# Downgrade to previous versions (see issue #3)
RUN pacman -U --noconfirm https://archive.archlinux.org/packages/d/dtc/dtc-1.4.5-1-x86_64.pkg.tar.xz https://archive.archlinux.org/packages/a/aarch64-linux-gnu-binutils/aarch64-linux-gnu-binutils-2.29.1-1-x86_64.pkg.tar.xz

RUN useradd -m -G wheel -s /bin/bash rock64
RUN sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
RUN su - rock64 -c "yaourt -Sy --noconfirm --needed libguestfs"

VOLUME ["/rock64-arch-linux-build"]

USER rock64
WORKDIR /rock64-arch-linux-build
CMD /usr/bin/make arch.img
