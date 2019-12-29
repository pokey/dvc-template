# Remove injected parameter cells
.cells |= map(select(
    .metadata.tags
    | contains(["injected-parameters"])
    | not
))

| .cells[].metadata |= (
    # Remove papermill metadata
    del(.papermill)

    # Remove empty tags
    | with_entries(
        select(
            .key != "tags" or
            (.value | length != 0)
        )
    )
)

# Hack to workaround jupytext bug
| .metadata.jupytext = {}
