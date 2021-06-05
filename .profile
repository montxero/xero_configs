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


python_setup () {
    # Virtualenv setup
    if ! [ -x "$(command -v workon)" ]; then
        if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]; then
            if [ -z "$WORKON_HOME" ]; then
                export WORKON_HOME=$HOME/.virtualenvs;
            fi
            . "$HOME/.local/bin/virtualenvwrapper.sh";
        fi
    fi
    # Poetry setup
    if [ -d "$HOME/.poetry/bin" ]; then
        pathmunge "$HOME/.poetry/bin";
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
    if [ -x "$(command -v emacs)" ]; then
        if [ ! "$(pgrep -f 'emacs')" ]; then
            emacs --daemon;
        fi
    fi
}


nvm_setup () {
    # Setup nvm for nodejs
    if [ -z "$NVM_DIR" ]; then
        if [ -d "$HOME/.nvm" ]; then
            export NVM_DIR="$HOME/.nvm";
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";  # This loads nvm
        fi
    fi
}


texlive_setup () {
    if [ -d "/usr/local/texlive/2021/bin/x86_64-linux" ]; then
	pathmunge "/usr/local/texlive/2021/bin/x86_64-linux";
    fi
}


library_setup;
lib_pathmunge "/usr/local/atlas/lib"
keyboard_setup;
python_setup;
texlive_setup;
local_bin_setup;
nvm_setup;
# setup_generic_installed "$HOME/.idris2";
# launch_emacs_server;
