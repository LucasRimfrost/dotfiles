#
# ~/.zprofile - zsh login shell configuration
# Executed for login shells before .zshrc
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

# Default applications
export EDITOR='nvim'
export BROWSER='brave'
export TERMINAL='alacritty'

# Wayland environment variables for Hyprland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

# Qt applications Wayland support
export QT_QPA_PLATFORM="wayland;xcb"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORMTHEME=qt6ct

# GTK applications Wayland support
export GDK_BACKEND=wayland,x11
export MOZ_ENABLE_WAYLAND=1

# Java applications Wayland compatibility
export _JAVA_AWT_WM_NONREPARENTING=1

# Cursor configuration
export XCURSOR_SIZE=16

# Load .zshrc if it exists and we're interactive
[[ -f ~/.zshrc ]] && . ~/.zshrc
