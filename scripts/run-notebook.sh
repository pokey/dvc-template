#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Command-line parameters
if [ $# -ne 2 ] ; then
    printf "Usage: run-notebook.sh {notebook} {experiment_id}" 1>&2
    exit 1
fi
notebook_path="$1"
experiment_id="$2"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

root_dir="$(git rev-parse --show-toplevel)"

notebook_filename=$(basename -- "$notebook_path")
notebook_filename="${notebook_filename%.*}"

python_light_repr="$root_dir/notebooks/$notebook_filename.py"
final_notebook_dir="$root_dir/notebooks/$experiment_id"
final_notebook="$final_notebook_dir/$notebook_filename.ipynb"

if [ "$final_notebook" -nt "$python_light_repr" ] ; then
    echo -e "${RED}ERROR${NC}: '$final_notebook' newer than '$python_light_repr'; refusing to overwrite."
    echo "If you'd like to overwrite '$python_light_repr', run the following:"
    echo -e "${GREEN}>${NC} scripts/move-instantiated-notebook-back.sh '$final_notebook'"
    exit 1
fi

mkdir -p "$final_notebook_dir"

# Generate a relative path back to the git root.  Using this as the root path
# and the notebook dir as cwd ensures that we can manually run the generated
# notebook if we're working directly on it.
root_relative_to_notebook="$(
    realpath --relative-to "$final_notebook_dir" "$root_dir"
)"

# Run notebook with parameters
jupytext --update --to notebook "$python_light_repr" -o - \
  | papermill - \
    -p experiment_id "$experiment_id" \
    -p root_path "$root_relative_to_notebook" \
    --cwd "$final_notebook_dir" \
    "$final_notebook"
