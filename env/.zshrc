# ═══════════════════════════════════════════════════════════════════════════════
# ZSH Configuration - Enhanced and Well-Organized
# ═══════════════════════════════════════════════════════════════════════════════

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ─── Performance Optimizations ──────────────────────────────────────────────
# Skip verification of insecure directories (speeds up startup)
ZSH_DISABLE_COMPFIX="true"

# Lazy load NVM (if you use Node.js) - uncomment if needed
# export NVM_LAZY_LOAD=true

# ─── Theme Configuration ─────────────────────────────────────────────────────
ZSH_THEME="robbyrussell"
# Better alternatives to consider:
# ZSH_THEME="agnoster"           # Requires Powerline fonts
# ZSH_THEME="spaceship"          # Modern, informative theme
# ZSH_THEME="powerlevel10k/powerlevel10k"  # Fastest, most customizable

# ─── Oh My Zsh Settings ──────────────────────────────────────────────────────
HYPHEN_INSENSITIVE="true"              # Case-insensitive tab completion
ENABLE_CORRECTION="true"               # Enable command auto-correction
COMPLETION_WAITING_DOTS="true"         # Show dots while waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true"   # Faster git status for large repos

# Auto-update settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# ─── Completion Enhancements ─────────────────────────────────────────────────
# Better completion for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# ─── Plugin Configuration ────────────────────────────────────────────────────
plugins=(
  git                    # Git aliases and functions
  sudo                   # Double-tap ESC to add sudo
  history               # History navigation improvements
  history-substring-search  # Up/down arrow history search
  encode64              # Base64 encoding/decoding
  copypath              # Copy current path to clipboard
  command-not-found     # Suggest packages for missing commands
  colored-man-pages     # Colorized man pages
  extract               # Universal extract function (remove custom one below)
  z                     # Jump to frequently used directories
  docker                # Docker completion (if you use Docker)
  kubectl               # Kubernetes completion (if you use k8s)
  zsh-autosuggestions   # Command suggestions based on history (install separately)
  zsh-syntax-highlighting # Syntax highlighting - MUST BE LAST!
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ─── User Configuration ──────────────────────────────────────────────────────

# Language environment
export LANG=en_US.UTF-8

# Editor preference (fallback chain)
if command -v nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
elif command -v vim >/dev/null 2>&1; then
  export EDITOR='vim'
else
  export EDITOR='nano'
fi

# ─── Aliases ─────────────────────────────────────────────────────────────────

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'  # Go to previous directory

# Enhanced tools (use modern alternatives if available)
command -v nvim >/dev/null 2>&1 && alias vim='nvim' && alias vi='nvim'
command -v bat >/dev/null 2>&1 && alias cat='bat --style=plain' && alias catt='bat'
command -v rg >/dev/null 2>&1 && alias grep='rg'
command -v fd >/dev/null 2>&1 && alias find='fd'
command -v htop >/dev/null 2>&1 && alias top='htop'
command -v btm >/dev/null 2>&1 && alias htop='btm'
command -v dust >/dev/null 2>&1 && alias du='dust'
command -v duf >/dev/null 2>&1 && alias df='duf'

# Git aliases (only add what's not covered by Oh My Zsh git plugin)
alias glog='git log --oneline --graph --decorate --all'
alias gloga='git log --oneline --graph --decorate --all --author="$(git config user.name)"'
alias gundo='git reset HEAD~1'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git log -n 1 | grep -q -c "WIP" && git reset HEAD~1'

# System management
alias reload='source ~/.zshrc'
alias zshconfig='$EDITOR ~/.zshrc'
alias hyprconfig='$EDITOR ~/.config/hypr/hyprland.conf'

# Safe file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Network and system info
alias myip='curl -s https://ipinfo.io/ip'
alias localip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

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

# Quick find function (better than the built-in)
ff() {
  if command -v fd >/dev/null 2>&1; then
    fd "$1"
  else
    find . -type f -name "*$1*" 2>/dev/null
  fi
}

# Process grep with better formatting
pgrep() {
  ps aux | grep -v grep | grep --color=always "$1"
}

# Weather function
weather() {
  local city="${1:-Stockholm}"
  curl -s "wttr.in/$city?format=3"
}

# Quick backup function
backup() {
  cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Extract with better error handling (remove if using extract plugin)
# extract() {
#   if [ -z "$1" ]; then
#     echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
#     return 1
#   fi
#
#   if [ -f "$1" ]; then
#     case "$1" in
#       *.tar.bz2)   tar xjf "$1"     ;;
#       *.tar.gz)    tar xzf "$1"     ;;
#       *.tar.xz)    tar xJf "$1"     ;;
#       *.lzma)      unlzma "$1"      ;;
#       *.bz2)       bunzip2 "$1"     ;;
#       *.rar)       unrar x -ad "$1" ;;
#       *.gz)        gunzip "$1"      ;;
#       *.tar)       tar xf "$1"      ;;
#       *.tbz2)      tar xjf "$1"     ;;
#       *.tgz)       tar xzf "$1"     ;;
#       *.zip)       unzip "$1"       ;;
#       *.Z)         uncompress "$1"  ;;
#       *.7z)        7z x "$1"        ;;
#       *.xz)        unxz "$1"        ;;
#       *.exe)       cabextract "$1"  ;;
#       *)           echo "extract: '$1' - unknown archive method" ;;
#     esac
#   else
#     echo "'$1' - file does not exist"
#     return 1
#   fi
# }

# ─── Plugin Specific Settings ────────────────────────────────────────────────

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# History configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# Directory options
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt AUTO_PUSHD           # make cd push old directory to directory stack
setopt PUSHD_IGNORE_DUPS    # don't push duplicates to directory stack
setopt PUSHD_SILENT         # don't print directory stack after pushd or popd

# ═══════════════════════════════════════════════════════════════════════════════
# End of configuration
# ═══════════════════════════════════════════════════════════════════════════════
