# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

EDITOR="vim"

#DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/aliases

eval "$(fasd --init auto)"

# vi mode start
setopt transientrprompt
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
zle -N edit-command-line
bindkey -v 
bindkey -M vicmd 'e' edit-command-line
bindkey "^[OA" history-search-backward
bindkey "^[OB" history-search-forward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward

MODE_INDICATOR="%{$fg[white]%}%{$fg_bold[black]$bg[white]%} INSERT %{$reset_color%}"
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}
RPS1='$(vi_mode_prompt_info)'
# vi mode end

fpath=(~/.zsh/completions $fpath)

PROMPT='
%{$fg_bold[white]%}%M %~
%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

#
# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/taprice/Desktop/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/taprice/Desktop/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/taprice/Desktop/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/taprice/Desktop/google-cloud-sdk/completion.zsh.inc'
fi

source $(brew --prefix php-version)/php-version.sh && php-version 7
