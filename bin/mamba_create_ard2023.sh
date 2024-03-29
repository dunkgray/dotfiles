#!/bin/bash

# datacube==1.8.6 due to latest version of ODC prob' needs shapely 2.0
# And that isn't installed.
# datacube==1.8.9 should work too
# If this is modified it has to be tested. It can abort with conflicts.
mamba create -n ard2023 -y -c conda-forge python=3.8\
      datacube==1.8.6 \
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
      hdf5-external-filter-plugins-bitshuffle
