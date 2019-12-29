#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Command-line parameters
if [ $# -ne 1 ] ; then
    printf "Usage: run-notebook.sh {experiment_id}\n" 1>&2
    exit 1
fi
experiment_id="$1"

run_notebook="./scripts/run-notebook.sh"

experiment_raw_dir="data/raw/$experiment_id"
experiment_interim_dir="data/interim/$experiment_id"
experiment_processed_dir="data/processed/$experiment_id"

experiment_notebook_dir="notebooks/$experiment_id"
experiment_stage_dir="stages/$experiment_id"
experiment_config="config/$experiment_id.yaml"

mkdir -p "$experiment_stage_dir" "$experiment_notebook_dir"

# Add raw data
dvc add -f "$experiment_stage_dir/raw.dvc" "$experiment_raw_dir" 

# Process raw data
notebook_name="foo"
notebook_in="notebooks/$notebook_name.py"
command="$run_notebook '$notebook_in' '$experiment_id'"
dvc run \
    --no-exec \
    -f "$experiment_stage_dir/$notebook_name.dvc" \
    -d "$experiment_raw_dir" \
    -d "$notebook_in" \
    -d "src/io.py" \
    -d "src/dataframe.py" \
    -d "src/notebook.py" \
    -o "$experiment_interim_dir/foo.csv" \
    -o "$experiment_interim_dir/foo.parquet" \
    -o "$experiment_notebook_dir/$notebook_name.ipynb" \
    "$command"

# More processing
notebook_name="bar"
notebook_in="notebooks/$notebook_name.py"
command="$run_notebook '$notebook_name' '$experiment_id'"
dvc run \
    --no-exec \
    -f "$experiment_stage_dir/$notebook_name.dvc" \
    -d "$experiment_raw_dir" \
    -d "$notebook_in" \
    -d "src/io.py" \
    -d "src/dataframe.py" \
    -d "src/notebook.py" \
    -d "$experiment_interim_dir/foo.parquet" \
    -o "$experiment_interim_dir/bar.csv" \
    -o "$experiment_interim_dir/bar.parquet" \
    -o "$experiment_notebook_dir/$notebook_name.ipynb" \
    "$command"
