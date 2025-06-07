#!/usr/bin/env bash

check_help() {
    if [[ $# -eq 1 && ($1 == "-h" || $1 == "--help") ]] ; then
        return
    fi
    return 1
}

if [[ $# -ne 1 ]] || check_help "$@" ; then
    echo "Usage: $(basename "$0") [IMAGE[:TAG]]"
    echo "Build a dev container."
    exit 0
fi

BASE_IMAGE=$1
USERNAME=$(whoami)
USER_UID=$(id -u)
USER_GID=$(id -g)

docker build \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg USERNAME=$USERNAME \
    --build-arg USER_UID=$USER_UID \
    --build-arg USER_GID=$USER_GID \
    --no-cache \
    -f "$(dirname $0)/Dockerfile" \
    -t "${BASE_IMAGE}-user" \
    "$(dirname $0)"