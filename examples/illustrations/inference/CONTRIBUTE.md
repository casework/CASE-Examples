# Illustration development

This page makes some trades from ease of development for the sake of presentation with static, version-controlled files.  The README is backed by JSON snippets, as inline data samples and as functional JSON-LD data.  The file [`inference.json`](inference.json) is also backed by those JSON snippets, and that composite JSON-LD file also backs one (and soon to be more) queries that support the README.

`make` handles compiling the README and its supporting files.  So, to edit the README, **don't edit README.md**.

Instead, one of these files should be modified:
* [`README.md.in`](README.md.in) - Template file housing the illustration text and data insertion points.  Generated into README.md.  Uses Automake-style substitution patterns (i.e. `@STRING_TO_REPLACE@`), executed in the `Makefile`'s target `.generated-README.md`.
  - The `@` string relies on a name scheme for patterns to be substituted - they are expected to be file names, alphabetic characters converted to uppercase, non-alphanumeric characters converted to underscores.
* `inference-*.json` - snippet JSON file, built into `inference.json`.
  - [`inference-supplementary.json`](inference-supplementary.json) contains graph data not displayed in the README.
* `query-*.sparql` - Query files.

After committing changes to any of the files in this directory, run `make`.  If a Git-tracked file differs from a state that is freshly computed, a prompt will be given to review a `diff` output.  If the `diff` looks like it contains expected changes, a `cp` command is provided in the last `make` output line starting `UPDATE:`.

Note that resources backing this illustration are shared among all of the examples in this repository.  So, before `make` will work in this directory, `make` should be run at the repository's top directory.  (The command to run is only "`make`".  Some resources will be downloaded and built, and `make` from there will also do one build-pass over all of the examples.  This should have no effect on the Git-tracked state.)


## Adding JSON snippets or queries

Following the name scheme `inference-*.json` and `query-*.sparql` and the "upper-case, under-score" substitution pattern in `README.md.in` will be sufficient to add a new JSON-LD snippet or SPARQL query.


## Running tests

Running `make check` will validate `inference.json` against the latest version of CASE with the latest validation mechanism, including any draft concepts in `drafting.ttl`.

To normalize the JSON-LD snippets, run `make normalize`.  `git status` will report any files that changed.


## Revising draft ontology concepts

Should the `drafting.ttl` file be significantly revised (e.g. removing a class), please keep concepts synchronized with the change proposal linked from the CASE ticket linked by `rdfs:seeAlso`.
