# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=200000

# Option 1: commands will be written to history file immediately, so new terminals created
# after running command will see it in history, even if bash session is not ended
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'history -a'

# Option 2: commands will be written to and read from history file immediately.
# so existing terminals will see commands from other instances in history
# PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'history -a;history -c;history -r'

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Manage a git_ps variable that populates with git info if __git_ps1 exists
update_git_ps() {
    if declare -F __git_ps1 > /dev/null; then
        git_ps="$(__git_ps1 ' (%s)')"
    else
        git_ps=""
    fi
}
PROMPT_COMMAND="update_git_ps${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Change \u to \u@\h to include host
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u\[\e[0m\]:\[\e[01;34m\]\w\[\e[00;35m\]$git_ps\[\e[0m\]$([ $? == 0 ] && echo "$" || echo "\[\e[31m\]$\[\e[0m\]") '
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\w$git_ps\$ '
fi

# If inside a Docker container, add a whale to the prompt as an indicator
if [ -e /.dockerenv ]; then
    PS1="🐋 $PS1"
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# fzf
[ -d ~/.fzf ] && \
    export FZF_DEFAULT_COMMAND='fd' && \
    export FZF_DEFAULT_OPTS='--height 50% --layout reverse --border' && \
    export FZF_CTRL_R_OPTS='--height 50% --tmux 80% --layout reverse --border' && \
    export FZF_ALT_C_OPTS=$FZF_CTRL_R_OPTS && \
    export FZF_CTRL_T_OPTS='--height 80% --tmux 100% --style full --border --preview "fzf-preview.sh {}" --bind "focus:transform-header:file --brief {}"' && \
    source ~/.fzf.bash

# thefuck
command -v thefuck &> /dev/null && eval $(thefuck --alias)

# nnn
command -v nnn &> /dev/null && \
    export NNN_TRASH=1 && \
    export NNN_PLUG='p:preview-tui;f:fzcd' && \
    export NNN_FIFO=/tmp/nnn.fifo && \
    export NNN_BMS="d:$HOME/dotfiles;"

# fasd
command -v fasd &> /dev/null && eval "$(fasd --init auto)"

# clangd
command -v clangd &> /dev/null && export CMAKE_EXPORT_COMPILE_COMMANDS=1

# ROS 2 + colcon
[ -f /opt/ros/$ROS_DISTRO/setup.bash ] && source /opt/ros/$ROS_DISTRO/setup.bash
[ -d /usr/share/colcon_cd ] && \
    source /usr/share/colcon_cd/function/colcon_cd.sh && \
    export _colcon_cd_root=/opt/ros/$ROS_DISTRO/
[ -d /usr/share/colcon_argcomplete ] && \
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

true
