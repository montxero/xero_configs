# ~/.profile: executed by the command interpreter for login shells.

# shellcheck source=/dev/null


path_prepend () {
    # Takes a directory and adds it to the front of $PATH if it is not in $PATH
    # Else it does nothing.
    if ! echo "$PATH" | /usr/bin/grep -Eq "(^|:)$1($|:)"; then
        if [ -d "$1" ]; then
            PATH="$1:$PATH"
        fi
    fi
}

path_append () {
    # Takes a directory and adds it to the end of $PATH if it is not in $PATH
    # Else it does nothing.
    if ! echo "$PATH" | /usr/bin/grep -Eq "(^|:)$1($|:)"; then
        if [ -d "$1" ]; then
            PATH="$PATH:$1"
        fi
    fi
}

lib_path_prepend () {
    # Takes a directory and adds it to the front of $LD_LIBRARY_PATH
    # if it is not in $LD_LIBRARY_PATH. Else it does nothing.
    if ! echo "LD_LIBRARY_PATH" | /usr/bin/grep -Eq "(^|:)$1($|:)"; then
        if [ -d "$1" ]; then
            LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"
        fi
    fi
}

lib_path_append () {
    # Takes a directory and adds it to the front of $LD_LIBRARY_PATH
    # if it is not in $LD_LIBRARY_PATH. Else it does nothing.
    if ! echo "LD_LIBRARY_PATH" | /usr/bin/grep -Eq "(^|:)$1($|:)"; then
        if [ -d "$1" ]; then
            LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"
        fi
    fi
}

# set $LD_LIBRARY_PATH if it is not set.
if [ -z "$LD_LIBRARY_PATH" ]; then
    LD_LIBRARY_PATH=/usr/lib;
fi
# Setup $LD_LIBRARY_PATH
lib_path_prepend "/lib"
lib_path_prepend "/usr/lib"
lib_path_prepend "/usr/lib32"
lib_path_prepend "/usr/local/lib"
lib_path_prepend "/usr/local/lib32"
lib_path_prepend "$HOME/lib"

# Path Setup
path_prepend "/usr/local/bin"
path_prepend "/usr/local/cuda/bin"
path_prepend "$HOME/.cargo"
path_prepend "$HOME/.ghcup/bin"
path_prepend "$HOME/.cabal/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"


[ -f "/home/me/.ghcup/env" ] && . "/home/me/.ghcup/env" # ghcup-env

export QSYS_ROOTDIR="/home/me/altera_lite/25.1std/quartus/sopc_builder/bin"
