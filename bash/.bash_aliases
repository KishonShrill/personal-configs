# ~/.bash_aliases
alias vi='vim'
alias py='python'
alias supy='sudo python'
alias ..='cd ..'
alias update='sudo dnf upgrade'

# Terminal App w/ Extra Steps
alias copyparty-c='copyparty -c /home/perseque/.config/copyparty/foobar.conf --qr'

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
alias gb='git branch'

alias gi='git init'
alias gcl='git clone'
alias gs='git status --short'

