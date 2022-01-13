#!/bin/bash

# If this is modified it has to be tested. It can abort with conflicts.
conda create -n odc2020 -y -c conda-forge python=3.8 datacube pre_commit \
      structlog black pre_commit pytest \
      flake8 pep8-naming python-rapidjson numexpr requests pandoc \
      ruamel ruamel.yaml \
      croniter feedparser lxml
