# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Set default editor
export VISUAL=vim
export EDITOR=nano

# Set global variables
export PAGER="less -FRSX"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Aliases for terminal programs
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Python Specific Environment for Pipenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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

# Go Path Directory
export GOPATH="$HOME/go"

# Launch tmux upon opening terminal
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux_pids=$(pgrep tmux | wc -l)

    if [ "$tmux_pids" -eq 0 ]; then
        # No server → start "main"
        tmux new-session -s main
    elif [ "$tmux_pids" -eq 1 ]; then
        # Server running, no client → attach to main
        if tmux has-session -t main 2>/dev/null; then
            tmux attach-session -t main
        else
            tmux new-session -s main
        fi
    else
        # Server + client(s) → create new numbered session
        i=0
        while tmux has-session -t "$i" 2>/dev/null; do
            i=$((i+1))
        done
        tmux new-session -s "$i"
    fi
fi

