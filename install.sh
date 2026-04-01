#!/bin/bash

set -e

echo "==> update the system..."
sudo pacman -Syu --noconfirm

echo "==> installing pacotes..."
sudo pacman -S --needed --noconfirm \
  hyprland hyprlock hyprsunset hyprpaper hyprshot waybar swaync \
  kitty rofi fastfetch python-pywal colorz flatpak fish code \
  kservice dolphin dolphin-plugins qt5-wayland qt6-wayland ark pavucontrol-qt \
  playerctl brightnessctl python-pip ttf-jetbrains-mono-nerd ufw \
  blueman networkmanager network-manager-applet xorg-xwayland polkit-kde-agent \
  qt6ct sddm neovim vim wget tar unzip nwg-look nwg-dock-hyprland nwg-drawer \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk mpv

command -v yay >/dev/null || { echo "yay not installed"; exit 1; }
yay -S --noconfirm wlogout 
flatpak install --u app.zen_browser.zen

echo "==> changing shell for fish and change the terminal color..."
chsh -s /bin/fish "$USER"
pip install --user --break-system-packages colorz
wal -i ~/.config/hypr/chainsaw-man.jpg --backend colorz 

echo "==> creating the folders..."
mkdir -p ~/.config
mkdir -p ~/.local
sudo mkdir -p /usr/share/sddm
sudo mkdir -p /usr/share/icons
sudo mkdir -p /usr/share/themes
sudo mkdir -p /usr/share/fonts

echo "==> copying settings..."
# .config
cp -r ~/dotfiles/.config/* ~/.config/
# .local
cp -r ~/dotfiles/.local/* ~/.local/
# usr/share
sudo cp -r ~/dotfiles/usr/share/* /usr/share/

# GTK Theme
wget -O theme.tar.xz "https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1518877154/04-Flat-Remix-GTK-Red-20240730.tar.xz?response-content-disposition=attachment%3B%252004-Flat-Remix-GTK-Red-20240730.tar.xz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20260328%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260328T140124Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=95b806ef4b5c070c9922dfecc57a4526db9629e11c0048b5417f6ac51fc454d9"
sudo tar -xf theme.tar.xz -C /usr/share/themes/
rm theme.tar.xz

# Icons
wget -O icons.tar.gz "https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1642676449/Nordzy-red-dark.tar.gz?response-content-disposition=attachment%3B%2520Nordzy-red-dark.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20260328%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260328T141231Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=d8652d826eac354e044917472ab5eab39a8f4df4f4fbf7b85f3f2b9680560090"
sudo tar -xf icons.tar.gz -C /usr/share/icons/
rm icons.tar.gz

# Cursor
wget -O cursor.tar.gz "https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1700865606/Breeze-Dark-Red.tar.gz?response-content-disposition=attachment%3B%2520Breeze-Dark-Red.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20260328%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260328T141502Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=b4b747fd2e5a1c5c2791e1cbb75a3fdcbd4ff47cd78673189e7533d5df3361bb"
sudo tar -xf cursor.tar.gz -C /usr/share/icons/
rm cursor.tar.gz

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
