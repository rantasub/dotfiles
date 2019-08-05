HISTFILE='~/.cache/zsh/histfile'
HISTSIZE=10000
SAVEHIST=${HISTSIZE}

setopt complete_aliases
setopt correctall
setopt hist_ignore_space
setopt prompt_subst
unsetopt beep

autoload -U compinit
autoload -U promptinit
compinit
promptinit

# Random quote from fortune-mod
fortune

export _FASD_DATA="${XDG_DATA_HOME}/fasd/data_file"
export ZPLUG_HOME="${XDG_DATA_HOME}/zplug"
export ZPLUG_CACHE_DIR="${XDG_CACHE_HOME}/zplug"
source /usr/share/zsh/scripts/zplug/init.zsh

zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/git-prompt", from:oh-my-zsh
zplug "plugins/last-working-dir", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"

zplug load

precmd() { print '' }
export PROMPT='%F{green}%B%~%b%f $(git_super_status)$ '
export RPROMPT='$(vi_mode_prompt_info)'

# Include shell aliases
if [ -r ~/.config/shell/aliases ]; then
    source ~/.config/shell/aliases
fi
