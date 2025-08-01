#
# ~/.zprofile - zsh login shell configuration
#

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Path modifications
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# Java configuration
export JAVA_HOME=/usr/lib/jvm/java-21-temurin
export PATH=$JAVA_HOME/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1

# Default applications
export EDITOR='nvim'
export BROWSER='brave'
export TERMINAL='alacritty'

# Additional reliability variables for laptop use
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland,x11
export ANKI_WAYLAND=1

# Hardware acceleration
export LIBVA_DRIVER_NAME=iHD  # or "radeonsi" for AMD
export VDPAU_DRIVER=va_gl

# Load .zshrc if it exists and we're interactive
[[ -f ~/.zshrc ]] && . ~/.zshrc
