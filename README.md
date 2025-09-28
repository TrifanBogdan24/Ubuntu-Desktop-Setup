# Ubuntu 22.04 Developer Setup Script 🚀

This script automates the installation of essential development tools, system utilities, and aesthetic customizations
for a fresh **Ubuntu 22.04** installation.
It's designed to give you a fully featured dev environment quickly and beautifully.


## Features 🛠

### 1. System Basics
- Updates system packages (`apt update` & `upgrade`)
- Installs essential tools: `wget`, `curl`, `git`, `zsh`, `xfce4-terminal`
- Installs build tools: `build-essential` (C/C++ compilers)

### 2. Shell & Dotfiles
- Overwrites shell config files with your custom `.dotfiles`:
  - `.aliases.sh`
  - `.functions.sh`
  - `.bashrc.sh`
  - `.zshrc.sh`

### 3. Programming Languages & Editors
- Python 3 + venv support
- Rust & Cargo
- VS Code (`snap install --classic code`)
- Sublime Text (`snap install --classic sublime-text`)

### 4. Docker 🐳
- Uninstalls old Docker versions
- Installs latest Docker, Docker Compose, and plugins
- Verifies Docker installation with `hello-world` container

### 5. Utilities & Fun CLI Tools
- `xclip` (copy CLI output to clipboard)
- `fzf` (fuzzy finder)
- System monitors: `htop`, `bpytop`
- Terminal art & animations: `neofetch`, `onefetch`, `cmatrix`, `sl`, `rusty-rain`, `bat`

### 6. Desktop Applications
- Obsidian
- Brave Browser
- Discord

### 7. Theming & Fonts 🎨
- **Tela Icon Theme** (`nord` color theme)
- **Oh My Posh prompt** with Nerd Fonts:
  - JetBrainsMono, FiraMono, Hack, Ubuntu, UbuntuMono, UbuntuSans

### 8. Git & GitHub Setup 🔑
- Generate SSH key for GitHub and copy to clipboard
- Generate GPG key for signing Git commits & tags
- Configures Git global username, email, and signing key

---

## Usage

```bash
git clone <your-repo-url>
cd Linux-Desktop-Setup
chmod +x setup.sh
sudo ./setup.sh
```

> ⚠️ The script requires `sudo` privileges for installing packages.


## Notes
- Ensure your `.dotfiles` folder is present in the script directory.
- After running, restart your shell to apply **Rust** environment and **Oh My Posh** prompt.