# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# pathmunge function to add path to $PATH whilst avoiding duplicates
# usage:
# To add a path to the front of $PATH, do
# $ pathmunge path
# To add a path to the end of $PATH, do
# $ pathmunge path after

pathmunge () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "2" = "after" ]; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    #PATH="$HOME/bin:$PATH"
#    export PATH=$PATH:$HOME/bin
#fi
if [ -d "$HOME/bin" ]; then
    pathmunge $HOME/bin
fi

# set PATH so it includes user's .local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    pathmunge $HOME/.local/bin
fi

# Java Settings
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# PYTHON VIRTUALENV and VIRTUALENVWRAPPER settings
if [ -d "$HOME/.virtualenvs" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

# GNAT Compiler Settings
if [ -d "/opt/gnat/bin" ]; then
    pathmunge /opt/gnat/bin
fi

# GHDL Settings
if [ -d "/opt/ghdl/bin" ]; then
    pathmunge /opt/ghdl/bin
fi

# GUIX settings
if [ -f "$HOME/.guixrc" ]; then
    source "$HOME/.guixrc";
fi

# TRANSMISSION daemon settings
if [ -f "$HOME/.transmission_aliases" ]; then
    source "$HOME/.transmission_aliases";
fi

# MAXIMA settings
if [ -d "/opt/maxima/bin" ]; then
    pathmunge /opt/maxima/bin
fi
