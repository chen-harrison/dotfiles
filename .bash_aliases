# Misc
alias fd='fd -H'
alias brc='. ~/.bashrc'
alias ip_address="hostname -I | awk '{print \$1}'"
alias open='xdg-open'
alias cl='clear'
alias cuda_reset='sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm'
alias wifi_list='nmcli device wifi list'

# Docker
alias dima='docker image'
alias dcon='docker container'
alias docker_prune='docker container prune -f && docker image prune -f'

# ROS
alias catkin_rebuild='catkin clean -y && catkin build'
