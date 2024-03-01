# ' ' = everything is just a string, ignore macro triggers ($, %, &, etc.)
# " " = process macro triggers

# Misc
alias brc='. ~/.bashrc'
alias ip_address="hostname -I | awk '{print \$1}'"
alias open='xdg-open'
alias cl='clear'
alias cuda_reset='sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm'

# Docker
alias docker_attach='docker exec -it $(docker ps -lq) /bin/bash'