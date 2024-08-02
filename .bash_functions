clang_format_dir() {
    local code_dir=$1
    local search_dir=~/.vscode
    # Grab clang-format binary from the latest version of the VS Code C++ extension
    local format_cmd=$(fd -tf clang-format $search_dir | sort | tail -1)

    if [[ $format_cmd ]] ; then
        cd $code_dir
        fd -e cpp -e hpp -e h -x $format_cmd -i --style=file {}
        cd - > /dev/null
    else
        >&2 echo "ERROR: No clang-format found in $search_dir"
    fi
}

fzf_file() {
    fd -tf . $1 | fzf
}

fzf_dir() {
    fd -td . $1 | fzf
}

docker_attach() {
    local latest_id=$(docker ps -lq)
    if [[ ! $latest_id ]] ; then
        echo 'No docker container running!'
    elif [[ "$#" -eq 0 ]] ; then
        echo $latest_id
        docker exec -it $latest_id /bin/bash
    elif [[ "$#" -eq 1 ]] ; then
        local idx=$(($1+1))
        local container_id=$(docker ps -q | sed "${idx}q;d")
        echo $container_id
        if [[ $container_id ]] ; then
            docker exec -it $container_id /bin/bash
        else
            echo "WARNING: container ID not found at index, attaching to latest"
            docker exec -it $latest_id /bin/bash
        fi
    fi
}

wifi_connect() {
    local ssid=$1
    (nmcli c up $ssid || nmcli --ask device wifi connect $ssid) > /dev/null
    if [[ "$?" -eq 0 ]]; then
        echo "Connected to $ssid"
    else
        echo "Failed to connect to $ssid"
    fi
}

wordle() {
    words=($(grep '^\w\w\w\w\w$' /usr/share/dict/words | tr '[a-z]' '[A-Z]'))
    actual=${words[$[$RANDOM % ${#words[@]}]]} end=false guess_count=0 max_guess=6
    if [[ $1 == "unlimit" ]]; then
        max_guess=999999
    fi
    while [[ $end != true ]]; do
        guess_count=$(( $guess_count + 1 ))
        if [[ $guess_count -le $max_guess ]]; then
            echo "Enter your guess ($guess_count / $max_guess):"
            read guess
            guess=$(echo $guess | tr '[a-z]' '[A-Z]')
            if [[ " ${words[*]} " =~ " $guess " ]]; then
                output="" remaining=""
                if [[ $actual == $guess ]]; then
                    echo "You guessed right!"
                    for ((i = 0; i < ${#actual}; i++)); do
                        output+="\033[30;102m ${guess:$i:1} \033[0m"
                    done
                    printf "$output\n"
                    end=true
                else
                    for ((i = 0; i < ${#actual}; i++)); do
                        if [[ "${actual:$i:1}" != "${guess:$i:1}" ]]; then
                            remaining+=${actual:$i:1}
                        fi
                    done
                    for ((i = 0; i < ${#actual}; i++)); do
                        if [[ "${actual:$i:1}" != "${guess:$i:1}" ]]; then
                            if [[ "$remaining" == *"${guess:$i:1}"* ]]; then
                                output+="\033[30;103m ${guess:$i:1} \033[0m"
                                remaining=${remaining/"${guess:$i:1}"/}
                            else
                                output+="\033[30;107m ${guess:$i:1} \033[0m"
                            fi
                        else
                            output+="\033[30;102m ${guess:$i:1} \033[0m"
                        fi
                    done
                    printf "$output\n"
                fi
            else
                echo "Please enter a valid word with 5 letters!";
                guess_count=$(( $guess_count - 1 ))
            fi
        else
            echo "You lose! The word is:"
            echo $actual
            end=true
        fi
    done
}
