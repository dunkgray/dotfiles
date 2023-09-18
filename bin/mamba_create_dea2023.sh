#!/bin/bash

# This is untested ard2023 works
# datacube==1.8.6 due to latest version of ODC prob' needs shapely 2.0
# And that isn't installed.
# datacube==1.8.9 should work too
# If this is modified it has to be tested. It can abort with conflicts.
mamba create -n dea2023 -y -c conda-forge python=3.10\
      datacube \
      shapely==2 \
      pre_commit \
      structlog \
      black \
      pytest \
      flake8 \
      pep8-naming \
      python-rapidjson \
      numexpr \
      requests \
      pandoc \
      ruamel \
      ruamel.yaml \
      croniter \
      feedparser \
      lxml \
      h5py \
      hdf5plugin \
      pytables \
      hdf5-external-filter-plugins-bitshuffle
      # pytest-odc \ doesn't exist

python3.10 -m pip install pytest-odc
