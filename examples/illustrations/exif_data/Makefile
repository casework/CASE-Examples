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

all: \
  query-select-files.md

.PHONY: \
  check-0.3.0 \
  check-0.4.0

check: \
  check-0.3.0 \
  check-0.4.0 \
  query-select-files.md

check-0.3.0: \
  $(top_srcdir)/.dependencies.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && validate \
	    $(top_srcdir)/dependencies/case-0.3.0.pkl \
	    exif_data.json

check-0.4.0: \
  $(top_srcdir)/.dependencies.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && validate \
	    $(top_srcdir)/dependencies/case-0.4.0.pkl \
	    exif_data.json

clean:
	@rm -f \
	  query-*.md

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
