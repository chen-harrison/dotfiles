# Dotfiles
Start by installing the necessary packages from the [linux-setup](https://github.com/chen-harrison/linux-setup) repo prior to adding these files using the install script:
```
$ ./install.sh
```
This will move all existing versions of dotfiles into `prev_dotfiles` directory for for preservation, and replace them with symbolic links to the files in the repo. This command can be run repeatedly as new files are added to the repo and need to have symlinks set.