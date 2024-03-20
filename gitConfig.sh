#!/bin/bash
# https://git-scm.com/book/sv/v2/Customizing-Git-Git-Configuration
git config --global user.name "Evan Swepston"
git config --global user.email swepston.2@wright.edu
git config --global core.editor vim
# https://github.com/github/gitignore/blob/main/Global/Linux.gitignore
echo ".fuse_hidden*
.directory
.Trash-*
.nfs*" >> /home/$ME/.gitignore_global
git config --global core.excludesfile /home/$ME/.gitignore_global
git config --global help.autocorrect 20
ln -s /home/$ME/dotfiles/gitfiles/.gitconfig /home/$ME/.gitconfig