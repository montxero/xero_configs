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


# shellcheck source=/dev/null

pathmunge () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ]; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}


lib_pathmunge () {
    if ! echo "$LD_LIBRARY_PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ]; then
            LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"
        else
            LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"
        fi
    fi
}


setup_generic_installed () {
    if [ -d "$1/bin" ]; then
        pathmunge "$1/bin";
    fi
    if [ -d "$1/lib" ]; then
        lib_pathmunge "$1/lib";
    fi
    if [ -d "$1/lib64" ]; then
        lib_pathmunge "$1/lib64";
    fi
}


library_setup (){
    if [ -z "$LD_LIBRARY_PATH" ]; then
        LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"
        lib_pathmunge "/usr/lib";
        lib_pathmunge "/usr/local/lib";
        lib_pathmunge "/lib/x86_64-linux-gnu";
        lib_pathmunge "/lib32";
        lib_pathmunge "/usr/lib32";
    fi
    if [ -d "$HOME/lib" ]; then
        lib_pathmunge "$HOME/lib";
    fi
}


guix_setup () {
    if [ -z "$GUIX_PROFILE" ]; then
        if [ -d "$HOME/.guix-profile" ]; then
            export GUIX_PROFILE=$HOME/.guix-profile;
            export GUIX_LOCPATH=$GUIX_PROFILE/lib/locale;
            lib_pathmunge "$GUIX_PROFILE/lib";
            . "$GUIX_PROFILE/etc/profile";
        fi
        if [ -f "$HOME/.config/guix/current/etc/bash_completion.d/guix" ]; then
            . "$HOME/.config/guix/current/etc/bash_completion.d/guix";
        fi
    fi
}


python_setup () {
    # Virtualenv setup
    if ! command -v workon > /dev/null 2>&1; then
        if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
            if [ -z "$WORKON_HOME" ]; then
                export WORKON_HOME=$HOME/.virtualenvs;
            fi
            . "/usr/local/bin/virtualenvwrapper.sh";
        fi
    fi
    # Poetry setup
    if [ -d "$HOME/.poetry/bin" ]; then
        pathmunge "$HOME/.poetry/bin";
        if [ -r "$HOME/.poetry/share/poetry.bash-completion" ]; then
            . "$HOME/.poetry/share/poetry.bash-completion";
        fi
    fi
}
    

local_bin_setup () {
    # if ~/local/bin exists, add it to the head of $PATH
    if [ -d "$HOME/.local/bin" ]; then
        pathmunge "$HOME/.local/bin";
    fi
    # if ~/bin exists, add it to the head of $PATH
    if [ -d "$HOME/bin" ]; then
        pathmunge "$HOME/bin";
    fi
}


# TRANSMISSION daemon settings
if [ -f "$HOME/.transmission_aliases" ]; then
    . "$HOME/.transmission_aliases";
fi


keyboard_setup () {
    # Setup custom keymaping if it exists
    if [ -z "$XERO_KEYBOARD" ]; then
        if [ -f "$HOME/.keyboard" ]; then
            . "$HOME/.keyboard";
            export XERO_KEYBOARD=1
        fi
    fi
}


launch_emacs_server () {
    # Launch emacs server daemon if emacs command is available
    # and an emacs server is not running.
    if command -v emacs > /dev/null; then
        if [ ! "$(pgrep -f 'emacs')" ]; then
            emacs --daemon;
        fi
    fi
}


launch_screen_session () {
    # Launch a screen session with the name dev if one is not running
    # and screen is installed.
    if command -v screen > /dev/null; then
        if [ ! "$(pgrep -f 'screen -S dev')" ]; then
            screen -S dev;
        fi
    fi
}


library_setup;
keyboard_setup;
python_setup;
guix_setup;
local_bin_setup;
setup_generic_installed "$HOME/.idris2";
setup_generic_installed "/opt/apl/1.8";
setup_generic_installed "/opt/ecl/20.4.24";
# setup_generic_installed "/opt/gcc/10.2.0";
setup_generic_installed "/opt/global/6.6.5";
setup_generic_installed "/opt/maxima/5.44.0";
setup_generic_installed "/opt/racket/7.8";
setup_generic_installed "/opt/sbcl/2.0.8";
setup_generic_installed "/opt/keepassxc/2.6.1";
setup_generic_installed "/opt/opendylan/opendylan-2019.1";
launch_emacs_server;
launch_screen_session;
