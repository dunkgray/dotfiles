#!/bin/bash

# This script is part of the yaml dotfiles git
set -xeu

if [[ ! -d $TMPDIR ]]; then
    if [[ -d "/tmp" ]]; then
	export TMPDIR=/tmp
    fi
fi

SWHOME=$HOME
if [[ `hostname` =~ gadi ]]; then
   SWHOME=/g/data/u46/users/$USER
fi

DESTDIR=$SWHOME/bin/miniconda3

echo $DESTDIR
echo $TMPDIR
# exit 1

if [[ -d $DESTDIR ]]; then
    echo "Conda already seems to be installed, exiting"
    exit
fi

pushd $TMPDIR

curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh

./Miniconda3-latest-Linux-x86_64.sh -b -p $DESTDIR -u


__conda_setup="$(${DESTDIR}/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
eval "$__conda_setup"

conda update -n base -y conda

# conda install
conda init bash

# Look for this in $HOME/bin/
./conda_create_odc2020
