import pandas as pd
from IPython.display import display, display_markdown


pd.options.display.max_rows = 10
pd.options.display.max_columns = None
pd.options.display.max_colwidth = 120


def display_var(var_name, var_value):
    display_markdown(f"`{var_name}`: `{repr(var_value)}`", raw=True)


def display_raw_file(path):
    display_markdown(
        f"""
### Path
`{path}`
### Contents
```
{path.read_text()}
```
""",
        raw=True,
    )


def display_df(df):
    display_markdown("### `df`", raw=True)
    display(df)
    display_markdown("### `df.info()`", raw=True)
    display(df.info())
    display_markdown("### `df.describe()`", raw=True)
    display(df.describe())
