# ~/.aliases

alias nano='nano --linenumbers --mouse --tabsize=4'

# ASCII animations
alias periodic-table='npx periodic-table-cli'
alias world-map='telnet mapscii.me'
alias cmd-help='compgen -c | fzf | xargs man'
alias ascii_colors='colortest-16b'
alias hacking-terminal='docker run --rm -it bcbcarl/hollywood'       # `CTRL-C` and `exit` to stop
alias hollywood='docker run --rm -it bcbcarl/hollywood'       # `CTRL-C` and `exit` to stop
alias sl='sl -e'	# enables `CTRL C` (SIGINT signal)

alias git_cheat_sheet='google-chrome https://ndpsoftware.com/git-cheatsheet.html#loc=index &> /dev/null &'	# open Git Cheat Sheet in web browser (`google-chrome` can be replaced with `open`)

alias git_reset_last_commit="git reset --hard \$(git log | grep 'commit' awk 'NR==1 {print $2}')"

alias git_delete_last_commit="git reset --soft HEAD~1 && git push -f origin"


alias open_git_repository_in_github="open \$(git config --list | grep 'http' | sed 's/remote.origin.url=//g') &> /dev/null &"


alias lsc=exa			# colored ls cmd
alias ip='ip -c'		# colored ip cmd


alias fzf_print_file='file=$(fzf) && echo "Absolute path: $(realpath $file)" && cat "$file"'

alias fzf_cmd_helper='cmd=$(compgen -c | fzf) && man $cmd 2> /dev/null || $cmd --help 2> /dev/null || type $cmd 2> /dev/null || echo "unkwon $cmd"'

alias fzf_history='cmd=$(history | sort -r | fzf | awk '\''{$1=""; print substr($0,2)}'\'') && echo "$cmd" && eval "$cmd"'


# For copy-ing the output of a (piped) command to clipboard
alias copy='xclip -selection clipboard'




# List of favourite `oh-my-posh` themes
# Make sure to install them, before making aliases
fav_posh_themes=(
    'tiwahu'
    'atomic'
    'blue-owl'
    'blueish'
    'clean-detailed'
    'kali'
    'powerlevel10k_modern'
    'powerlevel10k_rainbow'
    'quick-term'
    'kushal'
    'stelbent.minimal'
    'stelbent-compact.minimal'
)

# oh-my-posh is a prompt theme, check it out here: https://ohmyposh.dev/
for theme in "${fav_posh_themes[@]}" ; do
    alias "prompt-theme-$theme"="eval \"\$(oh-my-posh init $(basename $SHELL) --config $HOME/.cache/oh-my-posh/themes/$theme.omp.json)\""
done


# Prerequisites:
# $ sudo apt install gnome-tweaks -y
# $ git clone https://github.com/vinceliuice/Tela-icon-theme.git
# $ cd Tela-icon-theme
# $ chmod +x ./install.sh
# $ ./install.sh -a                         # Install all icon themes
# $ ./install.sh -c <nord|blue|red|...>     # Install a specific icon theme
#
# After installation, feel free to delete the repo:
# $ cd ../ && rm -rf ../Tela-icon-theme
fav_tela_icon_themes=(
    'blue-dark'
    'nord-dark'
)
for theme in "${fav_tela_icon_themes[@]}" ; do
    alias "icon-tela-$theme"="gsettings set org.gnome.desktop.interface icon-theme Tela-$theme"
done



alias ga='git add'
alias gc='git commit'
alias gp='git push'
