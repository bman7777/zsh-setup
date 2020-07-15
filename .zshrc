# style comes from: https://medium.com/@rafavinnce/iterm2-zsh-oh-my-zsh-material-design-the-most-power-full-terminal-on-macos-332b1ee364a5

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="hackersaurus/hackersaurus"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colorize
  kube-ps1
  pyenv
  timer
)

KUBE_PS1_PREFIX=" "
KUBE_PS1_SUFFIX=" ‖"

source $ZSH/oh-my-zsh.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval "$(direnv hook zsh)"

# Color numbers:
#     Black - 0
#     Red - 1
#     Green - 2
#     Yellow - 3
#     Blue - 4
#     Magenta - 5
#     Cyan - 6
#     White - 7

if [ "$(/usr/bin/whoami)" = "root" ]; then
	USERCOLOR=red
else
	USERCOLOR=cyan
fi

local return_code="%(?..%B%F{1}✖%f%b)"

ZSH_THEME_GIT_PROMPT_PREFIX=" %B%f%F{3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b ‖"
ZSH_THEME_GIT_PROMPT_DIRTY="%f%F{1}⚡%f"
ZSH_THEME_GIT_PROMPT_AHEAD="%f%F{3}↑%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%f%F{2}✓%f"

ZSH_THEME_GIT_PROMPT_ADDED="%F{2} ✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{4} ✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{1} ✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{5} ➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{3} ═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{6} ✭%f"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export TIMER_FORMAT='⏱  %d'
export TIMER_PRECISION=2

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="⑊%B%F{2}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}%f%b"

function virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local name=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local name=$(basename $(dirname $VIRTUAL_ENV))
        else
            local name=$(basename $VIRTUAL_ENV)
        fi
        echo "$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX$name$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
    fi
}

PROMPT='%B%F{7}%f\
$(kube_ps1)\
$(git_prompt_info)\
 %F{$USERCOLOR}%n%F{7}$(virtualenv_prompt_info) ⟫ %f\
%F{7}%~%{$reset_color%}%f%b\
%F{2}%B ➜ %b%f'

RPROMPT='${return_code}'
