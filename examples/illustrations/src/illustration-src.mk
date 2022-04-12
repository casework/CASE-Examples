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

top_srcdir := $(shell cd ../../../.. ; pwd)

illustration_name := $(shell cd .. ; basename $$PWD)
illustration_snippets_json := $(wildcard $(illustration_name)-*.json)
query_sparql_files := $(wildcard query-*.sparql)
query_md_files := $(foreach query_sparql_file,$(query_sparql_files),$(subst .sparql,.md,$(query_sparql_file)))

generated_readme_sed_sources := \
  $(illustration_snippets_json) \
  $(query_md_files) \
  $(query_sparql_files)

SNIPPET_COMBINER_PY ?= ../../src/generic_snippet_combiner.py

# Use a drafting.ttl file in queries, if it is present.
drafting_ttl := $(wildcard ../drafting.ttl)

all: \
  generated-README.md \
  generated-$(illustration_name).json

check:

clean:
	@rm -f \
	  *.sed \
	  generated-* \
	  query-*.md

generated-README.md: \
  README.md.in \
  generated-README.sed
	sed -f generated-README.sed README.md.in > _$@
	mv _$@ $@

generated-README.sed: \
  $(illustration_name)_base.json \
  $(generated_readme_sed_sources)
	for x in $^ ; do \
          echo "/@$$(echo $${x} | tr '[:lower:]' '[:upper:]' | tr . _ | tr - _)@/r $${x}" ; \
          echo "/@$$(echo $${x} | tr '[:lower:]' '[:upper:]' | tr . _ | tr - _)@/d" ; \
	done >> _$@
	mv _$@ $@

generated-$(illustration_name).json: \
  $(SNIPPET_COMBINER_PY) \
  $(illustration_name)_base.json \
  $(illustration_snippets_json)
	python3 $(SNIPPET_COMBINER_PY) \
	  $(illustration_name)_base.json \
	  $(illustration_snippets_json) \
	  > _$@
	mv _$@ $@

query-%.md: \
  query-%.sparql \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  generated-$(illustration_name).json
	source $(top_srcdir)/venv/bin/activate \
	  && case_sparql_select \
	    _$@ \
	    $< \
	    $(drafting_ttl) \
	    generated-$(illustration_name).json
	mv _$@ $@
