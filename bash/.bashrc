# .bashrc

# =============================================================================
# 1. SHELL HAND-OFF & GLOBALS
# =============================================================================
# Pre-script: Immediately hand off to Zsh if running under Hyprland
if [[ "$XDG_SESSION_DESKTOP" == "hyprland" ]]; then
    exec zsh
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# =============================================================================
# 2. ENVIRONMENT VARIABLES & PATH
# =============================================================================
# Default Editors
export VISUAL=vim
export EDITOR=nano

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER="less -FRSX"
export PAGER="less -FRSX"

# Export for PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Go Path (Optimized to avoid slow subshell)
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$PATH:$GOPATH/bin"

# Haskell / GHCup
export HLS_VERSION="2.13.0.0"
export PATH="$HOME/.ghcup/bin:$HOME/.ghcup/hls/$HLS_VERSION/lib/haskell-language-server-$HLS_VERSION/bin:$PATH"


# =============================================================================
# 3. TOOL INITIALIZATION
# =============================================================================
# Python / Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Cargo / Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# GHCup Environment
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Atuin (History)
. "$HOME/.atuin/bin/env"
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"


# =============================================================================
# 4. ALIASES & SOURCING
# =============================================================================
# User specific aliases and functions (.bashrc.d directory)
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
    unset rc
fi

# Standard Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# =============================================================================
# 5. CUSTOM FUNCTIONS
# =============================================================================
# XAMPP Manager Shortcut
lampp-manager() {
    sudo /opt/lampp/manager-linux-x64.run
}

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
