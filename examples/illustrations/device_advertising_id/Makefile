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
  all-review \
  query-select_advertising_ids.md

.PHONY: \
  all-review \
  check-review \
  clean-review

all-review:
	$(MAKE) \
	  --file $(illustrations_srcdir)/src/review.mk

check: \
  check-review \
  query-select_advertising_ids.md

check-review:
	$(MAKE) \
	  --file $(illustrations_srcdir)/src/review.mk \
	  check

clean: \
  clean-review

clean-review:
	@$(MAKE) \
	  --file $(illustrations_srcdir)/src/review.mk \
	  clean

query-select_advertising_ids.md: \
  $(top_srcdir)/.venv.done.log \
  device_advertising_id.json \
  drafting.ttl \
  query-select_advertising_ids.sparql
	source $(top_srcdir)/venv/bin/activate \
	  && case_sparql_select \
	    --disallow-empty-results \
	    _$@ \
	    query-select_advertising_ids.sparql \
	    device_advertising_id.json \
	    drafting.ttl
	mv _$@ $@
