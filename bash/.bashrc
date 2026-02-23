# .bashrc

# Pre-script to change shell depending on desktop session
if [[ "$XDG_SESSION_DESKTOP" == "hyprland" ]]; then
    exec zsh
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Set defeault editor
export VISUAL=vim
export EDITOR=nano

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER="less -FRSX"
export PAGER="less -FRSX"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Python Specific Environment for Pipenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Export for PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig

# SuperFile cd_on_quit
spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
. "$HOME/.cargo/env"

# Ensure SSH agent runs everytime the shell is opened
# eval "$(ssh-agent)"

# Aliases for programs cause I am tired of MEMORISING THEM!
lampp-manager() {
    sudo /opt/lampp/manager-linux-x64.run
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Launch tmux upon opening terminal
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux_pids=$(pgrep tmux | wc -l)

    if [ "$tmux_pids" -eq 0 ]; then
        # No server → start "main"
        tmux new-session -s main -A -d
    elif [ "$tmux_pids" -eq 1 ]; then
        # Server running, no client → attach to main
        if tmux has-session -t main 2>/dev/null; then
            tmux attach-session -t main
        else
            tmux new-session -s main -A -d
        fi
    else
        # Server + client(s) → create new numbered session
        i=0
        while tmux has-session -t "$i" 2>/dev/null; do
            i=$((i+1))
        done
        tmux new-session -s "$i" -A -d
    fi
fi

# Go lang Path
export PATH=$PATH:$(go env GOPATH)/bin
