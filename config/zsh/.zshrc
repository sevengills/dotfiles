# zmodload zsh/zprof
[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.cache/wal/sequences ] && cat ~/.cache/wal/sequences 2>/dev/null
export TERM=xterm-256color
		
# source global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs false # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' file-list false # more detailed list
zstyle ':completion:*' squeeze-slashes true # explicit disable to allow /*/ expansion

# load modules
zmodload zsh/complist
autoload -Uz compinit && compinit -C
autoload -U colors && colors
# autoload -U tetris # main attraction of zsh, obviously
# source /usr/share/nvm/init-nvm.sh
# source "$HOME/.config/sct/openweather.env"

# experimenting for the slash to be seen as delimiter
WORDCHARS=${WORDCHARS/\/}

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfile
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved


# fzf setup
# source <(fzf --zsh) # allow for fzf history widget


# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^l" forward-word
bindkey "^w" backward-kill-word
# ctrl J & K for going up and down in prev commands
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^R' fzf-history-widget
bindkey '^[l' down-case-word
bindkey '^ ' autosuggest-accept
bindkey '^f' forward-word
bindkey '^e' autosuggest-accept
# open fff file manager with ctrl f
# openfff() {
#  fff <$TTY
#  zle redisplay
#}
#zle -N openfff
#bindkey '^f' openfff


# set up prompt
# PROMPT="%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ -f "${ZINIT_HOME}/zinit.zsh" ]; then
  source "${ZINIT_HOME}/zinit.zsh"
fi
# [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
# [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
export NVM_DIR="$HOME/.nvm"

lazy_load_nvm() {
    unset -f nvm node npm npx

    [ -s /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
}

nvm() {
    lazy_load_nvm
    nvm "$@"
}

node() {
    lazy_load_nvm
    node "$@"
}

npm() {
    lazy_load_nvm
    npm "$@"
}

npx() {
    lazy_load_nvm
    npx "$@"
}
[ -f "$HOME/.config/sct/openweather.env" ] && source "$HOME/.config/sct/openweather.env"


# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


GEM_HOME="$(gem env user_gemhome)"
PATH="$PATH:$GEM_HOME/bin"
# powerlevel10 setup
# zinit ice depth=1; zinit light romkatv/powerlevel10k



# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -Uz vcs_info
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

# PROMPT="%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ 
setopt prompt_subst

# RPROMPT='$(paint $C_TIME "%*")'

PROMPT='%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %f%k $(paint $C_PATH "$(short_pwd)")$(git_prompt)
%(?.$(paint $C_OK $S_PROMPT).$(paint $C_ERR $S_PROMPT)) '

echo -e "\x1b[38;5;137m\x1b[48;5;0m it's$(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
[[ ":$PATH:" != *":$BUN_INSTALL/bin:"* ]] && export PATH="$BUN_INSTALL/bin:$PATH"

#docker
export DOCKER_HOST=unix:///var/run/docker.sock
# go hot reload
alias air='$HOME/go/bin/air'

#docker alias
alias dsa='docker stop $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'

# Shell integrations
# eval "$(fzf --zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"

bindkey '^O' autosuggest-toggle

function clear_screen_without_history() {
	printf '\033[H\033[2J'
	zle reset-prompt
}

zle -N clear_screen_without_history
# bindkey '^u' clear_screen_without_history

# swagger alias
# alias swag=${HOME}/go/bin/swag
# alias for nvim apps
alias nvim-vm="NVIM_APPNAME=nvim-vm nvim"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [ -f "$XDG_CONFIG_HOME/tmuxinator/init.yml" ]

# zprof

