## the location of .zshrc.* files
#
export ZSHRC_DIR=$HOME/.zshrc.d/
export ZPLUG_HOME=$HOME/.zplug

## Custom using zplug
#
source $ZSHRC_DIR/zplugrc

# Coustomize

source $ZSHRC_DIR/zshrc.custom

## alias
#
source $ZSHRC_DIR/zshrc.alias

## PATH
#
source $ZSHRC_DIR/zshrc.path

## keybind
#
source $ZSHRC_DIR/zshrc.keybind

## terminal configuration
#
source $ZSHRC_DIR/zshrc.terminal

## OSTYPE
#
source $ZSHRC_DIR/zshrc.ostype


PATH="/Users/tokaku/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/tokaku/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/tokaku/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/tokaku/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/tokaku/perl5"; export PERL_MM_OPT;

#export NVM_DIR="/Users/tokaku/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
