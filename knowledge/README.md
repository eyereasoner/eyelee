# Prolog runtime knowledge

- `runtime.pl`: the Prolog clauses that control expressions and collections.
- `regelrecht/`: generated laws and scenario vocabulary imported from the
  unchanged upstream contract.
- `examples/`: independently authored native Prolog examples.
- `manifest.json`: the browser's law, grammar, scenario, and question index.

The CLI loads `.pl` ruleworks from a given law directory. The browser loads
only the laws named in this manifest. Both use the same vendored eyelang source.
See [the project README](../README.md) for writing and running a rulework.
