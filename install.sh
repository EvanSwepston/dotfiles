#! /usr/bin/bash
# https://askubuntu.com/questions/15853/how-can-a-script-check-if-its-being-run-as-root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [[ -n "$(which apt)" ]]; then
    echo "apt is installed"
else
    echo "apt is not installed"
fi
#apt install greed
