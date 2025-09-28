# Created by newuser for 5.9


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="xiong-chiamiov-plus"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)



# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -s -r



# install Zsh Plugin Manager
source ~/.config/zsh/zpm/zpm.zsh 2>/dev/null || {
  git clone https://github.com/zpm-zsh/zpm ~/.config/zsh/zpm 2>/dev/null
  source ~/.config/zsh/zpm 2>/dev/null
}


### 3party plugins
zpm load                      \
  zpm-zsh/core-config         \
  zpm-zsh/ignored-users,async \
  zpm-zsh/check-deps,async    \
  zpm-zsh/ls,async            \
  zpm-zsh/colorize,async      \
  zpm-zsh/ssh,async           \
  zpm-zsh/dot,async           \
  zpm-zsh/undollar,async      \
  zpm-zsh/bookmarks,async     \
  voronkovich/gitignore.plugin.zsh,async     \
  zpm-zsh/autoenv,async                      \
  mdumitru/fancy-ctrl-z,async                \
  zpm-zsh/zsh-history-substring-search,async \
  zsh-users/zsh-autosuggestions,async        \
  zpm-zsh/fast-syntax-highlighting,async     \
  zpm-zsh/history-search-multi-word,async


. "$HOME/.cargo/env"
export PATH=$PATH:/home/bogdan/.local/bin


# the order matters
source ~/.functions.sh
source ~/.aliases.sh


neofetch --ascii_distro arch



eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/blue-owl.omp.json)"

. "/home/bogdan/.deno/env"
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# For to-pit-or-not-to-pit
eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/tiwahu.omp.json)"
