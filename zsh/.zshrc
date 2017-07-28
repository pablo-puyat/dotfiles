# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

#DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/aliases

PROMPT='
%{$fg_bold[white]%}%M %~
%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

eval "$(fasd --init auto)"
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
fpath=(~/.zsh/completions $fpath)
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
