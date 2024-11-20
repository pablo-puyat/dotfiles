# Set editor
export EDITOR="nvim"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt TRANSIENT_RPROMPT

# Aliases
alias llt='ls -alFt'
alias lt='ls -lAt'
alias l='ls -1'
alias lr='ls -CFtr'
alias gs='git status '
alias gaa='git add .'
alias ga='git add '
alias gb='git -P branch '
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout '
alias gl='git log'
alias g='git '
alias gp='git -P'
alias gclone='git clone '
alias glog='git -P log'
alias h='history | grep -i '
alias ip='ifconfig | grep inet\ '
alias e='nvim '
alias tm='tmux new -s $(basename $PWD)'

# Functions
function qf { find . -name "*${1}*" }
function smush { cat $1 | tr '\n' ' ' }
function dsh { docker exec -it $1 sh }
function dbash { docker exec -it $1 bash }
function dps { docker ps }
function dpsa { docker ps -a }

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Vi mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
PROMPT='
%F{black}%B%m %~%b%f $(git_branch)
%F{green}%B%(!.#.$)%b%f '

# Git branch function
git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch != "" ]]; then
        echo '%F{blue}%B \ue0a0 '$branch'%b%f'
    fi
}

# Load additional configurations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshenv ] && source ~/.zshenv

