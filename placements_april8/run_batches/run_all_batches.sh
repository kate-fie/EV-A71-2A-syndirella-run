#!/bin/bash

#: << USAGE #########
# source run_job.env
# condor_submit /data/xchem-fragalysis/shared/target_script.condor
#USAGE #########

export HOST=${HOST:-$(hostname)}
export USER=${USER:-$(users)}
export HOME=${HOME:-$_CONDOR_SCRATCH_DIR}
source /etc/os-release
echo "Running script $0 as $USER on $HOST which runs $PRETTY_NAME"
# ---------------------------------------------------------------

source /data/xchem-fragalysis/kfieseler/.bashrc
export JOB_INNER_SCRIPT="/data/xchem-fragalysis/kfieseler/EV-A71-2A-syndirella-run/placements_april8/run_batches/run_a_batch.sh"

for i in {0..1}; do
  export BATCH_NUM=$i
  source /data/xchem-fragalysis/kfieseler/run_job.env
  condor_submit /data/xchem-fragalysis/shared/target_script.condor
  sleep 1m
done

echo "All batches started"


