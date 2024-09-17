# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="agnoster"
ZSH_THEME=""

EDITOR="nvim"
SAVEHIST=10000
HISTSIZE=10000
HISTDUP=erase

setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt TRANSIENT_RPROMPT

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
# start aliases
# ls
alias llt='ls -alFt'
alias lt='ls -lAt'
alias l='ls -1'
alias lr='ls -CFtr'

# git
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

# misc
alias h='history | grep -i '
alias ip='ifconfig | grep inet\ '
alias e='nvim '

alias phpdoc="docker run --rm -v $(pwd):/data phpdoc/phpdoc:3"

function qf { find . -name "*${1}*" }
function copy { cat ${1} | pbcopy }
function smush { cat $1 | tr '\n' ' ' }

function dsh { docker exec -it $1 sh }
function dbash { docker exec -it $1 bash }
function dps { docker ps }
function dpsa { docker ps -a }
alias sail="./vendor/bin/sail"
# end aliases

#eval "$(ssh-agent -s)"

# start completions
compdef tur=ssh
fpath=(~/.zsh/completions $fpath)

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

MODE_INDICATOR="%{$fg[black]%}%{$fg_bold[black]$bg[white]%} INSERT %{$reset_color%}"
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

RPS1='$(vi_mode_prompt_info)'
# vi mode end

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'

git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        echo ' \ue0a0 '$branch
    fi
}

PROMPT='
%{$fg_bold[black]%}%M %~ $(git_branch)
%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}%{$fg_bold[blue]%} % %{$reset_color%}'

#RPROMPT=\$vcs_info_msg_0_

eval "$(zoxide init zsh)"
if [ -f ~/.zsh/environment ]; then
  source ~/.zsh/environment
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function ya() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
eval "$(atuin init zsh)"
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PATH="/Users/thomas/Library/Python/3.9/bin:$PATH"
export PATH="/Users/thomas/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

