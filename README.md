# Dotfiles
Start by installing the necessary packages from the [linux-setup](https://github.com/chen-harrison/linux-setup) repo prior to adding these files using the install script:
```
$ ./install.sh
```
This will move all existing versions of dotfiles into the `prev_dotfiles` directory for preservation, and replace them with symbolic links to the files in the repo. After adding new dotfiles to the repo, update and rerun the install script to update the symlinks accordingly.
