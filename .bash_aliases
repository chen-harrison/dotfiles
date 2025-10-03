# Misc
alias g='git'
alias t='tmux'
alias fd='fd -H'
alias brc='. ~/.bashrc'
alias ip_address="hostname -I | awk '{print \$1}'"
alias open='xdg-open'
alias gimme="sudo chown -R $(id -u):$(id -g)"
alias cl='clear'
alias cuda_reset='sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm'
alias wifi_list='nmcli device wifi list'
alias lzd='lazydocker'
alias lzg='lazygit'

# Docker
alias dima='docker image'
alias dcon='docker container'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias docker_prune='docker container prune -f && docker image prune -f'

# ROS 2
alias colcon_clean='rm -rf build install log'
alias ros2_setup='source install/setup.bash'
