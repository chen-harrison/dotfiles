check_help() {
    if [[ "$#" -eq 1 ]] && [[ "$1" == '-h' || "$1" == '--help' ]] ; then
        return
    fi
    return 1
}

clang_format_dir() {
    # if check_help "$@" ; then
    if [[ $# -ne 1 ]] || check_help "$@" ; then
        echo "Usage: ${FUNCNAME[0]} TARGET_DIR"
        echo "Recursively apply clang-format formatting to all C++ files in a target directory."
        return
    elif [ ! -d "$1" ] ; then
        echo "ERROR: '$1' not a valid directory" >&2
        return 1
    fi

    local target_dir=$1
    # Grab clang-format binary from the latest version of the VS Code C++ extension
    local clang_format_dir="$HOME/.vscode"
    local format_cmd
    format_cmd=$(fd -tf clang-format "$clang_format_dir" | sort | tail -1)

    if [[ $format_cmd ]] ; then
        # Enter into the target directory, filter for C++ files, then execute
        # clang-format on them, and return to previous dir
        cd "$target_dir"
        fd -e cpp -e hpp -e h -x "$format_cmd" -i --style=file {}
        cd - > /dev/null
    else
        echo "ERROR: No clang-format found in $clang_format_dir" >&2
    fi
}

fzf_file() {
    if check_help "$@" ; then
        echo "Usage: ${FUNCNAME[0]} [SEARCH_STR] [SEARCH_DIR]"
        echo "fzf search for files in current directory, or a different one if specified."
        return
    fi

    fd -tf $1 $2 | fzf
}

fzf_dir() {
    if check_help "$@" ; then
        echo "Usage: ${FUNCNAME[0]} [SEARCH_STR] [SEARCH_DIR]"
        echo "fzf search for directories in current directory, or a different one if specified."
        return
    fi

    fd -td $1 $2 | fzf
}

docker_attach() {
    if check_help "$@" ; then
        echo "Usage: ${FUNCNAME[0]} [DOCKER_CONTAINER_IDX]"
        echo "Attach to the latest running container, or to the container at a specified index."
        return
    fi
    
    # Grab the ID of most recent running container
    local latest_id
    latest_id=$(docker container ls -lq -f 'status=running')
    if [[ ! "$latest_id" ]] ; then
        echo 'No Docker container running!'
    elif [[ "$#" -eq 0 ]] ; then
        echo "$latest_id"
        docker exec -it "$latest_id" /bin/bash
    elif [[ "$#" -eq 1 ]] ; then
        local idx=$1
        # Increment idx by 1 because we're capturing using line number (e.g. idx 0 at line 1)
        local container_id
        container_id=$(docker container ls -q | sed "$((idx+1))q;d")
        if [[ $container_id ]] ; then
            echo "$container_id"
            docker exec -it "$container_id" /bin/bash
        else
            echo "WARNING: container ID not found at index $idx, attaching to latest"
            docker exec -it "$latest_id" /bin/bash
        fi
    fi
}

wifi_connect() {
    if [[ $# -ne 1 ]] || check_help "$@" ; then
        echo "Usage: ${FUNCNAME[0]} WIFI_SSID"
        echo "Connect to a wi-fi network."
        return
    fi

    local ssid=$1
    if (nmcli c up "$ssid" 2> /dev/null) || nmcli --ask device wifi connect "$ssid" ; then
        echo "Connected to $ssid"
    else
        echo "Failed to connect to $ssid"
    fi
}

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

wordle() {
    words=($(grep '^\w\w\w\w\w$' /usr/share/dict/words | tr '[a-z]' '[A-Z]'))
    actual=${words[$[$RANDOM % ${#words[@]}]]} end=false guess_count=0 max_guess=6
    if [[ $1 == "unlimit" ]] ; then
        max_guess=999999
    fi
    while [[ $end != true ]]; do
        guess_count=$(( $guess_count + 1 ))
        if [[ $guess_count -le $max_guess ]] ; then
            echo "Enter your guess ($guess_count / $max_guess):"
            read guess
            guess=$(echo $guess | tr '[a-z]' '[A-Z]')
            if [[ " ${words[*]} " =~ " $guess " ]] ; then
                output="" remaining=""
                if [[ $actual == $guess ]] ; then
                    echo "You guessed right!"
                    for ((i = 0; i < ${#actual}; i++)); do
                        output+="\033[30;102m ${guess:$i:1} \033[0m"
                    done
                    printf "$output\n"
                    end=true
                else
                    for ((i = 0; i < ${#actual}; i++)); do
                        if [[ "${actual:$i:1}" != "${guess:$i:1}" ]] ; then
                            remaining+=${actual:$i:1}
                        fi
                    done
                    for ((i = 0; i < ${#actual}; i++)); do
                        if [[ "${actual:$i:1}" != "${guess:$i:1}" ]] ; then
                            if [[ "$remaining" == *"${guess:$i:1}"* ]] ; then
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
