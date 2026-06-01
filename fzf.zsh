# fzf-tab 
export FZF_DEFAULT_OPTS="--cycle --bind 'tab:down,btab:up'"
source ~/.config/zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^I' fzf_completion

# Save original if exists and not already saved
if (( ! $+functions[zle_keymap_select_original] )) && (( $+functions[zle-keymap-select] )); then
  functions[zle_keymap_select_original]=$functions[zle-keymap-select]
fi

eval "$(fzf --zsh)"
