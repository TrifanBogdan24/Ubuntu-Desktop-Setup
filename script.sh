#!/bin/bash
set -e

# ================================
#  Helper Functions
# ================================
print_section() {
    echo
    echo "============================================================"
    echo "  $1"
    echo "============================================================"
    echo
}


# ================================
#  📝 Dotfiles Setup
# ================================
configure_dotfiles() {
    print_section "📝 Configuring Dotfiles"

    print_step "Overwriting shell config files..."
    cp .dotfiles/.aliases.sh ~/.aliases.sh
    cp .dotfiles/.functions.sh ~/.functions.sh
    cp .dotfiles/.bashrc.sh ~/.bashrc.sh
    cp .dotfiles/.zshrc.sh ~/.zshrc.sh

    echo "✅ Dotfiles configured!"
}

print_step() {
    echo "👉 $1"
}

# ================================
#  🐳 Docker Installation
# ================================
install_docker() {
    print_section "🐳 Installing Docker"

    print_step "Uninstalling old versions..."
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do 
        sudo apt-get remove -y $pkg || true
    done

    print_step "Setting up Docker repository..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    print_step "Installing Docker packages..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo systemctl enable --now docker

    print_step "Verifying Docker installation..."
    sudo docker run hello-world || echo "⚠️ Docker test container failed. Check manually."
}

# ================================
#  🔑 GPG Key Setup for Git
# ================================
gen_gpg_key_for_git() {
    print_section "🔑 Generating GPG Key for Git"

    read -p "Enter your name: " NAME
    read -p "Enter your email: " EMAIL

    KEY_CONF=$(mktemp)
    cat > "$KEY_CONF" <<EOF
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Expire-Date: 1y
Name-Real: $NAME
Name-Email: $EMAIL
%commit
%echo done
EOF

    gpg --batch --generate-key "$KEY_CONF"
    rm -f "$KEY_CONF"

    FPR=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" | awk '/sec/{print $2}' | cut -d'/' -f2)

    git config --global user.name "$NAME"
    git config --global user.email "$EMAIL"
    git config --global user.signingkey "$FPR"
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true

    echo
    echo "✅ Your GPG key details:"
    gpg --list-keys --keyid-format=long "$EMAIL" | awk '/^pub/ || /^sub/ || /^uid/ {print}'

    echo
    echo "📋 Your public key (paste into GitHub):"
    gpg --armor --export "$FPR" | copy
}

# ================================
#  🚀 System & Dev Setup
# ================================
install_basics() {
    print_section "🚀 Updating System & Installing Basics"

    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y nala

    print_step "Installing shell & configs..."
    sudo nala install -y zsh wget curl git xfce4-terminal gnome-tweaks

}

install_languages_editors() {
    print_section "💻 Installing Languages"

    sudo nala install -y build-essential python3 python3-venv
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
    . "$HOME/.cargo/env"

    print_section "💻 Installing Editors"
    sudo snap install --classic code
    sudo snap install --classic sublime-text
}

install_utils() {
    print_section "🛠 Installing Utilities & Fun Stuff"

    sudo nala install -y xclip fzf neofetch colortest htop bpytop rng-tools
    sudo snap install onefetch
    sudo nala install -y cmatrix sl
    cargo install rusty-rain bat
}

install_desktop_apps() {
    print_section "🖥 Installing Desktop Applications"

    sudo snap install obsidian
    sudo snap install brave
    sudo snap install discord
}

# ================================
#  🎨 Tela Icon Theme Installation
# ================================
install_tela_icons() {
    print_section "🎨 Installing Tela Icon Theme"

    git clone https://github.com/vinceliuice/Tela-icon-theme.git
    cd Tela-icon-theme
    chmod +x ./install.sh

    print_step "Installing nord color theme..."
    ./install.sh -c nord

    cd ..
    rm -rf Tela-icon-theme
    echo "✅ Tela Icon Theme installed!"

    gsettings set org.gnome.desktop.interface icon-theme Tela-blue-dark
    echo "🟦 Tela Icon Theme was set to blue!"
}

# ================================
#  ✨ Oh My Posh Prompt & Fonts
# ================================
install_oh_my_posh() {
    print_section "✨ Installing Oh My Posh & Nerd Fonts"

    mkdir -p ~/.local/bin/
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

    print_step "Installing nerd fonts..."
    oh-my-posh font install jetbrainsmono
    oh-my-posh font install firamono
    oh-my-posh font install hack
    oh-my-posh font install ubuntu
    oh-my-posh font install ubuntumono
    oh-my-posh font install ubuntusans

    echo "✅ Oh My Posh and fonts installed!"
}

setup_github_ssh() {
    print_section "🔐 Setting up GitHub SSH Key"

    ssh-keygen -t ed25519 -f ~/.ssh/github -N ""
    cat ~/.ssh/github.pub | copy
    echo "✅ SSH public key copied to clipboard. Add it to GitHub!"
}

# ================================
#  🔄 Change default shell to Zsh
# ================================
change_shell_to_zsh() {
    print_section "🔄 Changing default shell to Zsh"
    
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
        echo "✅ Default shell changed to Zsh. Log out and log back in to apply."
    else
        echo "ℹ️ Zsh is already the default shell."
    fi
}


# ================================
#  🎬 Run Everything
# ================================
main() {
    install_basics
    configure_dotfiles
    install_languages_editors
    install_utils
    install_desktop_apps
    install_tela_icons
    install_oh_my_posh
    install_docker
    setup_github_ssh
    gen_gpg_key_for_git
    change_shell_to_zsh
    print_section "✨ Setup Complete!"
}

main
