#! /usr/bin/bash
echo $SUDO_USER
ME=$SUDO_USER
# https://askubuntu.com/questions/15853/how-can-a-script-check-if-its-being-run-as-root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [[ -n "$(which apt)" ]]; then
    echo "apt is installed"
    apt install -y \
            nmap \
            dnsutils \
            greed \
            libgl1-mesa-glx \
            libegl1-mesa \
            libxrandr2 \
            libxss1 \
            libxcursor1 \
            libxcomposite1 \
            libasound2 \
            libxi6 \
            libxtst6
    if [[ -e $(ls Anaconda3*.sh 2> /dev/null | head -1) ]]; then
        echo "Using found installer"
    else
        curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
    fi
    # https://docs.anaconda.com/free/anaconda/install/linux/
    bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p /home/$ME/Anaconda3
    echo "PATH=$PATH:/home/kduncan/anaconda3/bin" >> /home/$ME/.profile
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
    alias ls="ls -lah" >> /home/$ME/.bashrc
    alias ..="cd .." >> /home/$ME/.bashrc
    alias da='date "+%Y-%m-%d %A %T %Z"' >> /home/$ME/.bashrc
    ln -s /home/$ME/dotfiles/.bashrc /home/$ME/.bashrc
    if ! [ -d "$~/.ssh" ]; then
        mkdir .ssh
    fi
    echo "Host frycat git config
    
        User w248exs
        HostName fry.cs.wright.edu
        Port 22" >> .ssh/config
    ln -s /home/$ME/dotfiles/sshfiles/authorized_keys /home/$ME/.ssh/authorized_keys
    ln -s /home/$ME/dotfiles/sshfiles/config /home/$ME/.ssh/config
    # https://www.linuxandubuntu.com/home/installing-vundle-the-plugin-manager-for-vim
    git clone https://github.com/VundleVim/Vundle.vim.git >> /home/$ME/.bashrc.vim/bundle/Vundle.vim
    echo "set nocompatible
    filetype off
    set rtp+=$ME/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plug 'sts10/vim-pink-moon'
    call vundle#end()
    filetype plugin indent on" >> .vimrc
    vim +PluginInstall +qall
    mkdir -p /home/$ME/.vim/pack/tpope/start
    cd /home/$ME/.vim/pack/tpope/start
    git clone https://tpope.io/vim/fugitive.git
    vim -u NONE -c "helptags fugitive/doc" -c q
else
    echo "apt is not installed"
    exit 1
fi