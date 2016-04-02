#!/bin/sh

DOT_FILES=(".zshrc.d" ".zshrc" ".vimrc" ".vim" ".emacs.d" ".screenrc" ".globalrc" ".tmux.conf")

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
    install -o ${USER} -m 0700 -d $HOME/.vimbackup
fi

BUNDLE=${HOME}/dotfiles/.vim/bundle

install -o ${USER} -m 0744 -d ${BUNDLE}
cd ${BUNDLE}
git clone https://github.com/Shougo/neobundle.vim
cd -

install -o ${USER} -m 0700 -d ${HOME}/.ssh 
if [ ! -e $HOME/.ssh/authorized_keys ];
then
    install -o ${USER} -m 0700 ssh/authorized_keys ${HOME}/.ssh/ 
fi

curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug

#install necessary files
#[! -d $HOME/<necessary dir>] && git clone git://============================== $HOME/<necessary dir>

