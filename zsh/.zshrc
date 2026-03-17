# =============================================================================
# 1. PATH & ENVIRONMENT VARIABLES
# =============================================================================
# Prepend local bins
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Go Path (Optimized: avoiding `go env` subshell to speed up startup)
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$PATH:$GOPATH/bin"

# Haskell / GHCup
export HLS_VERSION="2.13.0.0"
export PATH="$HOME/.ghcup/bin:$HOME/.ghcup/hls/$HLS_VERSION/lib/haskell-language-server-$HLS_VERSION/bin:$PATH"

# Neovim Default
export EDITOR="nvim"
export VISUAL="nvim"

# =============================================================================
# 2. OH MY ZSH CONFIGURATION
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnosterzak"

# Optimized Plugins: Removed 'zsh-syntax-highlighting' and 'fzf'
plugins=(git dnf fast-syntax-highlighting fzf zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# =============================================================================
# 3. HISTORY SETTINGS
# =============================================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# =============================================================================
# 4. TOOL INITIALIZATION
# =============================================================================
# FZF (Modern binary integration)
source <(fzf --zsh)

# Cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# GHCup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# NVM (Lazy-Loaded)
export NVM_DIR="$HOME/.nvm"

# The function that actually loads NVM when triggered
_load_nvm() {
    # Delete the wrapper functions so they don't loop
    unset -f nvm node npm npx yarn pnpm
    
    # Source NVM
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

# Create placeholder functions for common Node tools
for cmd in nvm node npm npx yarn pnpm; do
    eval "${cmd}() { _load_nvm; ${cmd} \"\$@\"; }"
done


# =============================================================================
# 5. ALIASES & FUNCTIONS
# =============================================================================
# Load bash aliases if they exist
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Aliases
lampp-manager() {
    sudo /opt/lampp/manager-linux-x64.run
}

# SuperFile cd_on_quit
spf() {
    local os=$(uname -s)

    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    elif [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    if [ -f "$SPF_LAST_DIR" ]; then
        source "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    fi
}

# Wrapper function to make 'list --pick' type into the prompt
list() {
    if [[ "$1" == "--pick" ]]; then
        # Run the actual script, grab the fzf output, and save it to a variable
        local picked_app=$(command list --pick)
        
        # If you actually picked something (didn't press Esc), push it to the typing area!
        if [[ -n "$picked_app" ]]; then
            print -z "$picked_app"
        fi
    else
        # If you type anything else (like 'list -e' or 'list'), just run the normal script
        command list "$@"
    fi
}
