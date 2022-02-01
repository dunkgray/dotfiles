#!/bin/bash

set -xeu

echo $PATH

# $SANDBOX defined in .bashrd
mkdir -p  $SANDBOX/

CURR=$PWD

DESTDIR=$SANDBOX/prototype-downloader
if [[ ! -d $DESTDIR ]]; then
    git clone git@bitbucket.org:geoscienceaustralia/prototype-downloader.git
    conda create -n prototype-downloader
    conda activate prototype-downloader
    # if conda install was not called conda develop did not work
    conda install pyproj requests attrs cattrs fsspec pyyaml mock pep8-naming pytest
    conda develop prototype-downloader
    python3 -c 'import downloadusgs' # to test
fi

# assumes keys in bitbucket and github.
git clone git@github.com:GeoscienceAustralia/dea-ard-scene-select.git $SANDBOX/dea-ard-scene-select
git clone git@bitbucket.org:geoscienceaustralia/usgsdownloader.git $SANDBOX/usgsdownloader
git clone git@bitbucket.org:geoscienceaustralia/eo-integration-tests.git $SANDBOX/eo-integration-tests

DESTDIR=$SANDBOX/landsat-downloader
if [[ ! -d $DESTDIR ]]; then
    git clone git@bitbucket.org:geoscienceaustralia/landsat-downloader.git $DESTDIR
    cd $DESTDIR
    pre-commit install
fi

#conda activate dea2020
# pip -e and conda do not always play well together
#pip install --user -e $SANDBOX/dea-ard-scene-select

git clone git@github.com:GeoscienceAustralia/eo-datasets.git $SANDBOX/eo-datasets
cd $SANDBOX/eo-datasets
pre-commit install

#This would need to be tested
#pip install --user -e $SANDBOX/eo-datasets

# Actually don't run this at NCI, since pre-commit install doesn't work
if [[ `hostname` =~ gadi ]] || [[ `hostname` =~ vdi ]]; then
    git clone git@github.com:GeoscienceAustralia/dea-config.git  $SANDBOX/dea-config
    git clone git@github.com:dunkgray/processingDEA.git $SANDBOX/processingDEA

    git clone git@github.com:GeoscienceAustralia/digitalearthau.git  $SANDBOX/digitalearthau
    cd $SANDBOX/digitalearthau
    #pre-commit install

fi

cd $CURR

#git clone git@github.com:opendatacube/datacube-core.git  $SANDBOX/datacube-core
#cd $SANDBOX/datacube-core
#pre-commit install
#conda create -n odc -c conda-forge python=3.8 datacube pre_commit
#pip install --user -e $SANDBOX/datacube-core/

