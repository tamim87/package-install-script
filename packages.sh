#!/bin/bash
shopt -s expand_aliases


# apt package manager
alias aptup='sudo apt update && sudo apt upgrade'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptin='sudo apt install'
alias aptrm='sudo apt remove'
alias apts='apt search'


aptin gedit
aptin curl -y
aptin gcc -y
aptin g++ -y
aptin git -y
aptin git-lfs -y
aptin neovim -y
aptin libfuse2 -y
aptin neofetch -y
aptin ncdu -y
aptin vlc -y
aptin haruna -y
aptin exa -y
aptin gnome-shell-extensions -y
aptin gnome-shell-extension-manager -y
aptin ubuntu-restricted-extras -y
aptin qpdfview -y
aptin libreoffice -y
aptin gnome-tweaks -y
aptin geany -y
aptin geany-plugins -y
aptin obs-studio -y
aptin foliate -y
aptin distrobox -y
aptin solaar -y






# jetbrains mono font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"


# sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update && sudo apt install sublime-text


# cloudflare warp
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ jammy main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
aptup && aptin cloudflare-warp -y

warp-cli register
warp-cli connect
warp-cli set-mode warp+doh



# onlyoffice
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

aptup && aptin onlyoffice-desktopeditors



# starship prompt for shell
curl -sS https://starship.rs/install.sh | sh
sudo snap install spotify 
sudo snap install bitwarden 


# dracula theme for gnome-terminal
sudo apt install dconf-cli
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh


# dracula theme for gedit
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir /home/tamim/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/
# #now Activate the theme in Gedit's preferences dialog


# Discord
wget -O ~/discord-installer.deb "https://discord.com/api/download?platform=linux&format=deb"
aptin ./discord-installer.deb -y
rm discord-installer.deb


# freedownload manager
wget https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb
aptin ./freedownloadmanager.deb -y
rm freedownloadmanager.deb


# Visual Studio Code
wget -O ~/vscode-installer.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
aptin ./vscode-installer.deb -y
rm vscode-installer.deb
