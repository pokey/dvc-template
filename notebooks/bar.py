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

# # Bar
# Example of doing some notebook stuff

# ## Imports

# +
from src.io import Paths


# -

# ## Constants

foo = "hello"

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
paths.display()
