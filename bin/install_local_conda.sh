#!/bin/bash

set -x

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
exit 1

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

conda create --name dsg -y python=3.8 psycopg2 click gdal<3 proj4<6 jupyterlab nodejs \
    rasterio xarray pyyaml dask boltons netcdf4 lark-parser pypeg2 cachetools \
    singledispatch sqlalchemy structlog scipy \
    cattrs ciso8601 h5py pyproj ruamel.yaml shapely scikit-image \
    deepdiff flake8 pep8-naming python-rapidjson rio-cogeo numexpr \
    pytest black
