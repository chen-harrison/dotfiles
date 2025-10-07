# Misc
alias g='git'
alias t='tmux'
alias fd='fd -H'
alias brc='. ~/.bashrc'
alias ip_address='hostname -I | cut -d" " -f1'
alias open='xdg-open'
alias gimme='sudo chown -R $(id -u):$(id -g)'
alias cl='clear'
alias cuda_reset='sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm'
alias wifi_list='nmcli device wifi list'
alias lzd='lazydocker'
alias lzg='lazygit'
alias sshfs='sshfs -o uid=$(id -u) -o gid=$(id -g)'

# Docker
alias dima='docker image'
alias dcon='docker container'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias docker_prune='docker container prune -f && docker image prune -f'

# ROS 2
alias colcon_clean='rm -rf build install log && \
                    AMENT_PREFIX_PATH=$(echo $AMENT_PREFIX_PATH | sed -E "s|$(pwd)[^:]*:||g") && \
                    CMAKE_PREFIX_PATH=$(echo $CMAKE_PREFIX_PATH | sed -E "s|$(pwd)[^:]*:||g")'
alias si='source install/setup.bash'
