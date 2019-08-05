FROM archlinux/base:latest

RUN pacman -Syu --noconfirm && pacman -S --noconfirm base-devel aarch64-linux-gnu-gcc dtc git uboot-tools swig openssh python-virtualenv && rm -rf /var/cache/pacman/pkg/

# non-root user for builds
RUN useradd -m -G wheel -s /bin/bash rock64
RUN sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

# build libguestfs and its hivex dependency
RUN cd /tmp; git clone https://aur.archlinux.org/libguestfs.git && \
  git clone https://aur.archlinux.org/hivex.git && \
  chown -R rock64 /tmp/hivex /tmp/libguestfs && \
  su - rock64 -c "cd /tmp/hivex; makepkg -cs --noconfirm" && pacman -U --noconfirm hivex/hivex-*.xz && \
  su - rock64 -c "cd /tmp/libguestfs; makepkg -cs --noconfirm" && pacman -U --noconfirm libguestfs/libguestfs-*.xz && \
  rm -rf hivex libguestfs /var/cache/pacman/pkg/

# Downgrade to previous versions (see issue #3 and README.md)
RUN pacman -U --noconfirm https://archive.org/download/archlinux_pkg_dtc/dtc-1.4.5-1-x86_64.pkg.tar.xz

VOLUME ["/rock64-arch-linux-build"]

USER rock64
WORKDIR /rock64-arch-linux-build
CMD /usr/bin/make arch.img
