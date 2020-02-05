#!/bin/bash

echo "Installing docker..."
if test ! "$(command -v docker)"; then
  echo "References:"
  echo "  - https://www.docker.com/blog/happy-pi-day-docker-raspberry-pi/"
  echo "  - https://howchoo.com/g/nmrlzmq1ymn/how-to-install-docker-on-your-raspberry-pi"
  sleep 1
  curl -sSL get.docker.com | sh
  sudo usermod -aG docker $USER
else
  echo "docker already installed"
  sleep 1
fi

cd $HOME
echo "Installing hstr..."
if test ! "$(command -v hstr)"; then
  echo "References:"
  echo "  - https://github.com/dvorka/hstr/blob/master/INSTALLATION.md#build-on-any-linux-distro"
  sleep 1
  git clone https://github.com/dvorka/hstr
  cd ./hstr/build/tarball
  ./tarball-automake.sh
  cd ../..
  ./configure
  make
  make install
  cd $HOME
  rm -rf hstr
else
  echo "hstr already installed"
  sleep 1
fi

cd $HOME
echo "Installing neovim..."
if test ! "$(command -v nvim)"; then
  echo "References:"
  echo "  - https://github.com/neovim/neovim/wiki/Building-Neovim#building"
  sleep 1
  git clone https://github.com/neovim/neovim
  cd neovim
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd $HOME
  rm -rf neovim
else
  echo "neovim already installed"
  sleep 1
fi

cd $HOME
echo "Installing cmus..."
if test ! "$(command -v cmus)"; then
  echo "References:"
  echo "  - https://cmus.github.io/#download"
  sleep 1
  git clone https://github.com/cmus/cmus .cmus
  cd .cmus
  sed -i 's/-lm/-lm -latomic/g' Makefile
  ./configure prefix=$HOME/.cmus
  sudo make install
else
  echo "cmus already installed"
  sleep 1
fi

cd $HOME
echo "Installing mosh..."
if test ! "$(command -v mosh)"; then
  echo "References:"
  echo "  - https://github.com/mobile-shell/mosh/issues/961#issuecomment-565741393"
  sleep 1
  git clone https://github.com/mobile-shell/mosh
  cd mosh
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd $HOME
  rm -rf mosh
else
  echo "mosh already installed"
  sleep 1
fi

cd $HOME
echo "Installing oh-my-zsh..."
sleep 1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"