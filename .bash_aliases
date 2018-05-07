# .bash_aliases
# File to store bash_aliases
# Created by Xero
# last modified O8-05-2018

alias test_internet="ping -c 3 8.8.8.8"
#alias vi="vim"
alias emacs="emacs -nw"
alias clearls="clear; ls"
alias clearla="clear; ls -a"
alias sage_jupyter="sage -notebook=jupyter > /dev/null 2>&1 &"
alias rm="rm -i"
alias dataenv="cd ~/Documents/klgRepo/jnbs && workon data; jupyter notebook"
alias jnb="jupyter notebook > /dev/null 2>&1 &"
alias jlab="jupyter lab > /dev/null 2>&1 &"
alias jabref="jref > /dev/null 2>&1 &"
alias mlab="matlab > /dev/null 2>&1 &"
alias source_profile="source $HOME/.profile"
