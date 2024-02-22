# ' ' = everything is just a string, ignore macro triggers ($, %, &, etc.)
# " " = process macro triggers

# Git
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'

# Misc
alias brc='. ~/.bashrc'
alias ip_address="hostname -I | awk '{print \$1}'"
alias open='xdg-open'
alias cl='clear'

# Docker
alias docker_attach='docker exec -it $(docker ps -lq) /bin/bash'