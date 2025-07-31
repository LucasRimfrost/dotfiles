# ═══════════════════════════════════════════════════════════════════════════════
# ZSH Configuration - Enhanced and Well-Organized
# ═══════════════════════════════════════════════════════════════════════════════

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ─── Theme Configuration ─────────────────────────────────────────────────────
ZSH_THEME="robbyrussell"
# Alternative themes to try:
# ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# ─── Oh My Zsh Settings ──────────────────────────────────────────────────────
HYPHEN_INSENSITIVE="true"              # Case-insensitive tab completion
ENABLE_CORRECTION="true"               # Enable command auto-correction
COMPLETION_WAITING_DOTS="true"         # Show dots while waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true"   # Faster git status for large repos

# Auto-update settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# ─── Plugin Configuration ────────────────────────────────────────────────────
plugins=(
  git                    # Git aliases and functions
  sudo                   # Double-tap ESC to add sudo
  history               # History navigation improvements
  encode64              # Base64 encoding/decoding
  copypath              # Copy current path to clipboard
  command-not-found     # Suggest packages for missing commands
  colored-man-pages     # Colorized man pages
  extract               # Universal extract function
  z                     # Jump to frequently used directories
  zsh-autosuggestions   # Command suggestions based on history
  zsh-syntax-highlighting # Syntax highlighting for commands
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ─── User Configuration ──────────────────────────────────────────────────────

# Language environment
export LANG=en_US.UTF-8

# ─── Aliases ─────────────────────────────────────────────────────────────────

# Enhanced ls aliases (use exa if available, fallback to ls)
if command -v exa >/dev/null 2>&1; then
  alias ls='exa --icons'
  alias ll='exa -la --icons --git --header'
  alias la='exa -a --icons'
  alias tree='exa --tree --icons --level=3'
else
  alias ll='ls -alF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'
fi

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Enhanced tools (use modern alternatives if available)
command -v nvim >/dev/null 2>&1 && alias vim='nvim' && alias vi='nvim'
command -v bat >/dev/null 2>&1 && alias cat='bat --style=plain'
command -v rg >/dev/null 2>&1 && alias grep='rg'

# Git aliases (enhanced)
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias glog='git log --oneline --graph --decorate'

# System management
alias reload='source ~/.zshrc'
alias zshconfig='$EDITOR ~/.zshrc'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh'

# Application aliases
alias missioncenter='flatpak run io.missioncenter.MissionCenter >/dev/null 2>&1 &'

# Development shortcuts
alias projects='cd ~/dev/personal/'
alias dev='cd ~/dev/'
alias dotfiles='cd ~/.dotfiles/'

# ─── Custom Functions ────────────────────────────────────────────────────────

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive format
extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1     ;;
          *.tar.gz)    tar xzf $1     ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xf $1      ;;
          *.tbz2)      tar xjf $1     ;;
          *.tgz)       tar xzf $1     ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

# Quick find function
ff() {
  find . -type f -name "*$1*"
}

# Process grep
pgrep() {
  ps aux | grep -v grep | grep "$1"
}

# ─── Plugin Specific Settings ────────────────────────────────────────────────

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# ─── Key Bindings ────────────────────────────────────────────────────────────
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ═══════════════════════════════════════════════════════════════════════════════
# End of configuration
# ═══════════════════════════════════════════════════════════════════════════════
