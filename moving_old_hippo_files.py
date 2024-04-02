import os
import shutil
import pandas as pd
import gzip
import pickle
import fnmatch

def find_uuid_in_product_file(directory):
    for file in os.listdir(directory):
        if fnmatch.fnmatch(file, '*products*.pkl.gz'):
            print(f"Reading file: {file}")
            with gzip.open(os.path.join(directory, file), 'rb') as f:
                df = pd.read_pickle(f)
                # Assuming the UUID is in a column named 'uuid'
                return df['uuid'].unique().tolist()

def move_invalid_uuid_files(main_directory, destination_directory='old_hippo_files'):
    if not os.path.exists(destination_directory):
        os.makedirs(destination_directory)

    for root, dirs, files in os.walk(main_directory):
        if 'base-check' in root.split(os.sep):
            continue  # Skip directories containing 'base-check'

        uuids = find_uuid_in_product_file(root)
        print(f"Found UUIDs: {uuids}")
        if not uuids:
            continue

        for file in files:
            if file.endswith('to_hippo.pkl.gz'):
                file_uuid = file.split('_')[0]  # Assuming the UUID is before the first underscore
                if file_uuid not in uuids:
                    source_path = os.path.join(root, file)
                    destination_path = os.path.join(destination_directory, file)

                    # Ask the user for confirmation before moving the file
                    user_input = input(f"Do you want to move '{file}' to '{destination_directory}'? (y/n): ")
                    if user_input.lower() == 'y':
                        shutil.move(source_path, destination_path)
                        print(f"Moved '{file}' to '{destination_directory}'.")
                    else:
                        print(f"Skipping '{file}'.")

# Example usage
main_directory = '/data/xchem-fragalysis/kfieseler/A71EV2A_run3'
move_invalid_uuid_files(main_directory)
