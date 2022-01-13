#!/usr/bin/env bash

#  ubuntu/Deb based

sudo apt-get install software-properties-common -y
sudo apt-add-repository universe

sudo apt-get update
sudo apt-get install awscli -y
sudo apt-get install git -y
sudo apt-get install emacs -y
sudo apt-get install unzip -y
sudo apt-get install python3-pip -y
sudo apt-get install maven -y
sudo apt-get install xterm -y
sudo apt-get install libcanberra-gtk-module libcanberra-gtk3-module -y
sudo apt-get install gfortran -y # Why?
sudo apt-get install tree -y
sudo apt-get install screen -y
sudo apt-get install python-pytest -y
#sudo apt-get install dos2unix -y # the .bashrc does this
sudo apt-get install pylint -y
sudo apt-get install zerofree -y
sudo apt-get install libpq-dev -y
sudo apt-get install ntp -y
sudo apt-get install curl -y

# for  pre-commit
sudo apt-get install shellcheck -y

if [[ $(grep microsoft /proc/version) ]]; then
#     echo "Bash is running on WSL"
#     # a hack to get snap to work.  That did not work
#     sudo apt-get install -yqq daemonize dbus-user-session fontconfig
#     sudo daemonize /usr/bin/unshare --fork --pid \
# 	 --mount-proc /lib/systemd/systemd --system-unit=basic.target
#     exec sudo nsenter -t $(pidof systemd) -a su - $LOGNAME
    #     echo "Back to the main program"

    # Snap is broken in wsl.  This is broken 13/01/22
    #  sudo snap install shfmt
    
    curl -sS https://webinstall.dev/shfmt | bash
else
    sudo snap install shfmt
fi

curl -sS https://webinstall.dev/fzf | bash

# Install Pycharm
#sudo snap install pycharm-professional --classic


