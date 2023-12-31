# Key Binding
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Export
export EDITOR=vim

# History
export HISTFILE=~/.zsh/.histfile
export HISTSIZE=1000
export SAVEHIST=10000
setopt share_history
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_no_store
setopt hist_expand

# Colors
autoload -Uz colors
colors

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "~/.zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors di=34 ln=36 ex=33
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:manuals' separate-sections true

setopt correct
setopt complete_in_word
setopt always_last_prompt
setopt list_packed
setopt auto_list
setopt auto_menu
setopt globdots
setopt extended_glob
setopt auto_param_keys
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt magic_equal_subst
setopt nomatch
setopt nolistbeep
zle -N zle-keymap-select

# Alias
alias ls='ls --color=auto'

# Prompt
function echo_git_status() {
  declare -r git_status="$(git status --porcelain --branch 2>/dev/null)"

  if [[ -z $git_status ]]; then
    return
  fi

  declare -r git_branch="$(echo "$git_status" | sed -n '1p' | cut -c4-)"

  declare color="red"

  if [[ "$(echo "$git_status" | grep '^' -c -m 2)" -eq 1 ]]; then
    color="green"
  elif [[ "$(echo "$git_status" | grep -E '^\\?\\?|^[ MARC]M|^M[ MD]' -c -m 1)" -eq 1 ]]; then
    color="yellow"
  fi

  echo "%F{${color}}${git_branch}%f"
}

function echo_vi_mode() {
  case $KEYMAP in
    (vicmd); echo "|" ;;
    (vivis|vivli); echo "■" ;;
    (*); echo "%(!.#.>)" ;;
  esac
}

function echo_color_prev_return_code() {
  echo "%(?.%F{white}.%F{red})"
}

function echo_name() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%F{blue}%n@%m%f "
  fi
}

function precmd() {
  print -rP "
%F{cyan}%~%f $(echo_git_status)"

  PROMPT="$(echo_name)$(echo_color_prev_return_code)%(!.#.>)%f "
}

function zle-keymap-select() {
  PROMPT="$(echo_name)$(echo_color_prev_return_code)$(echo_vi_mode)%f "

  zle reset-prompt
}

# Plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

