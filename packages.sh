#!/bin/bash
shopt -s expand_aliases


# apt package manager
alias aptup='sudo apt update && sudo apt upgrade'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptin='sudo apt install'
alias aptrm='sudo apt remove'
alias apts='apt search'


# curl is a command line tool for transferring data with URL syntax
aptin curl -y

# Modern replacement for ls
aptin exa -y

# Application deployment framework for desktop apps
aptin flatpak

# Flatpak support for GNOME Software, makes it possible to install apps without needing the command line
aptin gnome-software-plugin-flatpak

# Add the Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# simple and modern ebook viewer
aptin foliate -y

# GNU C++ compiler
aptin g++ -y

# GNU C compiler
aptin gcc -y

# fast and lightweight IDE
aptin geany -y

# set of plugins for Geany
aptin geany-plugins -y

# popular text editor for the GNOME desktop environment
aptin gedit -y

# fast, scalable, distributed revision control system
aptin git -y

# An open source Git extension for versioning large files.
aptin git-lfs -y

# Extensions to extend functionality of GNOME Shell
aptin gnome-shell-extensions -y

# Utility for managing GNOME Shell Extensions
aptin gnome-shell-extension-manager -y

# tool to adjust advanced configuration settings for GNOME
aptin gnome-tweaks -y

# open source video player built with Qt/QML on top of libmpv
aptin haruna -y

# Filesystem in Userspace (library) - needed to run appimages
aptin libfuse2 -y

# office productivity suite (metapackage)
aptin libreoffice -y

# Ncdu is a ncurses-based disk usage viewer
aptin ncdu -y

# Shows Linux System Information with Distribution Logo
aptin neofetch -y

# Neovim is a fork of Vim focused on modern code and features
aptin neovim -y

# recorder and streamer for live video content
aptin obs-studio -y

# tabbed document viewer
aptin qpdfview -y

# Commonly used media codecs and fonts for Ubuntu
aptin ubuntu-restricted-extras -y

# multimedia player and streamer
aptin vlc -y

# Another tool for containerized command line environments on Linux
# aptin distrobox -y

# simple open source disk benchmark tool for Linux distros
aptin kdiskmark -y

# Logitech Unifying Receiver peripherals manager for Linux
# aptin solaar -y


## Snap Applications

# Bitwarden Password Manager
sudo snap install bitwarden

# Unofficial version of Microsoft To-Do
sudo snap install microsoft-todo-unofficial


## flatpak Applications

# Discord
flatpak install flathub com.discordapp.Discord -y

# Postman - Platform for building and using APIs
flatpak install flathub com.getpostman.Postman -y

# Portal for Teams - Unofficial Microsoft Teams client for Linux
flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y

# Google Chrome Web Browser
flatpak install flathub com.google.Chrome -y

# Blanket - Listen to ambient sounds
flatpak install flathub com.rafaelmardojai.Blanket -y

# BoxBuddy - A Graphical Distrobox Manager
flatpak install flathub io.github.dvlv.boxbuddyrs -y

# Obsidian - Markdown-based knowledge base
flatpak install flathub md.obsidian.Obsidian -y

# Joplin - open source note taking and to-do application
flatpak install flathub net.cozic.joplin_desktop -y

# DbGate - (no)SQL database client
flatpak install flathub org.dbgate.DbGate -y

# Firefox - Fast, Private & Safe Web Browser
flatpak install flathub org.mozilla.firefox -y

# ONLYOFFICE Desktop Editors - Office productivity suite
flatpak install flathub org.onlyoffice.desktopeditors -y

# Telegram Desktop
flatpak install flathub org.telegram.desktop -y


# jetbrains mono font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"


# sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update && sudo apt install sublime-text


# freedownload manager
wget https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb
aptin ./freedownloadmanager.deb -y
rm freedownloadmanager.deb


# Visual Studio Code
wget -O ~/vscode-installer.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
aptin ./vscode-installer.deb -y
rm vscode-installer.deb


# cloudflare warp
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
aptup && aptin cloudflare-warp -y

warp-cli register
warp-cli connect
warp-cli set-mode warp+doh


# # onlyoffice
# mkdir -p -m 700 ~/.gnupg
# gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
# chmod 644 /tmp/onlyoffice.gpg
# sudo chown root:root /tmp/onlyoffice.gpg
# sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

# echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
# aptup && aptin onlyoffice-desktopeditors


# starship prompt for shell
curl -sS https://starship.rs/install.sh | sh


# dracula theme for gnome-terminal
sudo apt install dconf-cli
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh


# dracula theme for gedit
wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
mkdir /home/tamim/.local/share/gedit/styles/
mv dracula.xml $HOME/.local/share/gedit/styles/
# # now Activate the theme in Gedit's preferences dialog
