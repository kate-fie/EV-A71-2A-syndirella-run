# EV-A71-2A-syndirella-run

### Structures used for placement:
1. Fragment hits: [fragments/new_hits.sdf](fragments/new_hits.sdf). (Had to download each individual .sdf from [Fragalysis](https://fragalysis.xchem.diamond.ac.uk/viewer/react/preview/target/A71EV2A/tas/lb32627-66)).
2. Template: [x0310_relaxed_apo.pdb](fragments/x0310_relaxed_apo.pdb). Created by Matteo Ferla using [relax.ipynb](https://github.com/matteoferla/EV-A71-2A-elaborations/blob/main/iteration-2/code/relax.ipynb). 
Then edited with [prepare_template](notebooks/prepare_template.ipynb).

### Status:
**2024-03-05 10:30:** Running 

1. [x] batch0(760)
2. [x] batch1(820)
3. [x] batch2(819)
4. [x] batch3(821)
5. [x] batch4(822) --> DONE
6. [x] batch5(829) 
7. [x] batch9(814) --> stopped early
8. [x] batch10(848)
9. [x] batch11(816)  
10. [x] batch12(849)
11. [x] batch13(850)

with relaxed apo template on iris-gpu. 
Note: Tried to keep running rest of batches but got `429 Client Error: Too Many Requests`, need to change API
queries to add a delay. Also, might not have started to elaborate all base compounds in the batch, but a few due to the 
`429` error.

**2024-03-04 13:30:** Running [batch0](batches/batch0.csv) again with relaxed apo template. Job 19760 on iris-gpu. 

Currently running [batch0](batches/batch0.csv) as of 2024-02-29 19:00 with 9 base compounds and placing the top 10K.
➡️ Placements didn't work since template I was using still contained the ligand...

