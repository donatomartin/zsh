bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
bindkey -M viins '^W' backward-kill-word

# -> system clipboard via OSC52 (works over SSH/tmux) ---
# --- vi yank
_clip() {
  # If inside tmux, use passthrough so the outer terminal receives OSC52
  if [[ -n "$TMUX" ]]; then
    printf '\ePtmux;\e\e]52;c;%s\a\e\\' "$(printf %s "$1" | base64 | tr -d '\n')"
  else
    printf '\e]52;c;%s\a' "$(printf %s "$1" | base64 | tr -d '\n')"
  fi
}

vi_yank_and_clip() { zle vi-yank; _clip "$CUTBUFFER"; }
zle -N vi_yank_and_clip
bindkey -M vicmd 'y'  vi_yank_and_clip
bindkey -M vicmd 'Y'  vi_yank_and_clip
bindkey -M vicmd 'yy' vi_yank_and_clip

zstyle :compinstall filename '/home/donato/.zshrc'
zstyle ':completion:*' menu select


autoload -Uz compinit
compinit

# --- vi paste
vi_paste_from_clip() {
  # Get clipboard, remove Windows carriage returns, and strip trailing newlines
  local content
  content=$(powershell.exe -NoProfile -Command "Get-Clipboard" 2>/dev/null | tr -d '\r')
  
  if [[ -n "$content" ]]; then
    # Set the Zsh internal buffer
    KILLRECT=""
    CUTBUFFER="$content"
    # standard vi-put-after (lowercase p)
    zle vi-put-after
  fi
}
# Register and bind
zle -N vi_paste_from_clip
bindkey -M vicmd 'p' vi_paste_from_clip

