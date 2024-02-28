#!/usr/bin/env bash

dotfiles_dir=$(dirname $0)
cd ${dotfiles_dir}
mkdir -p ${PWD}/prev_dotfiles

# .bash_aliases
[ -f ~/.bash_aliases ] && mv ~/.bash_aliases ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.bash_aliases ~/.bash_aliases

# .bash_functions
[ -f ~/.bash_functions ] && mv ~/.bash_functions ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.bash_functions ~/.bash_functions

# .bashrc
[ -f ~/.bashrc ] && mv ~/.bashrc ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.bashrc ~/.bashrc

# .clang-format
[ -f ~/.clang-format ] && mv ~/.clang-format ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.clang-format ~/.clang-format

# .clang-tidy
[ -f ~/.clang-tidy ] && mv ~/.clang-tidy ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.clang-tidy ~/.clang-tidy

# .gitconfig
[ -f ~/.gitconfig ] && mv ~/.gitconfig ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.gitconfig ~/.gitconfig

# .gitignore_global
[ -f ~/.gitignore_global ] && mv ~/.gitignore_global ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.gitignore_global ~/.gitignore_global

# .gitmessage.txt
[ -f ~/.gitmessage.txt ] && mv ~/.gitmessage.txt ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.gitmessage.txt ~/.gitmessage.txt

# .nanorc
[ -f ~/.nanorc ] && mv ~/.nanorc ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.nanorc ~/.nanorc

# .tmux.conf
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ${dotfiles_dir}/prev_dotfiles/
ln -s ${PWD}/.tmux.conf ~/.tmux.conf

# vscode_settings.json
[ -f ~/.config/Code/User/settings.json ] && mv ~/.config/Code/User/settings.json ${dotfiles_dir}/prev_dotfiles/vscode_settings.json
ln -s ${PWD}/vscode_settings.json ~/.config/Code/User/settings.json