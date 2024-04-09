#!/usr/bin/env python3
"""
Run the pipeline 🏁
"""
import sys
import os

import pandas as pd

parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(parent_dir)
import argparse
from typing import (List, Dict, Tuple, Union, Any)
import os
import importlib.util

# Get the base path and construct the full path to the module
syndirella_path = os.environ['SYNDIRELLA_BASE_PATH']
pipeline_module_path = os.path.join(syndirella_path, 'syndirella/pipeline.py')

# Load the module specified by the path
spec = importlib.util.spec_from_file_location("syndirella.pipeline", pipeline_module_path)
pipeline = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pipeline)


def config_parser():
    parser = argparse.ArgumentParser(description="Run the job with different variable changes.")
    parser.add_argument('--input', type=str, help="Input .csv for the pipeline.")
    parser.add_argument('--output', type=str, help="Output directory for the pipeline.")
    parser.add_argument('--template', type=str, help="Absolute path to template for placements.")
    parser.add_argument('--hits', type=str, help="Absolute path to hits for placements. Can be either"
                                                 " .sdf or .mol.")
    parser.add_argument('--products', type=str, help="Absolute path to products for placements.")
    parser.add_argument('--batch_size', type=int, help="Batch size for the pipeline.")
    return parser


def main():
    parser = config_parser()
    # load
    settings: Dict[str, Any] = vars(parser.parse_args())
    input_csv_path: str = settings['input']
    output_dir: str = settings['output']
    template = settings['template']
    hits = settings['hits']
    batch_num = 10000
    if settings['batch_size']:
        batch_num = settings['batch_size']
    additional_info = ['compound_set']
    manual_routes = True

    # Run pipeline
    print('Running pipeline...')
    pipeline.run_pipeline(csv_path=input_csv_path,
                          output_dir=output_dir,
                          template_path=template,
                          hits_path=hits,
                          batch_num=batch_num,
                          additional_columns=additional_info,
                          manual_routes=manual_routes)
    print('Done!')


if __name__ == '__main__':
    main()
