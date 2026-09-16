#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
  appstream               \
  breeze-icons            \
  calf                    \
  cmake                   \
  extra-cmake-modules     \
  gsl                     \
  intltool                \
  kcolorscheme            \
  kconfig                 \
  kconfigwidgets          \
  kcoreaddons             \
  ki18n                   \
  kiconthemes             \
  kirigami                \
  kirigami-addons         \
  kvantum                 \
  ladspa                  \
  libbs2b                 \
  libebur128              \
  libmysofa               \
  libsamplerate           \
  libsndfile              \
  lilv                    \
  lsp-plugins-lv2         \
  mda.lv2                 \
  ninja                   \
  nlohmann-json           \
  noto-fonts              \
  pipewire                \
  pipewire-audio          \
  pipewire-jack           \
  qqc2-desktop-style      \
  qt6-base                \
  qt6-declarative         \
  qt6-graphs              \
  qt6ct                   \
  rnnoise                 \
  soundtouch              \
  speexdsp                \
  tbb                     \
  webrtc-audio-processing \
  x42-plugins-lv2         \
  yelp                    \
  zita-convolver

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano kiconthemes-mini

make-aur-package deepfilternet-plus-bin
make-aur-package zam-plugins-git

echo "Building EasyEffects..."
echo "---------------------------------------------------------------"
git clone https://github.com/wwmm/easyeffects.git ./easyeffects && (
  cd ./easyeffects

  git fetch --tags origin
  TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha\|beta' | head -1)
  git checkout "$TAG"
  echo "${TAG#v}" > ~/version

  cmake -B build -S . -G Ninja        \
    -DCMAKE_BUILD_TYPE=Release        \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr  \
    -Wno-dev
  cmake --build build
  cmake --install build
)
