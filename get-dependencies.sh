#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Rdd --noconfirm pulseaudio || true
pacman -Syu --noconfirm \
  easyeffects \
  pipewire-pulse pipewire-jack pipewire \
  calf lsp-plugins-lv2 mda.lv2 \
  yelp noto-fonts

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano kiconthemes-mini 

# Comment this out if you need an AUR package
make-aur-package zam-plugins-git

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
