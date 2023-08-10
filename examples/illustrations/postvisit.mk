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

top_srcdir := $(shell cd ../.. ; pwd)

# Set up descending into each directory that has a Makefile.
illustration_dirs := $(shell ls */Makefile | xargs dirname)

all_drafting_ttl := $(wildcard */drafting.ttl)

all_jsonld := $(foreach illustration_dir,$(illustration_dirs),$(illustration_dir)/$(illustration_dir).json)

all: \
  kb.ttl

all-drafting.ttl: \
  $(all_drafting_ttl)
	source $(top_srcdir)/venv/bin/activate \
	  && rdfpipe \
	    --output-format turtle \
	    $^ \
	    > _$@
	mv _$@ $@

check: \
  kb.ttl

clean:
	@rm -f \
	  _all-drafting.ttl \
	  _kb.ttl \
	  all-drafting.ttl \
	  kb.ttl

kb.ttl: \
  $(all_jsonld) \
  all-drafting.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && rdfpipe \
	    --output-format turtle \
	    $(all_jsonld) \
	    > _$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --metashacl \
	    --ontology-graph all-drafting.ttl \
	    _$@
	mv _$@ $@
