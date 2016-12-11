#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

case "${OSTYPE}" in
# MacOSX
darwin*)
    brew tap homebrew/dupes
    brew install global --with-exuberant-ctags --with-pygments
    brew install zsh
    ;;
# Linux
linux*)
    ;;
esac


DOT_FILES=("zshrc.d" "zshrc" "vimrc" "vim" "emacs.d" "screenrc" "globalrc" "tmux.conf")

for file in ${DOT_FILES[@]}
do
    new_file=.${file}
    if [ ! -e $HOME/${new_file} ];
    then
        ln -s $HOME/dotfiles/$file $HOME/${new_file}
    else
        echo $HOME/$file already exits.
    fi
done

if [ ! -e ${HOME}/.vimbackup ];
then
    install -o ${USER} -m 0700 -d ${HOME}/.vimbackup
fi

DEIN_INSTALLER=/tmp/dein-installer.sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${DEIN_INSTALLER}
sh ${DEIN_INSTALLER} ${HOME}/.vim/dein/

install -o ${USER} -m 0700 -d ${HOME}/.ssh 
if [ ! -e ${HOME}/.ssh/authorized_keys ];
then
    install -o ${USER} -m 0700 ssh/authorized_keys ${HOME}/.ssh/ 
fi

mkdir ${HOME}/.cache
curl -sL zplug.sh/installer | zsh

#install necessary files
#[! -d $HOME/<necessary dir>] && git clone git://============================== $HOME/<necessary dir>

