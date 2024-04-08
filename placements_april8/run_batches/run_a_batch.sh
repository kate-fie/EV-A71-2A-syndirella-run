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

conda activate fragmenstein

cd /data/xchem-fragalysis/kfieseler/syndirella

pwd;
export INPUT="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/placements_april8/batches/batch_" + $BATCH_NUM + ".csv"
export OUTPUT_DIR="/data/xchem-fragalysis/kfieseler/A71EV2A_run4/TEST/"
export TEMPLATE="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/fragments/TO_USE/Ax0310_relaxed_apo.pdb";
export HITS="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/fragments/TO_USE/A71EV2A_combined.sdf";
export SYNDIRELLA_BASE_PATH="/data/xchem-fragalysis/kfieseler/syndirella";

echo "Running syndirella pipeline"
echo "INPUT: $INPUT"
echo "OUTPUT_DIR: $OUTPUT_DIR"
echo "TEMPLATE: $TEMPLATE"
echo "HITS: $HITS"

nice -19 python /data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/jobs/run_job.py \
--input $INPUT \
--output $OUTPUT_DIR \
--template $TEMPLATE \
--hits $HITS;

echo 'COMPLETE'