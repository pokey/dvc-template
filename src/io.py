from pathlib import Path

import pandas as pd
import yaml
from bs4 import BeautifulSoup  # for reading xml data file

from src.config import Config
from src.notebook import display_var


def read_config(path):
    with open(path) as f:
        return Config(**yaml.safe_load(f))


class Paths:
    def __init__(self, root_path, experiment_id):
        root_dir = Path(root_path)
        data_dir = root_dir / "data"
        raw_dir = data_dir / "raw"
        interim_dir = data_dir / "interim"
        processed_dir = data_dir / "processed"
        figures_dir = root_dir / "reports/figures"
        config_dir = root_dir / "config"

        self.raw_dir = raw_dir / experiment_id
        self.processed_dir = processed_dir / experiment_id
        self.interim_dir = interim_dir / experiment_id
        self.figures_dir = figures_dir / experiment_id
        self.config = config_dir / f"{experiment_id}.yaml"

    def make_dirs(self):
        self.processed_dir.mkdir(parents=True, exist_ok=True)
        self.interim_dir.mkdir(parents=True, exist_ok=True)
        self.figures_dir.mkdir(parents=True, exist_ok=True)

    def display(self):
        display_var("raw_dir", self.raw_dir)
        display_var("interim_dir", self.processed_dir)
        display_var("processed_dir", self.processed_dir)
        display_var("figures_dir", self.figures_dir)
        display_var("config", self.config)
