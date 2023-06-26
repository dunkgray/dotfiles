#!/bin/bash

set -xeu

echo $PATH


SWHOME=$HOME
if [[ `hostname` =~ gadi ]]; then
   SWHOME=/g/data/u46/users/$USER
fi
SANDBOX=$SWHOME/sandbox
# $SANDBOX defined in .bashrd
mkdir -p  $SANDBOX/

CURR=$PWD

# assumes keys in bitbucket and github.
# bad h5py is breaking dea-ard-scene-select in ubuntu
git clone git@github.com:GeoscienceAustralia/dea-ard-scene-select.git $SANDBOX/dea-ard-scene-select
git clone git@bitbucket.org:geoscienceaustralia/usgsdownloader.git $SANDBOX/usgsdownloader
git clone git@github.com:GeoscienceAustralia/dea-config.git  $SANDBOX/dea-config


DESTDIR=$SANDBOX/landsat-downloader
if [[ ! -d $DESTDIR ]]; then
    git clone git@bitbucket.org:geoscienceaustralia/landsat-downloader.git $DESTDIR
    cd $DESTDIR
    pre-commit install
fi

# Actually don't run this at NCI, since pre-commit install doesn't work
if [[ `hostname` =~ gadi ]] || [[ `hostname` =~ vdi ]]; then
    git clone git@github.com:GeoscienceAustralia/digitalearthau.git  $SANDBOX/digitalearthau
    cd $SANDBOX/digitalearthau
    pre-commit install

fi

cd $CURR

#git clone git@github.com:opendatacube/datacube-core.git  $SANDBOX/datacube-core
#cd $SANDBOX/datacube-core
#pre-commit install
#conda create -n odc -c conda-forge python=3.8 datacube pre_commit
#pip install --user -e $SANDBOX/datacube-core/

