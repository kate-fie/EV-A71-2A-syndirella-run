# EV-A71-2A-syndirella-run

### Structures used for placement:
1. Fragment hits: [A71EV2A_combined.sdf](fragments/A71EV2A_combined.sdf). (Downloaded directly from Fragalysis). Checked each fragment to make sure that they overlap in space. 
2. Template: [x0310_relaxed_apo.pdb](fragments/x0310_relaxed_apo.pdb). Created by Matteo Ferla using [relax.ipynb](https://github.com/matteoferla/EV-A71-2A-elaborations/blob/main/iteration-2/code/relax.ipynb). 
Then edited with [prepare_template](notebooks/prepare_template.ipynb).

## Metadata:
- 140 base compounds

### Status:
OLD SDF NAMES batches running (similar to short code that could match more than one compound in SDF. Should only be a problem for batches using fragment x0528_A):
- batch0
- batch2
- batch5
- batch6

NEW SDF NAMES batches running (using long code exactly present in SDF):
- batch7:
- batch8:
- batch9: 
- batch10:
- batch11: 737 job, running
  - 5 compounds done
- batch12: 738 job, running
  - 6 compounds done
  - Cc1cnc(OCC(=O)N(C)C)cc1NC(=O)C1CCCO1 had timeout error
- batch13:

Not started / need to edit the csv to only rerun part of them:
- batch3:

