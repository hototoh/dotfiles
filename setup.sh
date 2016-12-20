#!/bin/bash

function rtags {
    git clone --recursive https://github.com/Andersbakken/rtags.git
    cd rtags
    cmake $1 .
    make
    sudo make install
}

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

case "${OSTYPE}" in
# MacOSX
darwin*)
    brew tap homebrew/dupes
    brew install zsh
    brew install cmake
    brew install llvm --with-clang
    rtags -DCMAKE_PREFIX_PATH=/usr/local/opt/llvm
    ;;
# Linux
linux*)
    sudo apt-get install build-essential llvm-dev clang libclang-dev cmake
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

