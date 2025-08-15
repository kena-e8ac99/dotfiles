# If not running interactively, don't do anything
case "$-" in *i*) : ;; *) return ;; esac

# Options
set -o vi
shopt -s checkwinsize

# Envrionment variables
export EDITOR=vim
export HISTCONTROL="erasedups:ignoreboth"
export LESS_TERMCAP_mb='\e[01;31m'
export LESS_TERMCAP_md='\e[01;31m'
export LESS_TERMCAP_me='\e[0m'
export LESS_TERMCAP_se='\e[0m'
export LESS_TERMCAP_so='\e[01;44;33m'
export LESS_TERMCAP_ue='\e[0m'
export LESS_TERMCAP_us='\e[01;32m'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
type less >/dev/null && { export PAGER=less; alias less="less -R"; }

# PROMPT
PROMPT_COMMAND='__set_prompt'

__set_prompt() {
  set -- $?
  PS1="\n"

  # Prompt for PWD
  PS1="${PS1}\[\033[36m\w\033[0m\] "

  # Prompt for git status
  if type git > /dev/null; then
    set -- "$1" "" "[32m"
    while read -r __line; do
      case "$__line" in
        "## "*) set -- "$1" "${__line#"## "}" "$3" ;;
        D[DU]*|U[DUA]*|A[UA]*) set -- "$1" "$2" "[31m"; break ;;
        *) set -- "$1" "$2" "[33m" ;;
      esac
    done < <(git status --porcelain --branch 2>/dev/null)

    [ "$2" ] && PS1="${PS1}\[\033${3}${2}\033[0m\]"
  fi

  PS1="${PS1}\n"

  # Prompt for user and hostname (only if ssh)
  if [ "${SSH_CLIENT-}" ] || [ "${SSH_TTY-}" ]; then
    PS1="${PS1}[\u@\h] "
  fi

  # Prompt for previous return code
  if [ "$1" -eq 0 ]; then
    PS1="${PS1}\$ "
  else
    PS1="${PS1}\[\033[31m\$\033[0m\] "
  fi
}

