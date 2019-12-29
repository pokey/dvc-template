# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.3.0
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# # Foo
# Example of doing some input processing

# ## Imports

# +
from src.io import Paths, read_config


# -

# ## Parameters

# + tags=["parameters"]
root_path = None
experiment_id = None
# -

# ## Preliminaries

# ### Notebook setup

# %load_ext autoreload
# %autoreload 2

# ### Paths

paths = Paths(root_path, experiment_id)
paths.make_dirs()
paths.display()

# ## Config

config = read_config(paths.config)
config
