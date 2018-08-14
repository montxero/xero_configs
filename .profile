# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Manual Entries
# Java Settings
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Python Settings
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# GNAT Compiler Settings
export PATH=$PATH:/opt/gnat/bin

# GHDL Settings
#export PATH=$PATH:/opt/ghdl/bin:/opt/ghdl

# Add ~/bin to path
export PATH=$PATH:$HOME/bin

#guix settings
if [ -f "$HOME/.guixrc" ]; then
    source "$HOME/.guixrc";
fi
