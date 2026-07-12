# 1. NVM CONFIGURATION
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 2. LOCAL ZIMFW CONFIGURATION
export ZIM_HOME="/Users/lewis/.config/zsh/.zim"

# Build static init script if missing or out of date
if [[ ! -s ${ZIM_HOME}/init.zsh ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi

# Load Zim modules safely
source ${ZIM_HOME}/init.zsh

# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/alias" ] && source "$XDG_CONFIG_HOME/alias"
# [ -f "$CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# cmp opts
# zstyle ':completion:*' menu select # tab opens cmp menu
# zstyle ':completion:*' special-dirs false # force . and .. to show in cmp menu
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list false # more detailed list
# zstyle ':completion:*' squeeze-slashes true # explicit disable to allow /*/ expansion

# load modules
# zmodload zsh/complist
# autoload -Uz compinit && compinit -C
# autoload -U colors && colors
# autoload -U tetris # main attraction of zsh, obviously
# source /usr/share/nvm/init-nvm.sh
# source "$HOME/.config/sct/openweather.env"

# experimenting for the slash to be seen as delimiter
WORDCHARS=${WORDCHARS/\/}

# main opts
# setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
# setopt auto_menu menu_complete # autocmp first menu match
# setopt autocd # type a dir to cd
# setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
# setopt no_case_glob no_case_match # make cmp case insensitive
# setopt globdots # include dotfile
# setopt extended_glob # match ~ # ^
# setopt interactive_comments # allow comments in shell
# unsetopt prompt_sp # don't autoclean blanklines
# stty stop undef # disable accidental ctrl s

# history opts
# HISTSIZE=1000000
# SAVEHIST=1000000
# HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
# HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# open fff file manager with ctrl f
# openfff() {
#  fff <$TTY
#  zle redisplay
#}
#zle -N openfff
#bindkey '^f' openfff


# set up prompt
# PROMPT="%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme



GEM_HOME="/opt/homebrew/lib/ruby/gems/4.0.0/bin"
PATH="$PATH:$GEM_HOME/bin"

# cmp opts
# zstyle ':completion:*' menu select # tab opens cmp menu
# zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
# zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# precmd() { vcs_info }
#
short_pwd() {
local max_last=12
local dir="${PWD/#$HOME/~}"
local -a parts
parts=("${(@s:/:)dir}")

local out=""
local last=$#parts

for ((i=1; i<=last; i++)); do
local p="${parts[i]}"

if (( i < last )); then
  [[ -n "$p" ]] && out+="${p[1]}/"
else
  (( ${#p} > max_last )) && p="${p[1,$((max_last-1))]}…"
  out+="$p"
fi

done

print -r -- "$out"
}
C_PATH="#88c0d0"
C_TIME="#a89984"
C_OK="#8eb69b"
C_ERR="#F73718"
C_BRANCH="#c8b3f6"
C_DIRTY="#F73718"

S_BRANCH=""
S_AHEAD="↑"
S_BEHIND="↓"
S_STAGED="✚"
S_UNSTAGED="●"
S_PROMPT="❯"

paint() {
print -rn -- "%F{$1}$2%f"
}

git_count() {
git rev-list --count "$1" 2>/dev/null
}
git_prompt() {
git rev-parse --is-inside-work-tree &>/dev/null || return

local branch upstream ahead=0 behind=0 out

branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD)
upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null)

[[ -n "$upstream" ]] && {
ahead=$(git_count "${upstream}..HEAD")
behind=$(git_count "HEAD..${upstream}")
}

out=" $(paint $C_BRANCH "$S_BRANCH $branch")"

(( ahead > 0 )) && out+=" $(paint $C_OK "$S_AHEAD$ahead")"
(( behind > 0 )) && out+=" $(paint $C_ERR "$S_BEHIND$behind")"

git diff --quiet --cached --ignore-submodules 2>/dev/null ||
out+=" $(paint $C_OK $S_STAGED)"

git diff --quiet --ignore-submodules 2>/dev/null ||
out+=" $(paint $C_DIRTY $S_UNSTAGED)"

print -r -- "$out"
}
setopt prompt_subst
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:git*' formats "  %F{#c8b3f6}%b%f %m%u%c %a %S"
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{#8eb69b}✚%f'
zstyle ':vcs_info:*' unstagedstr ' %F{#630025}●%f'
zstyle ':vcs_info:' get-revision true
zstyle ':vcs_info:git:' formats ' %F{magenta} %b%f%m%u%c'
zstyle ':vcs_info:git:*' actionformats ' %F{#680025} %b|%a%f'

# PROMPT=' burn%B%F{#F73718} %F{cyan}%~%f$(git_status) %B%F{#FF00E4}%f%b '
# PROMPT=' burn%B%F{#F73718} %F{cyan}%~%f${vcs_info_msg_0_} %B%F{#FF00E4}%f%b '

setopt prompt_subst

# RPROMPT='$(paint $C_TIME "%*")'

PROMPT='%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M) %f%k $(paint $C_PATH "$(short_pwd)")$(git_prompt)
%(?.$(paint $C_OK $S_PROMPT).$(paint $C_ERR $S_PROMPT)) '

# echo -e "\x1b[38;5;137m\x1b[48;5;0m it's$(print -p '%d{%_i:%m%p}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
# bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^H" backward-kill-word
# ctrl J & K for going up and down in prev commands
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget
bindkey -e # for emacs e and vim v 

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[Up]" history-beginning-search-backward
bindkey "^[Down]" history-beginning-search-forward

# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(git)
# source $ZSH/oh-my-zsh.sh


#docker alias
# alias dsa='docker stop $(docker ps -q)'
# alias dra='docker rm $(docker ps -a -q)'

# Shell integrations
# eval "$(fzf --zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# bindkey '^O' autosuggest-toggle
export PATH="$HOME/.local/bin:$PATH"
