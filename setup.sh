#! /bin/bash

DOT_FILES=(.zshrc.d .zshrc .vimrc .vim .emacs.d .screenrc)

for file in ${DOT_FILES[@]}
do
    if [ ! -e $HOME/$file ];
    then
        ln -s $HOME/dotfiles/$file $HOME/$file
    else
        echo $HOME/$file already exits.
    fi
done

if [ ! -e $HOME/.vimbackup ];
then
    install -o ${USER} -m 0600 -d $HOME/.vimbackup
fi

BUNDLE=${HOME}/dotfiles/.vim/bundle

install -o ${USER} -m 0644 -d ${BUNDLE}
cd ${BUNDLE}
git clone https://github.com/Shougo/neobundle.vim
cd -

install -o ${USER} -m 0700 -d ${HOME}/.ssh 
install -o ${USER} -m 0700 ssh/authorized_keys ${HOME}/.ssh/ 
#install necessary files
#[! -d $HOME/<necessary dir>] && git clone git://============================== $HOME/<necessary dir>

