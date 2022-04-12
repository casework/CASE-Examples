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

illustrations_srcdir := $(top_srcdir)/examples/illustrations

all: \
  all-illustration-nosrc \
  query-select-files.md

.PHONY: \
  all-illustration-nosrc \
  check-illustration-nosrc \
  clean-illustration-nosrc

all-illustration-nosrc:
	$(MAKE) \
	  --file $(illustrations_srcdir)/src/illustration-nosrc.mk

check: \
  check-illustration-nosrc \
  query-select-files.md

check-illustration-nosrc:
	$(MAKE) \
	  --file $(illustrations_srcdir)/src/illustration-nosrc.mk \
	  check

clean: \
  clean-illustration-nosrc
	@rm -f \
	  query-*.md

clean-illustration-nosrc:
	@$(MAKE) \
	  --file $(illustrations_srcdir)/src/illustration-nosrc.mk \
	  clean

query-select-files.md: \
  $(top_srcdir)/.venv.done.log \
  exif_data.json \
  query-select-files.sparql
	source $(top_srcdir)/venv/bin/activate \
	  && case_sparql_select \
	    --disallow-empty-results \
	    _$@ \
	    query-select-files.sparql \
	    exif_data.json
	mv _$@ $@
