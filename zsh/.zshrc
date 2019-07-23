# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

EDITOR="vim"

# setopts start
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt TRANSIENT_RPROMPT
# setopts end

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
# start aliases
# ls
alias ll='ls -alF'
alias llt='ls -alFt'
alias la='ls -lA'
alias lt='ls -lAt'
alias l='ls -CF'
alias lr='ls -CFtr'

# tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tn='tmux new-session -s '
function tur { ssh $1 -t "tmux attach-session -t ${1:gs/\./-} || tmux new-session -s ${1:gs/\./-}"; }

# git
alias gs='git status '
alias ga='git add '
alias gaa='git add .'
alias gb='git branch '
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gco='git checkout '
alias gh='git hist'
alias gl='git log'

# fasd
alias v='f -e vim'
alias o='a -e open'

# misc
alias histg='history | grep -i '
alias ip='ifconfig | grep inet\ '
function qf { find . -name "*${1}*" }
function copy { cat ${1} | pbcopy }
function smush { cat $1 | tr '\n' ' ' }
alias ci='code-insiders '
# vim
function vimp {  print -z "vim --servername ${1} -S ~/.vim/sessions/${1}" }
function v { vim --servername scratch --remote $1 }
alias update_vim='vim +BundleInstall! +BundleClean'

# google cloud
alias gssh="gcloud compute config-ssh --remove && gcloud compute config-ssh"

# kubernetes
alias k="kubectl"
alias g="gcloud"
alias d="docker"
alias dc="docker-compose"
alias dcrebuild="docker-compose down -v && docker-compose up --build"
function dsh { docker exec -it $1 sh }
function dbash { docker exec -it $1 bash }
alias h="hyper"
alias hc="hyper compose"
# end aliases

# start completions
compdef tur=ssh
# end completions
eval "$(fasd --init auto)"

# vi mode start
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

if [ -f ~/.zsh/environment ]; then
  source ~/.zsh/environment
fi
