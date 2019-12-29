from IPython.display import display, display_markdown


def assert_all_true(df, bool_series, message):
    if not bool_series.all():
        display_markdown(f"**ERROR**: `{message}`", raw=True)
        display(df[~bool_series])
        assert(False)
