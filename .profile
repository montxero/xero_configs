# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# pathmunge: function to add path to $PATH whilst avoiding duplicates
# USAGE:
# To add a path to the front of $PATH, do
#         $ pathmunge path
# To add a path to the end of $PATH, do
#         $ pathmunge path after

pathmunge () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "2" = "after" ]; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

guix_setup () {
    if [ -z "$GUIX_PROFILE" ]; then
        if [ -d "$HOME/.guix-profile" ]; then
            export GUIX_PROFILE=$HOME/.guix-profile;
            export GUIX_LOCPATH=$GUIX_PROFILE/lib/locale;
            source "$GUIX_PROFILE/etc/profile";
        fi
        if [ -f "$HOME/.config/guix/current/etc/bash_completion.d/guix" ]; then
            source "$HOME/.config/guix/current/etc/bash_completion.d/guix";
            source "$HOME/.config/guix/current/etc/bash_completion.d/guix-daemon";
        fi
    fi
}

python_virtualenv_setup () {
    if [ -d "$HOME/.virtualenvs" ]; then
        if [ -z "${WORKON_HOME}" ]; then
            export WORKON_HOME=$HOME/.virtualenvs
            source /usr/local/bin/virtualenvwrapper.sh
        fi
    fi
}
    
local_bin_setup () {
    # if ~/local/bin exists, add it to the head of $PATH
    if [ -d "$HOME/.local/bin" ]; then
        pathmunge $HOME/.local/bin
    fi
    # if ~/bin exists, add it to the head of $PATH
    if [ -d "$HOME/bin" ]; then
        pathmunge $HOME/bin
    fi
}


# TRANSMISSION daemon settings
if [ -f "$HOME/.transmission_aliases" ]; then
    source "$HOME/.transmission_aliases";
fi


python_virtualenv_setup;
local_bin_setup;
guix_setup;
