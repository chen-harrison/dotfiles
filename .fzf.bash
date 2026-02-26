# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

if [[ -f "${HOME}/.fzf/fzf-git.sh" ]] ; then
  source "${HOME}/.fzf/fzf-git.sh"
fi

eval "$(fzf --bash)"
