# smack007 fork of agnoster's theme

source ~/.dotfiles/terminal/functions.sh

# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](https://iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# If using with "light" variant of the Solarized color schema, set
# SOLARIZED_THEME variable to "light". If you don't specify, we'll assume
# you're using the "dark" variant.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
CURRENT_FG='white'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
  SEGMENT_SEPARATOR=$'\ue0b0'
}

# Add a newline before each command
precmd() {
  $funcstack[1]() {
    echo
  }
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''

  # Adds the new line and # as the start character.
  printf "\n#";
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Show a logo for which distro we're currently in
prompt_distro() {
  local distro_symbol
  local distro=$(get_distro)

  case ${distro} in
    "debian")
      distro_symbol="\ue77d"
      ;;

    "fedora")
      distro_symbol="\uf30a"
      ;;
    
    "msys")
      distro_symbol="\ue70f"
      ;;
  esac

  prompt_segment white black ${distro_symbol}
}

# Git: branch/detached head, dirty status
prompt_git() {
  local symbol="\ue725" # 
  local branch=$(git branch --show-current 2>/dev/null)

  if [[ $branch ]]; then       
    local git_status=$(git status -s 2>/dev/null)
    
    local bg_color=green
    local fg_color=$CURRENT_FG
    if [[ $git_status ]]; then
        bg_color=yellow
        fg_color=black
    fi
    
    prompt_segment $bg_color $fg_color "${symbol} ${branch}"
  fi
}

# Dir: current working directory
prompt_dir() {
  local symbol="\uf07b" # 
  if [[ "${PWD}" == "${HOME}" ]]; then
    symbol="\uf015" # 
  fi
  prompt_segment blue $CURRENT_FG "${symbol} %~"
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}\uf00d" # 
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}\uf0e7" # 
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{white}%}\uf013" # 
  
  [[ -n "$symbols" ]] && prompt_segment 245 default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_distro
  prompt_dir
  prompt_git
  prompt_status
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
