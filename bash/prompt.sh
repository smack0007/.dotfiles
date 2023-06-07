source ~/.dotfiles/terminal/functions.sh

BLACK=0
RED=1
GREEN=2
WHITE=15
BLUE=21
ORANGE=172
GREY=245

RESET="$(tput sgr0)"

SEGMENT_SEPARATOR=$'\ue0b0'

RETVAL=0

function prompt_segment() { 
  local fg=$(tput setaf $1)
  local bg=$(tput setab $2)
  local seperator=""

  if [[ $2 == $RESET ]]; then
    bg=$RESET
  fi

  if [[ -v LAST_BG ]]; then
    local separator_fg=$(tput setaf $LAST_BG)
    local separator_bg=$(tput setab $2)

    if [[ $2 == $RESET ]]; then
      separator_bg=$RESET
    fi

    seperator="$separator_bg$separator_fg$SEGMENT_SEPARATOR";  
  fi
  LAST_BG=$2

  echo "$seperator$bg$fg$3";
}

function prompt_distro() {
  local distro_symbol
  local distro=$(get_distro)

  case ${distro} in
    "debian")
      distro_symbol=$'\ue77d'
      ;;

    "fedora")
      distro_symbol=$'\uf30a'
      ;;
    
    "linuxmint")
      distro_symbol=$'\uf30e'
      ;;

    "msys")
      distro_symbol=$'\ue70f'
      ;;

    "ubuntu")
      distro_symbol=$'\uf31c'
      ;;
  esac

  prompt_segment $BLACK $WHITE " $distro_symbol "
}

function prompt_directory() {
  local symbol=$'\uf07b' # 
  if [[ "${PWD}" == "${HOME}" ]]; then
    symbol=$'\uf015' # 
  fi
  
  prompt_segment $WHITE $BLUE " ${symbol} \w "
}

function prompt_git() {
  local symbol=$'\ue725' # 
  local branch=$(git branch --show-current 2>/dev/null)

  if [[ $branch ]]; then       
    local git_status=$(git status -s 2>/dev/null)
    
    local bg=$GREEN
    local fg=$WHITE
    if [[ $git_status ]]; then
        bg=$ORANGE
        fg=$BLACK
    fi
    
    prompt_segment $fg $bg " ${symbol} ${branch} "
  fi
}

function prompt_status() {
  local -a symbols

  if [[ $RETVAL -ne 0 ]]; then
    symbols+=$(tput setaf $RED)
    symbols+=$'\uf00d' # 
  fi
  
  [[ -n "$symbols" ]] && prompt_segment $WHITE $GREY " $symbols "
}

function prompt_input() {
  prompt_segment $WHITE $RESET "\n#  "
}

function prompt() {
  prompt_distro
  prompt_directory
  prompt_git
  prompt_status
  prompt_input
}

function bash_prompt() {
  RETVAL=$?
  PS1="\n$(echo $(prompt)) "
}

export PROMPT_COMMAND="history -a;bash_prompt"