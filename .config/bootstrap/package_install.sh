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
sudo apt-get install postgresql postgresql-contrib pgadmin3 -y
sudo apt-get install yamllint -y
sudo apt-get install csvkit -y

# for  pre-commit
sudo apt-get install shellcheck -y

# for ard_pipeline and scene select
sudo apt-get install libhdf5-dev -y
pip install pytest-odc

# for reading ard processing log files
sudo apt-get install jq -y

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
    sudo apt-get install snapd -y
    sudo snap install shfmt
    sudo snap install pre-commit --classic
fi

curl -sS https://webinstall.dev/fzf | bash

# Install Pycharm
#sudo snap install pycharm-professional --classic

# From https://bitbucket.org/geoscienceaustralia/dea-dev-box/src/master/infrastructure/userdata.sh
# Install Conda/Mamba
# Not tested yet, for running from this script

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh -b
~/mambaforge/bin/mamba init # this will edit the .bashrc file.
