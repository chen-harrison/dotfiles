#!/usr/bin/env bash

# Use this function to symlink dotfiles in the repo to their proper locations
# \param $1 Absolute path to the dotfile you want to set a symlink for
# \param $2 Absolute path to the symlink you want to set
add_dotfile () {
    local dotfile_path=$1
    local symlink_path=$2

    local symlink_dir
    symlink_dir=$(dirname "$symlink_path")
    if [ ! -d "$symlink_dir" ] ; then
        echo "$symlink_dir does not exist - creating now"
        mkdir -p "$symlink_dir" || sudo mkdir -p "$symlink_dir"
    fi

    # Check if something exists at symlink_path
    if [ -f "$symlink_path" ] ; then
        local file_path
        # Find the source file (if it's a symlink), otherwise grab the symlink_path
        if [ -h "$symlink_path" ] ; then
            file_path=$(readlink -f "$symlink_path")
        else
            file_path=$symlink_path
        fi

        # If the file is different from the source dotfile, copy it into prev_dotfiles
        if ! cmp -s "$dotfile_path" "$file_path" ; then
            echo "Saving $file_path to prev_dotfiles"
            cp "$file_path" "${PWD}/prev_dotfiles/$(basename "$dotfile_path")"
        else
            echo -e "\e[0;33mSymlink to $dotfile_path already exists - skipping\e[0m"
            return
        fi
    fi

    echo -e "\e[0;32mSymlinking $dotfile_path to $symlink_path\e[0m"
    ln -sf "$dotfile_path" "$symlink_path"
}

script_dir=$(dirname "$0")
cd "$script_dir"
mkdir -p "${PWD}/prev_dotfiles"

# Find path to dotfiles directory, and grab files from there
dotfiles_dir=$(find ~ -type d -name "dotfiles" 2> /dev/null | head -n 1)

add_dotfile "$dotfiles_dir"/.bash_aliases ~/.bash_aliases
add_dotfile "$dotfiles_dir"/.bash_functions ~/.bash_functions
add_dotfile "$dotfiles_dir"/.bashrc ~/.bashrc
add_dotfile "$dotfiles_dir"/.clangd ~/.clangd
add_dotfile "$dotfiles_dir"/.clang-format ~/.clang-format
add_dotfile "$dotfiles_dir"/.clang-tidy ~/.clang-tidy
add_dotfile "$dotfiles_dir"/.fzf.bash ~/.fzf.bash
add_dotfile "$dotfiles_dir"/.gitconfig ~/.gitconfig
add_dotfile "$dotfiles_dir"/.gitignore_global ~/.gitignore_global
add_dotfile "$dotfiles_dir"/.gitmessage.txt ~/.gitmessage.txt
add_dotfile "$dotfiles_dir"/.nanorc ~/.nanorc
add_dotfile "$dotfiles_dir"/.shellcheckrc ~/.shellcheckrc
add_dotfile "$dotfiles_dir"/.tmux.conf ~/.tmux.conf
add_dotfile "$dotfiles_dir"/vscode/settings.json ~/.config/Code/User/settings.json
add_dotfile "$dotfiles_dir"/vscode/tasks.json ~/.config/Code/User/tasks.json
add_dotfile "$dotfiles_dir"/vscode/keybindings.json ~/.config/Code/User/keybindings.json
add_dotfile "$dotfiles_dir"/vscode/snippets.code-snippets ~/.config/Code/User/snippets/snippets.code-snippets
