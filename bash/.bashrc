# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# --- Basic PATH setup ---
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# --- Environment Variables ---
export VISUAL=vim
export EDITOR=nano
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

# --- Load aliases ---
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# --- pyenv setup ---
if ! command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    # Initialize pyenv
    eval "$(pyenv init - bash)"
fi

# --- Herd Lite ---
if [[ ":$PATH:" != *":$HOME/.config/herd-lite/bin:"* ]]; then
    export PATH="$HOME/.config/herd-lite/bin:$PATH"
    export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
fi

# --- Cargo ---
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --- Atuin ---
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

# --- Go ---
if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

# --- SuperFile ---
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



# [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh



# --- Tmux auto-launch ---
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

