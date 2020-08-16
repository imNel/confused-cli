#!/bin/bash

# Functions
function help() 
{
    # Display Help
    echo "Description of script"
    echo
    echo "Usage confused <command> [<options>...]"
    echo
    echo "install: tries to install "
    echo "remove: it does that"
    echo "search: searches"
    echo "which: finds which package manager to use"
    echo "Run confused help <command> for more details"
}


if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "" ]
then
    help
    exit 0
fi


STR=$1
echo $STR