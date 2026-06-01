HISTFILE=~/.histfile
HISTSIZE=100
SAVEHIST=100
EDITOR=nvim

setopt autocd
setopt NO_BEEP

source ~/.config/zsh/vi.zsh
source ~/.config/zsh/fzf.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source ~/.config/zsh/aliases.zsh

# Machine specific gitignored aliases
if [ -s "$HOME/.config/zsh/aliases.local.zsh" ]; then
  source ~/.config/zsh/aliases.local.zsh
fi

# Machine specific gitignored config
if [ -s "$HOME/.config/zsh/config.local.zsh" ]; then
  source ~/.config/zsh/config.local.zsh
fi
