# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# --- basic path setup ---
if ! [[ "$path" =~ "$home/.local/bin:$home/bin:" ]]; then
    path="$home/.local/bin:$home/bin:$path"
fi
export path

# --- environment variables ---
export visual=vim
export editor=nano
export pager="less -frsx"

# uncomment the following line if you don't like systemctl's auto-paging feature:
# export systemd_pager=

# user specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# --- load aliases ---
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# --- pyenv setup ---
if ! command -v pyenv >/dev/null 2>&1; then
    export pyenv_root="$home/.pyenv"
    export path="$pyenv_root/bin:$path"

    # initialize pyenv
    eval "$(pyenv init - bash)"
fi

# --- herd lite ---
if [[ ":$path:" != *":$home/.config/herd-lite/bin:"* ]]; then
    export path="$home/.config/herd-lite/bin:$path"
    export php_ini_scan_dir="$home/.config/herd-lite/bin:$php_ini_scan_dir"
fi

# --- cargo ---
[ -f "$home/.cargo/env" ] && . "$home/.cargo/env"

# --- atuin ---
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

# --- go ---
if [[ ":$path:" != *":/usr/local/go/bin:"* ]]; then
    export path="$path:/usr/local/go/bin"
fi

# --- superfile ---
spf() {
    os=$(uname -s)

    # linux
    if [[ "$os" == "linux" ]]; then
        export spf_last_dir="${xdg_state_home:-$home/.local/state}/superfile/lastdir"
    fi

    # macos
    if [[ "$os" == "darwin" ]]; then
        export spf_last_dir="$home/library/application support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$spf_last_dir" ] || {
        . "$spf_last_dir"
        rm -f -- "$spf_last_dir" > /dev/null
    }
}



# [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh



# --- tmux auto-launch ---
if command -v tmux &>/dev/null && [ -z "$tmux" ]; then
    tmux_pids=$(pgrep tmux | wc -l)

    if [ "$tmux_pids" -eq 0 ]; then
        # no server → start "main"
        tmux new-session -s main
    elif [ "$tmux_pids" -eq 1 ]; then
        # server running, no client → attach to main
        if tmux has-session -t main 2>/dev/null; then
            tmux attach-session -t main
        else
            tmux new-session -s main
        fi
    else
        # server + client(s) → create new numbered session
        i=0
        while tmux has-session -t "$i" 2>/dev/null; do
            i=$((i+1))
        done
        tmux new-session -s "$i"
    fi
fi

