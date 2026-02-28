# ~/.bash_aliases
alias vi='vim'
alias py='python'
alias supy='sudo python'
alias ..='cd ..'
alias update='sudo dnf upgrade'
alias terminal-opacity="dconf write /org/gnome/Ptyxis/Profiles/a1b19cf4a2080de13d50b0dd68189f01/opacity"

# Terminal App w/ Extra Steps
alias copyparty-c="copyparty -c $HOME/.config/copyparty/.config -p 5000 --crt-dir $HOME/Public --qr"
alias ibus-setup="PYTHON=/usr/bin/python ibus-setup"

# MySQL Database
alias mysql-ctrlpanel='sudo /opt/lampp/manager-linux-x64.run'
alias databases-start='sudo /opt/lampp/lampp start'
alias databases-stop='sudo /opt/lampp/lampp stop'
alias databases-restart='sudo /opt/lampp/lampp restart'

# Git Aliases
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"

alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias gc-fix='git commit --amend --no-edit'

alias gp='git push'
alias gu='git pull'

alias gl='git log --all --graph --pretty=oneline --abbrev-commit'
alias glclean='git log --all --graph --pretty=oneline --abbrev-commit --simplify-by-decoration'
alias gb='git branch'

alias gi='git init'
alias gcl='git clone'
alias gs='git status --short'
