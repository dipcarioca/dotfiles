#!/bin/bash

set -e

echo "==> update the system..."
sudo pacman -Syu --noconfirm

echo "==> installing pacotes..."
sudo pacman -S --needed --noconfirm \
  hyprland hyprlock hyprsunset hyprpaper hyprshot waybar swaync \
  kitty rofi fastfetch python-pywal flatpak fish code \
  kservice dolphin dolphin-plugins qt5-wayland qt6-wayland ark pavucontrol-qt \
  playerctl brightnessctl python-pip ttf-jetbrains-mono-nerd ufw \
  blueman networkmanager network-manager-applet xorg-xwayland polkit-kde-agent \
  qt6ct sddm neovim vim wget tar unzip nwg-look nwg-dock-hyprland nwg-drawer \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk mpv

command -v yay >/dev/null || { echo "yay not installed"; exit 1; }
yay -S --needed noconfirm wlogout 
flatpak install app.zen_browser.zen

echo "==> creating the folders..."
mkdir -p ~/.config
mkdir -p ~/.local
sudo mkdir -p /usr/share/sddm
sudo mkdir -p /usr/share/icons/

echo "==> copying settings..."
# .config
cp -r ~/dotfiles/.config/* ~/.config/
# .local
cp -r ~/dotfiles/.local/* ~/.local/
# usr/share
sudo cp -r ~/dotfiles/usr/share/* /usr/share/

# GTK Theme
git https://github.com/daniruiz/flat-remix-gtk.git
sudo mv flat-remix-gtk/themes/* /usr/share/themes/
sudo rm -r flat-remix-gtk

# Icons
git clone https://github.com/MolassesLover/Nordzy-icon
sudo ./Nordzy-icon/./install.sh -c dark -t red
sudo rm -r Nordyz-icon/

echo "==> changing shell for fish and change the terminal color..."
chsh -s /bin/fish "$USER"
pip install --user --break-system-packages colorz
wal -i ~/.config/hypr/chainsaw-man.jpg --backend colorz 

# Fonte
fc-cache -fv

echo "==> configuring SDDM..."
sudo cp ~/dotfiles/etc/sddm.conf /etc/sddm.conf
sudo cp -r ~/dotfiles/etc/sddm.conf.d/ /etc/sddm.conf.d

echo "==> everything is ready, activating services"
sudo ufw enable
command -v balooctl6 && balooctl6 disable
echo "..."
sleep 2 && sudo systemctl enable --now sddm
