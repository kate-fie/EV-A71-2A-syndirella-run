#!/bin/bash

#: << USAGE #########
# source run_job.env
# condor_submit /data/xchem-fragalysis/shared/target_script.condor
#USAGE #########

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

cd /data/xchem-fragalysis/kfieseler/syndirella

pwd;
export BATCH_NUM=$1
export ROOT_INPUT=/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/placements_april8/batches/
export INPUT="${ROOT_INPUT}batch_${BATCH_NUM}.csv"
export OUTPUT_DIR="/data/xchem-fragalysis/kfieseler/A71EV2A_run4/"
export TEMPLATE="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/fragments/TO_USE/Ax0310_relaxed_apo.pdb";
export HITS="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/fragments/TO_USE/A71EV2A_combined.sdf";
export SYNDIRELLA_BASE_PATH="/data/xchem-fragalysis/kfieseler/syndirella";
export BATCH_SIZE=10000

echo "Running syndirella pipeline"
echo "INPUT: $INPUT"
echo "OUTPUT_DIR: $OUTPUT_DIR"
echo "TEMPLATE: $TEMPLATE"
echo "HITS: $HITS"
echo "BATCH_SIZE: $BATCH_SIZE"

nice -19 python /data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/placements_april8/run_batches/run_job.py \
--input $INPUT \
--output $OUTPUT_DIR \
--template $TEMPLATE \
--hits $HITS \
--batch_size $BATCH_SIZE;

echo 'COMPLETE'