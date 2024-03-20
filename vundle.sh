# https://www.linuxandubuntu.com/home/installing-vundle-the-plugin-manager-for-vim
mkdir -p /home/$ME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git /home/$ME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
mkdir -p /home/$ME/.vim/pack/tpope/start
cd /home/$ME/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q