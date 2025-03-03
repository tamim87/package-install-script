#!/bin/bash
shopt -s expand_aliases

# ==============================
# Aliases for Package Management
# ==============================
alias aptup='sudo apt update && sudo apt upgrade -y'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade -y'
alias aptin='sudo apt install -y'
alias aptrm='sudo apt remove -y'
alias apts='apt search'

LOG_FILE="/tmp/package_install.log"

# =========================
# Package Helper Functions
# =========================

# Check if a package is installed
is_installed() {
    dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"
}

# Check if an APT package has an update available
is_update_available() {
    apt list --upgradable 2>/dev/null | grep -q "^$1/"
}

# Install an APT package safely
install_apt_package() {
    local package=$1
    if is_installed "$package"; then
        if is_update_available "$package"; then
            echo "Updating $package..."
            aptin "$package" || echo "⚠️ Failed to update $package" >> "$LOG_FILE"
        else
            echo "$package is already up to date."
        fi
    else
        echo "Installing $package..."
        aptin "$package" || echo "⚠️ Failed to install $package" >> "$LOG_FILE"
    fi
}

# Install a .deb package safely
install_deb_package() {
    local package_name=$1
    local package_url=$2
    local temp_deb="/tmp/${package_name}.deb"

    if is_installed "$package_name"; then
        echo "$package_name is already installed."
    else
        echo "Installing $package_name..."
        wget -O "$temp_deb" "$package_url" && sudo dpkg -i "$temp_deb" && sudo apt-get -f install -y \
        || echo "⚠️ Failed to install $package_name" >> "$LOG_FILE"
        rm -f "$temp_deb"
    fi
}

# Install a Snap package safely
install_snap_package() {
    local package=$1
    if snap list | grep -q "^$package "; then
        echo "$package (Snap) is already installed."
    else
        echo "Installing $package (Snap)..."
        sudo snap install "$package" || echo "⚠️ Failed to install Snap package $package" >> "$LOG_FILE"
    fi
}

# =====================
# Install Core Packages
# =====================

APT_PACKAGES=(
    "curl" "exa" "foliate" "g++" "gcc" "geany" "geany-plugins" "gedit" 
    "git" "git-lfs" "gnome-shell-extensions" "gnome-shell-extension-manager"
    "gnome-tweaks" "haruna" "libfuse2" "libreoffice" "ncdu" "neofetch"
    "neovim" "obs-studio" "qpdfview" "ubuntu-restricted-extras" "vlc"
    "kdiskmark" 
)

for package in "${APT_PACKAGES[@]}"; do
    install_apt_package "$package"
done

# Snap Packages
SNAP_PACKAGES=("bitwarden")

for package in "${SNAP_PACKAGES[@]}"; do
    install_snap_package "$package"
done

# =========================
# Install Custom Applications
# =========================

# JetBrains Mono Font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# Sublime Text
if ! is_installed "sublime-text"; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update
    install_apt_package "sublime-text"
fi

# .deb Packages List
declare -A DEB_PACKAGES=(
    ["freedownloadmanager"]="https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb"
    ["code"]="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    ["discord"]="https://discord.com/api/download?platform=linux&format=deb"
)

for package in "${!DEB_PACKAGES[@]}"; do
    install_deb_package "$package" "${DEB_PACKAGES[$package]}"
done

# Cloudflare Warp
if ! is_installed "cloudflare-warp"; then
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ jammy main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    aptup
    install_apt_package "cloudflare-warp"
    warp-cli register
    warp-cli connect
    warp-cli set-mode warp+doh
fi

# OnlyOffice
if ! is_installed "onlyoffice-desktopeditors"; then
    mkdir -p -m 700 ~/.gnupg
    gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
    chmod 644 /tmp/onlyoffice.gpg
    sudo chown root:root /tmp/onlyoffice.gpg
    sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
    echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
    aptup
    install_apt_package "onlyoffice-desktopeditors"
fi

# Starship Prompt for Shell
curl -sS https://starship.rs/install.sh | sh

# Dracula Theme for GNOME Terminal
if [ ! -d "$HOME/gnome-terminal" ]; then
    sudo apt install dconf-cli -y
    git clone https://github.com/dracula/gnome-terminal "$HOME/gnome-terminal"
    cd "$HOME/gnome-terminal" && ./install.sh
    cd ..
fi

# Dracula Theme for Gedit
if [ ! -f "$HOME/.local/share/gedit/styles/dracula.xml" ]; then
    wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
    mkdir -p "$HOME/.local/share/gedit/styles/"
    mv dracula.xml "$HOME/.local/share/gedit/styles/"
fi

# =====================
# Summary of Failures
# =====================
if [[ -s "$LOG_FILE" ]]; then
    echo -e "\n⚠️ Some packages failed to install. Check the log file: $LOG_FILE"
    cat "$LOG_FILE"
else
    echo -e "\n✅ All packages installed successfully!"
fi

