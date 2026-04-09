HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
EDITOR=nvim
setopt autocd
setopt NO_BEEP

source ~/.config/zsh/vi-config.zsh

# fzf-tab 
export FZF_DEFAULT_OPTS="--cycle --bind 'tab:down,btab:up'"
source ~/.config/zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^I' fzf_completion

# auto-suggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax-highlight
source ~/.config/zsh/zsh-syntax-highlight/zsh-syntax-highlighting.zsh

# Re-entrancy guard for zle-keymap-select to stop recursion loops
typeset -gi _ZKMS_GUARD=0

# Save original if exists and not already saved
if (( ! $+functions[zle_keymap_select_original] )) && (( $+functions[zle-keymap-select] )); then
  functions[zle_keymap_select_original]=$functions[zle-keymap-select]
fi

my_keymap_select_guard() {
  if (( _ZKMS_GUARD > 0 )); then
    return 0
  fi
  (( _ZKMS_GUARD++ ))

  # Your optional logic (e.g., cursor shape by mode) goes here.
  # DO NOT call `zle zle-keymap-select` from here; call the original if saved.
  if (( $+functions[zle_keymap_select_original] )); then
    zle zle_keymap_select_original
  fi

  (( _ZKMS_GUARD-- ))
}

# Install guarded wrapper (last writer wins)
zle -N zle-keymap-select my_keymap_select_guard
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

export NVM_DIR=~/.nvm
source /usr/share/nvm/nvm.sh

source ~/.config/zsh/aliases.zsh
