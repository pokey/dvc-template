DVC Template
============

An example of a dvc / jupytext / papermill-based experimentation setup.

Project Organization
------------

    ├── LICENSE
    ├── README.md          <- The top-level README for developers using this project.
    │
    ├── config             <- Config for each experiment, in yaml format.
    │
    ├── data
    │   ├── external       <- Data from third party sources.
    │   ├── interim        <- Intermediate data that has been transformed.
    │   ├── processed      <- The final, canonical data sets for modeling.
    │   └── raw            <- The original, immutable data dump.
    │
    ├── notebooks          <- Jupyter notebooks, in python-lite format:representation.
    │                         See https://jupytext.readthedocs.io/en/latest/formats.html#the-light-format
    │
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── scripts            <- Scripts for notebook processing / dvc setup
    │
    ├── setup.cfg          <- Python configuration
    ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
    ├── src                <- Source code for use in this project.
    │   └── __init__.py    <- Makes src a Python module
    │
    └── stages             <- Dvc stage files


--------

## Dependencies

    brew install coreutils

## Getting existing info

Make sure you're setup with `s3`, then run

    dvc pull

## Adding new data to an existing experiment

1. First make sure you're up to date and make a new branch:

        git pull
        eval $(botoenv -p $AWS_ACCOUNT)
        dvc pull
        git checkout -b new-data

1. Then put the new data into the desired folder within `data/raw`.
1. When you're done updating the raw files, run:

        dvc repro -R .

1. Take a look at the outputs and make sure you're happy.  If so, commit and
   push the changes with:

        git commit -am "MESSAGE"
        git pull-request -ocpb master 

   replacing `MESSAGE` with an appropriate description.
1. Get your PR approved and merge it
1. Go back to master branch and delete the merged branch:

        git checkout master
        git br -d new-data


## Running a new experiment
Something like the following:

    EXPERIMENT_NAME="something"
    echo 'foo: "bar"' > "config/$EXPERIMENT_NAME.yaml"
    ./scripts/setup-pipeline.sh "$EXPERIMENT_NAME"
    dvc repro -R "stages/$EXPERIMENT_NAME"

Where `something` is replaced by the name of an experiment you'd like to
analyse, and the `echo` line contains config.

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
