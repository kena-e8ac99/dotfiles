# Behaviour {{{1
  setopt auto_cd
  setopt print_eight_bit
  bindkey -v
# History {{{1
  export HISTFILE=~/.zsh/.histfile
  export HISTSIZE=10000
  export SAVEHIST=10000
  setopt hist_find_no_dups
  setopt hist_save_no_dups
  setopt hist_ignore_dups
  setopt hist_ignore_all_dups
  setopt hist_ignore_space
  setopt hist_no_store
  setopt hist_reduce_blanks
  setopt hist_expand
  setopt share_history
  setopt inc_append_history
# Completion {{{1
  autoload -Uz compinit colors
  compinit
  colors

  zstyle ';completion:*' use-cache true
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  zstyle ':completion:*' list-colors di=34 ln=36 ex=33
  zstyle ':completion:*' ignore-parents parent pwd
  setopt auto_param_keys
  setopt auto_param_slash
  setopt auto_list
  setopt auto_menu
  setopt list_packed
  setopt magic_equal_subst
  setopt correct
  setopt globdots
  setopt mark_dirs
  setopt list_types
  setopt nonomatch
  setopt nolistbeep
# Prompt {{{1
  autoload -Uz promptinit

  function echo_git_status()
  {
    readonly local git_status=`git status --porcelain --branch 2> /dev/null`

    if [[ -z $git_status ]]; then
      return
    fi

    readonly local git_branch=" `echo $git_status | sed -n '1p' | cut -c4-`"

    if    [[ `echo $git_status | grep ^ -c -m 2` -eq 1 ]]; then
      echo "%F{green}${git_branch}%f"
    elif [[ `echo $git_status | grep -E '^[ADU][AU]|^DD' -c -m 1` -eq 1 ]]; then
      echo "%F{red}${git_branch}%f"
    elif [[ `echo $git_status | grep -E '^??|^[ MARC]M|^M[ MD]' -c -m 1`
            -eq 1 ]]; then
      echo "%F{yellow}${git_branch}%f"
    fi
  }

  function echo_vi_mode()
  {
    case $KEYMAP in
      (vicmd)
        echo "|" ;;
      (vivis|vivli)
        echo "■" ;;
      (*)
        echo "%(!.#.>)" ;;
    esac
  }

  function echo_name()
  {
    if [[ -n $SSH_CONNECTION ]]; then
      echo "%F{blue}%n@%m%f "
    fi
  }

  function set_color_depending_on_return_code()
  {
    echo "%(?.%F{white}.%F{red})"
  }

  precmd()
  {
    print -rP "
%F{cyan}%~%f `echo_git_status`"

    PROMPT="`echo_name``set_color_depending_on_return_code`%(!.#.>)%f "
  }

  function zle-keymap-select
  {
    PROMPT="`echo_name``set_color_depending_on_return_code``echo_vi_mode`%f "

    zle reset-prompt
  }

  zle -N zle-keymap-select
# Export {{{1
  export EDITOR=vim
  export MANPAGER=most
# Alias {{{1
  alias ls='ls --color=auto'
# Plugin load {{{1
  source ~/.zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
  source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source ~/.zsh/plugins/zsh-vimode-visual/zsh-vimode-visual.zsh
# }}}1
