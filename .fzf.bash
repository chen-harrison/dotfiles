# Setup fzf
# ---------
if [[ ! "$PATH" == */home/harrison/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/harrison/.fzf/bin"
fi

eval "$(fzf --bash)"
