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

# I believe it is not a good idea to source .bashrc from .profile
# Rather .bashrc should source .profile like every other shell.
# This has the added benefit of abstracting away things which are common to all
if [ -d "$HOME/bin" ]; then
    pathmunge $HOME/bin
fi

# set PATH so it includes user's .local/bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    pathmunge $HOME/.local/bin
fi

# Java Settings
if [ -z "{JAVA_HOME}" ]; then
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
fi

# PYTHON VIRTUALENV and VIRTUALENVWRAPPER settings
if [ -d "$HOME/.virtualenvs" ]; then
    if [ -z "${WORKON_HOME}" ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        source /usr/local/bin/virtualenvwrapper.sh
    fi
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
if [ -d "$HOME/.guix-profile" ]; then
    if [ -z "${GUIX_PROFILE}" ]; then
        export GUIX_PROFILE="$HOME/.guix-profile/";
        export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
        . "$GUIX_PROFILE/etc/profile";
    fi
fi

# TRANSMISSION daemon settings
if [ -f "$HOME/.transmission_aliases" ]; then
    source "$HOME/.transmission_aliases";
fi

# MAXIMA settings
if [ -d "/opt/maxima/bin" ]; then
    pathmunge /opt/maxima/bin
fi
