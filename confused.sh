#!/bin/bash

# Functions
help() 
{
    # Display Help
    echo "Unifies APT and Snap into a single command."
    echo
    echo "Usage: confused <command> [<options>...]"
    echo 
    echo "    install : Tries to install"
    echo "     remove : Tries to remove a package"
    echo "     search : Searches all compatible repos"
    echo "      which : Finds which package manager a package is in"
    echo
    echo "Run 'confused help <command>' for more details on a specific command."
}

case "$1" in
install)
    apt search $2 2> /dev/null | grep "^$2/" &> /dev/null
    if [ $? = 0 ]; then
        echo "Found $2 in apt. Installing..."
        apt install $2
        exit 0
    fi
    snap search $2 2> /dev/null | grep "^$2 " &> /dev/null
    if [ $? = 0 ]; then
        echo "Found $2 in snap. Installing..."
        snap install $2
        exit 0
    fi
    echo "Could not find package '$2'"
    ;;

which)
    apt search $2 2> /dev/null | grep "^$2/" &> /dev/null
    if [ $? = 0 ]; then
        found_in_apt=true
    fi

    snap search $2 2> /dev/null | grep "^$2 " &> /dev/null
    if [ $? = 0 ]; then
        found_in_snap=true
    fi

    if [ "$found_in_apt" = true ] && [ "$found_in_snap" = true ]; then
        found_in_both=true
    fi
    
    case true in
    $found_in_both)
        echo "Package '$2' found in both apt and snap."
        ;;
    
    $found_in_apt)
        echo "Package '$2' found in apt."
        ;;
    $found_in_snap)
        echo "Package '$2' found in snap."
        ;;
    *)
        echo "Package '$2' was not found."
        ;;
    esac
    ;;
*)
    help
    exit 0
    ;;
esac