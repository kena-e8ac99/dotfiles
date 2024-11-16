# Key Binding
bindkey -v

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
zmodload zsh/complist

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$HOME/.zsh/zcompcache"
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

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Alias
alias ls='ls --color=auto'

# Prompt
get_git_branch_for_prompt() {
  git status --porcelain --branch 2> /dev/null | {
    branch_name=""; prompt_color="green"
    while read -r line; do
      case "$line" in
        "## "*) branch_name="${line#"## "}" ;;
        D[DU]*|U[DUA]*|A[UA]*) prompt_color="red"; break ;;
        *) prompt_color="yellow" ;;
      esac
    done
    [ "$branch_name" ] && echo "%F{${prompt_color}}${branch_name}%f"
  }
}

get_vi_mode_for_prompt() {
  case $KEYMAP in
    vicmd) echo "|" ;;
    vivis|vivli) echo "■" ;;
    *) echo "%(!.#.>)" ;;
  esac
}

color_based_on_prev_return_code() {
  echo "%(?.%F{white}.%F{red})$1%f"
}

get_ssh_login_info_for_prompt() {
  [ "$SSH_CONNECTION" ] && echo "%F{blue}%n@%m%f "
}

set_prompt() {
  PROMPT="$(get_ssh_login_info_for_prompt)$(color_based_on_prev_return_code "$1") "
}

precmd() {
  print -rP "
%F{cyan}%~%f $(get_git_branch_for_prompt)"

  set_prompt "%(!.#.>)"
}

zle-keymap-select() {
  set_prompt "$(get_vi_mode_for_prompt)"
  zle reset-prompt
}

# Plugins
source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(completion)

source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

