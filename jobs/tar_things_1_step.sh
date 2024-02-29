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

cd /data/xchem-fragalysis/kfieseler/D68EV3CPROA/elabs/rdkit_place/1_step

pwd;
tar -czvf batch_1-5.tar.gz batch_1 batch_2 batch_3 batch_4 batch_5
tar -czvf batch_6-10.tar.gz batch_6 batch_7 batch_8 batch_9 batch_10
tar -czvf batch_11-15.tar.gz batch_11 batch_12 batch_13 batch_14 batch_15
tar -czvf batch_16-20.tar.gz batch_16 batch_17 batch_18 batch_19 batch_20

echo 'COMPLETE'