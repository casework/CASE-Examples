#!/usr/bin/make -f

# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to title 17 Section 105 of the
# United States Code this software is not subject to copyright
# protection and is in the public domain. NIST assumes no
# responsibility whatsoever for its use by other parties, and makes
# no guarantees, expressed or implied, about its quality,
# reliability, or any other characteristic.
#
# We would appreciate acknowledgement if the software is used.

SHELL := /bin/bash

top_srcdir := $(shell cd ../../.. ; pwd)

drafting_pkl_sources := $(wildcard .ontology/*.ttl)

query_sparql_files := $(wildcard query-*.sparql)
query_md_files := $(foreach query_sparql_file,$(query_sparql_files),$(subst .sparql,.md,$(query_sparql_file)))

generated_readme_sed_sources := \
  $(wildcard inference-*.json) \
  $(query_md_files) \
  $(query_sparql_files)

all: \
  README.md

.PHONY: \
  normalize

.generated-README.md: \
  .generated-README.sed \
  README.md.in
	sed -f .generated-README.sed README.md.in > $@_
	mv $@_ $@

.generated-README.sed: \
  $(generated_readme_sed_sources)
	for x in $^ ; do \
          echo "/@$$(echo $${x} | tr '[:lower:]' '[:upper:]' | tr . _ | tr - _)@/r $${x}" ; \
          echo "/@$$(echo $${x} | tr '[:lower:]' '[:upper:]' | tr . _ | tr - _)@/d" ; \
	done >> _$@
	mv _$@ $@

# Note the recipe's dependency order matters, due to use of $^.
# * First dependency is the Python script.
# * Second dependency is the base graph file that houses the context dictionary and @graph node.
# * The remainder is the rest of the JSON files to be folded into the whole inference.json.
.generated-inference.json: \
  inference_json.py \
  inference-base.json \
  inference-photolocation-identification.json \
  inference-photolocation-skeptic.json \
  inference-supplementary.json \
  inference-xlsx-authentication.json
	python3 $^ > _$@
	mv _$@ $@

README.md: \
  .generated-README.md
	diff \
	  $@ \
	  .generated-README.md \
	  || (echo "UPDATE:examples/illustrations/inference/Makefile:The generated README.md does not match the Git-tracked README.md.  If the above reported changes look fine, run 'cp .generated-README.md README.md' to get a file ready to commit to Git." >&2 ; exit 1)
	test -r $@ && touch $@

check: \
  README.md \
  check-0.4.0 \
  inference.json

check-0.4.0: \
  drafting.pkl \
  inference.json
	source $(top_srcdir)/venv/bin/activate \
	  && validate \
	    drafting.pkl \
	    inference.json

clean:
	@rm -f \
	  *.sed \
	  .generated-* \
	  .normalized-* \
	  drafting.pkl \
	  query-*.md

drafting.pkl: \
  $(drafting_pkl_sources) \
  $(top_srcdir)/.dependencies.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && serialize \
	    -c drafting \
	    -o _$@ \
	    .ontology
	mv _$@ $@

inference.json: \
  .generated-inference.json
	diff \
	  $@ \
	  .generated-inference.json \
	  || (echo "UPDATE:examples/illustrations/inference/Makefile:The generated inference.json does not match the Git-tracked inference.json.  If the above reported changes look fine, run 'cp .generated-inference.json inference.json' to get a file ready to commit to Git." >&2 ; exit 1)
	test -r $@ && touch $@

normalize:
	ls inference-*.json \
	  | while read x; do python3 -m json.tool $$x .normalized-$$x && mv .normalized-$$x $$x ; done

query-%.md: \
  query-%.sparql \
  $(top_srcdir)/.venv.done.log \
  drafting.ttl \
  inference.json
	source $(top_srcdir)/venv/bin/activate \
	  && case_sparql_select \
	    _$@ \
	    $< \
	    drafting.ttl \
	    inference.json
	mv _$@ $@
