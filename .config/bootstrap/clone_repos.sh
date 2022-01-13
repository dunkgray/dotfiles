#!/bin/bash

set -xeu

echo $PATH
conda activate dea2020
exit 1
# let's get some repos
#SANDBOX=$HOME/sandbox

# .bashrc should define $SANDBOX
mkdir -p  $SANDBOX/

CURR=$PWD

# assumes keys in bitbucket and github.
git clone git@github.com:GeoscienceAustralia/dea-ard-scene-select.git $SANDBOX/dea-ard-scene-select
git clone git@bitbucket.org:geoscienceaustralia/usgsdownloader.git $SANDBOX/usgsdownloader
git clone git@bitbucket.org:geoscienceaustralia/eo-integration-tests.git $SANDBOX/eo-integration-tests

# 
git clone git@bitbucket.org:geoscienceaustralia/landsat-downloader.git $SANDBOX/landsat-downloader
cd $SANDBOX/landsat-downloader
pre-commit install

cd $CURR

# Assumes conda dea2020 has been setup
# and jams the dea repo's into the same environment
conda activate dea2020

pip install --user -e $SANDBOX/dea-ard-scene-select

exit 0

# only really works on NCI
git clone git@github.com:dunkgray/processingDEA.git $SANDBOX/processingDEA

git clone git@github.com:GeoscienceAustralia/eo-datasets.git $SANDBOX/eo-datasets
cd $SANDBOX/eo-datasets
pre-commit install
pip install --user -e $SANDBOX/eo-datasets

git clone git@github.com:opendatacube/datacube-core.git  $SANDBOX/datacube-core
cd $SANDBOX/datacube-core
pre-commit install
#conda create -n odc -c conda-forge python=3.8 datacube pre_commit
#pip install --user -e $SANDBOX/datacube-core/

git clone git@github.com:GeoscienceAustralia/digitalearthau.git  $SANDBOX/digitalearthau
cd $SANDBOX/digitalearthau
pre-commit install


git clone git@github.com:GeoscienceAustralia/dea-config.git  $SANDBOX/dea-config
