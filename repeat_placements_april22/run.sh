#!/bin/bash
# For scripts required see: https://gist.github.com/matteoferla/e0496d5766c12a0ae1738b943b41a536
# A few things don't work in CentOS 7 due to GNU lib C (glibc) 2.17, so it has to be run in a Singularity container

#: << USAGE #########
# source run_job.env
# condor_submit /data/xchem-fragalysis/shared/target_script.condor
#USAGE #########

#: << INSTALLATION #############
#export PIP_NO_USER=1; # gets ignored.
#export PYTHONUSERBASE=$CONDA_PREFIX; # double tap
#conda install -y -n base -c conda-forge openbabel plip;
#pip install -q fragmenstein
#pip install -q pyrosetta-help
#PYROSETTA_USERNAME=levinthal PYROSETTA_PASSWORD=paradox install_pyrosetta
#INSTALLATION ############

export HOST=${HOST:-$(hostname)}
export USER=${USER:-$(users)}
export HOME=${HOME:-$_CONDOR_SCRATCH_DIR}
source /etc/os-release;
echo "Running script ${0} as $USER in $HOST which runs $PRETTY_NAME"
# ---------------------------------------------------------------
source /data/xchem-fragalysis/kfieseler/.bashrc
# set up shell environment
export CONDA_PREFIX=/data/xchem-fragalysis/maxwin/conda
export LD_LIBRARY_PATH=/usr/local/cuda/compat:$CONDA_PREFIX/lib:$LD_LIBRARY_PATH;
# set up conda environment
source $CONDA_PREFIX/etc/profile.d/conda.sh
# debug
echo '$CONDA_PREFIX = ' $CONDA_PREFIX
echo '$LD_LIBRARY_PATH = ' $LD_LIBRARY_PATH
echo "which python = " `which python`
# test conda
echo -e "\nconda info: "
conda info

conda activate fragmenstein

cd /data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/repeat_placements_april22

pwd;

echo "Running run_rdkit_place.py";

nice -19 python run_rdkit_place.py

echo 'COMPLETE'