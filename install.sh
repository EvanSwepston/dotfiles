#! /usr/bin/bash
echo $SUDO_USER
ME=$SUDO_USER
# https://askubuntu.com/questions/15853/how-can-a-script-check-if-its-being-run-as-root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [[ -n "$(which apt)" ]]; then
    echo "apt is installed"
    apt install -y \
            nmap \
            dnsutils \
            greed \
            libgl1-mesa-glx \
            libegl1-mesa \
            libxrandr2 \
            libxss1 \
            libxcursor1 \
            libxcomposite1 \
            libasound2 \
            libxi6 \
            libxtst6
    if [[ -e $(ls Anaconda3*.sh 2> /dev/null | head -1) ]]; then
        echo "Using found installer"
    else
        curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
    fi
    bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p /home/$ME/Anaconda3
    echo "PATH=$PATH:/home/kduncan/anaconda3/bin" >> /home/$ME/.profile
    # https://docs.anaconda.com/free/anaconda/install/linux/
else
    echo "apt is not installed"
    exit 1
fi