#!/usr/bin/env bash

# Use this function to symlink dotfiles in the repo to their proper locations
# \param $1 Absolute path to the dotfile you want to set a symlink for
# \param $2 Absolute path to the symlink you want to set
add_dotfile () {
    local dotfile_path=$1
    local symlink_path=$2
    local file_path=''

    echo "Symlinking $dotfile_path to $symlink_path"

    # Get the file (or underlying file, for symlinks) at the symlink path
    if [ -f $symlink_path ]; then
        if [ -L $symlink_path ]; then
            file_path=$(readlink -f $symlink_path)
        else
            file_path=$symlink_path
        fi

        # If the file is different from the source dotfile, we'll store it in prev_dotfiles
        if [ "$dotfile_path" != $file_path ]; then
            echo "Saving $file_path to prev_dotfiles"
            mv $file_path $PWD/prev_dotfiles/
        fi
    fi

    ln -sf $dotfile_path $symlink_path
}

script_dir=$(dirname $0)
cd $script_dir
mkdir -p ${PWD}/prev_dotfiles

add_dotfile ~/dotfiles/.bash_aliases ~/.bash_aliases
add_dotfile ~/dotfiles/.bash_functions ~/.bash_functions
add_dotfile ~/dotfiles/.bashrc ~/.bashrc
add_dotfile ~/dotfiles/.clang-format ~/.clang-format
add_dotfile ~/dotfiles/.clang-tidy ~/.clang-tidy
add_dotfile ~/dotfiles/.gitconfig ~/.gitconfig
add_dotfile ~/dotfiles/.gitignore_global ~/.gitignore_global
add_dotfile ~/dotfiles/.gitmessage.txt ~/.gitmessage.txt
add_dotfile ~/dotfiles/.nanorc ~/.nanorc
add_dotfile ~/dotfiles/.tmux.conf ~/.tmux.conf
add_dotfile ~/dotfiles/vscode_settings.json ~/.config/Code/User/settings.json
add_dotfile ~/dotfiles/vscode_tasks.json ~/.config/Code/User/tasks.json