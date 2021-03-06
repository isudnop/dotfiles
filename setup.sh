#!/bin/sh
DOTFILES_NAME=.dotfiles

if [ "$(uname)" = "Darwin" ]; then
  if [ -d "$HOME/Library/Application Support/iTerm2/DynamicProfiles" ]; then
    echo "iTerm2 found, setup dynamic profiles..."
    # Remove files inside the directory
    rm -rf "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    # Remove the directory itself
    rm -rf "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    ln -s "$HOME/$DOTFILES_NAME/files/iterm2/DynamicProfiles" "$HOME/Library/Application Support/iTerm2"
  fi
else
  echo "Setting up system..."

  echo "Enabling access over USB-C..."
  if sudo test -f /root/usb.sh; then
    echo "Already enabled"
  else
    echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt >/dev/null
    echo "modules-load=dwc2" | sudo tee -a /boot/cmdline.txt >/dev/null
    sudo touch /boot/ssh
    echo "libcomposite" | sudo tee -a /etc/modules >/dev/null
    echo "denyinterfaces usb0" | sudo tee -a /etc/dhcpcd.conf >/dev/null
    mkdir -p /etc/dnsmasq.d
    mkdir -p /etc/network/interfaces.d
    cat $HOME/$DOTFILES_NAME/files/etc/dnsmasq.d/usb | sudo tee /etc/dnsmasq.d/usb >/dev/null
    cat $HOME/$DOTFILES_NAME/files/etc/network/interfaces.d/usb0 | sudo tee /etc/network/interfaces.d/usb0 >/dev/null
    cat $HOME/$DOTFILES_NAME/files/root/usb.sh | sudo tee /root/usb.sh >/dev/null
    sudo chmod 755 /root/usb.sh
    sudo sed -i $'s/exit 0$/sh \\/root\\/usb.sh\\\nexit 0/g' /etc/rc.local
  fi
fi
