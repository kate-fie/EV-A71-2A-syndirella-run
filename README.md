# EV-A71-2A-syndirella-run

### Structures used for placement:
1. Fragment hits: [fragments/new_hits.sdf](fragments/new_hits.sdf). (Had to download each individual .sdf from [Fragalysis](https://fragalysis.xchem.diamond.ac.uk/viewer/react/preview/target/A71EV2A/tas/lb32627-66)).
2. Template: [x0310_relaxed_apo.pdb](fragments/x0310_relaxed_apo.pdb). Created by Matteo Ferla using [relax.ipynb](https://github.com/matteoferla/EV-A71-2A-elaborations/blob/main/iteration-2/code/relax.ipynb). 
Then edited with [prepare_template](notebooks/prepare_template.ipynb).

### Status:
**2024-03-06 16:30:** Running 

1. [x] batch0(760) --> DONE
2. [x] batch1(820) --> DONE
   3. Low success rate for 8/10 base compounds.
3. [x] batch2(819) --> partially done, killed. restarted.
   4. Placed 5/10 base compounds.
4. [x] batch3(821) --> partially done
   5. Placed 8/10 base compounds.
5. [x] batch4(822) --> DONE
6. [x] batch5(829) --> DONE
7. [x] batch9(814) --> stopped early, restarted.
8. [ ] batch10(848)
9. [x] batch11(816) --> partially done
   10. Placed 2/10 base compounds. Need to restart...
10. [ ] batch12(849)
11. [ ] batch13(850)
12. [x] batch2_1(851) --> killed early, need to restart...
    13. This batch contains 5 base compounds that were not run in batch2 (indicies 5:10).
13. [x] batch9_1(853) --> Placement of 4/9 base compounds. DONE
    14. This batch contains 9 base compounds that were not run in batch9 (indicies 0:9).
15. [ ] batch11_1(904)
    16. This batch contains 8 base compounds that were not run in batch11 (indicies 0:8).
17. [x] batch2_1(903) --> killed early,
    18. Still killed at same point.. No clear reason why... Just says killed in .err file. 
19. [ ] batch2_2()
    20. This batch contains 4 base compounds that were not run in batch2 (indicies 6:10).
    21. Does not include problem base of Cc1ccc(NC(=O)CC#N)cc1OCC(=O)N1CCOCC1

with relaxed apo template on iris-gpu. 
Note: Tried to keep running rest of batches but got `429 Client Error: Too Many Requests`, need to change API
queries to add a delay. Also, might not have started to elaborate all base compounds in the batch, but a few due to the 
`429` error.

**2024-03-04 13:30:** Running [batch0](batches/batch0.csv) again with relaxed apo template. Job 19760 on iris-gpu. 

Currently running [batch0](batches/batch0.csv) as of 2024-02-29 19:00 with 9 base compounds and placing the top 10K.
➡️ Placements didn't work since template I was using still contained the ligand...

### Errors:

- batch1:
  - Nearly all base compounds have a <2% success rate except for:
    - WCNAXNCVZXMWKF-UHFFFAOYSA-N Cc1cnc(OCC(=O)N2CCOCC2)cc1NC(=O)CC#N
    - FQGGXMVTNBDGEE-UHFFFAOYSA-N 
  - IGUPJTYXYZPOEC-UHFFFAOYSA-N N#CCC(=O)Nc1cccc(NC(=O)CO)c1:
    - Distance errors to fragments too far.
  
### Problem bases:
- batch4:
  - CC(=O)Nc1c(CNS(C)(=O)=O)ccc(OCC(=O)N(C)C)c1Br:
    - All products of 2nd step filtered out before 3rd step.
  - CC(=O)Nc1cccc(OCC(=O)N(C)C)c1CNS(C)(=O)=O
    - Step 2 in this route using Williamson_ether_synthesis
An error occurred in the route elaboration: The reactants are the same in reaction Williamson_ether_synthesis in mol CC(=O)Nc1cccc(O)c1Br and CN(C)C(=O)CCl.
- batch9:
  - Cc1cc(NC(=O)CO)cc(OCC(=O)N(C)C)c1
  - Cc1cc(NC(=O)CO)cc(OCC(=O)N(C)C)c1
  - Cc1cnc(OCC(=O)N(C)C)cc1NC(=O)CO
    - Problem at start of 2nd step of TBS alcohol deprotection...
    - Might be because no reactants are left after filtering...
    -An error occurred in the route elaboration: list index out of range
Traceback (most recent call last):
  File "/data/xchem-fragalysis/kfieseler/syndirella/syndirella/cobblers_workshop/CobblersWorkshop.py", line 68, in get_final_library
    slipper.get_products()
  File "/data/xchem-fragalysis/kfieseler/syndirella/syndirella/slipper/Slipper.py", line 52, in get_products
    self.products: pd.DataFrame = slipper_synth.get_products()
  File "/data/xchem-fragalysis/kfieseler/syndirella/syndirella/slipper/slipper_synthesizer/SlipperSynthesizer.py", line 57, in get_products
    self.filter_analogues()
  File "/data/xchem-fragalysis/kfieseler/syndirella/syndirella/slipper/slipper_synthesizer/SlipperSynthesizer.py", line 120, in filter_analogues
    self.filter_analogues_by_size()
  File "/data/xchem-fragalysis/kfieseler/syndirella/syndirella/slipper/slipper_synthesizer/SlipperSynthesizer.py", line 172, in filter_analogues_by_size
    if len(list(self.analogues_dataframes_to_react.values())[0]) > 10000:
IndexError: list index out of range
