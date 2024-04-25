#!venv/bin/env python3
"""
Testing placement of problem bases on IRIS and locally to compare results.
"""
from fragmenstein import Laboratory, Wictor, Igor
from fragmenstein.laboratory.validator import place_input_validator
from rdkit import Chem
import os, logging
import pandas as pd
from typing import List

def add_hits(df: pd.DataFrame,
             hits_path: str) -> pd.DataFrame:
    """
    This function adds the hits_path as mol objects to input_df['hits_path'].
    """
    # load hits_path either from mol or sdf
    if os.path.splitext(hits_path)[1] == '.mol':
        print('This is a mol file')
        frag_hits: List[Chem.Mol] = [Chem.MolFromMolFile(hits_path.strip())]
    else:
        with Chem.SDMolSupplier(hits_path.strip()) as sd:
            frag_hits: List[Chem.Mol] = list(sd)
    # Find which hits are in the hit_names
    for i, row in df.iterrows():
        hits_names = row['hits'].split(' ')
        orig_num = len(hits_names)
        hits = [
            hit for hit in frag_hits
            if any(hit_name in hit.GetProp('_Name') for hit_name in hits_names)
        ]
        df.at[i, 'hits'] = hits
        if len(hits) != orig_num:
            print('number of hits not the same as original')
            print(hits)
    return df

def setup_Fragmenstein(template_path: str,
                       place: str) -> Laboratory:
    """
    This function sets up Fragmenstein to run.
    """
    if place == 'rdkit_place':
        if not os.path.exists('rdkit_place'):
            os.mkdir('rdkit_place')
        os.chdir('rdkit_place')
        Wictor.work_path = os.getcwd()
        Wictor.monster_throw_on_discard = True  # stop this merger if a fragment cannot be used.
        Wictor.monster_joining_cutoff = 5  # Å
        Wictor.quick_reanimation = False  # for the impatient
        Wictor.error_to_catch = Exception  # stop the whole laboratory otherwise
        Wictor.enable_stdout(logging.INFO)
        Wictor.enable_logfile(os.path.join(os.getcwd(), f'fragmenstein.log'), logging.INFO)
        Laboratory.Victor = Wictor
    Igor.init_pyrosetta()
    with open(template_path) as fh:
        pdbblock: str = fh.read()
    lab = Laboratory(pdbblock=pdbblock,
                     covalent_resi=None,
                     run_plip=False)
    return lab

def main():
    # Load df
    csv_path = os.path.join(os.getcwd(), 'MASTER_10_REPEATS.csv')
    df = pd.read_csv(csv_path)
    df.drop(columns=['reactants','reaction_names','num_steps','frag_small','compound_set'], inplace=True)
    #df.rename(columns={'compound_set':'name'}, inplace=True)
    # Load fragments
    hits_path = os.path.join(os.getcwd(), 'A71EV2A_combined.sdf')
    # Load template
    template_path = os.path.join(os.getcwd(), 'Ax0310_apo-desolv.pdb')
    # Initiate laboratory
    lab: Laboratory = setup_Fragmenstein(template_path, 'rdkit_place')
    # Add hits path to df
    df = add_hits(df, hits_path)
    # Place fragments
    placements: pd.DataFrame = lab.place(place_input_validator(df), n_cores=8, timeout=240)
    placements.to_csv('iris_rdkit_place.csv')

if __name__ == '__main__':
    main()