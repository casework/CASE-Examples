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

case_develop_ttls := \
  $(wildcard CASE-develop/ontology/*/*.ttl) \
  $(wildcard CASE-develop/dependencies/UCO/ontology/*/*.ttl) \
  $(wildcard CASE-develop/dependencies/UCO/ontology/uco/*/*.ttl)

case_unstable_ttls := \
  $(wildcard CASE-unstable/ontology/*/*.ttl) \
  $(wildcard CASE-unstable/dependencies/UCO/ontology/*/*.ttl) \
  $(wildcard CASE-unstable/dependencies/UCO/ontology/uco/*/*.ttl)

case_unstable_next_major_ttls := \
  $(wildcard CASE-unstable-2.0.0/ontology/*/*.ttl) \
  $(wildcard CASE-unstable-2.0.0/dependencies/UCO/ontology/*/*.ttl) \
  $(wildcard CASE-unstable-2.0.0/dependencies/UCO/ontology/uco/*/*.ttl)

top_srcdir := $(shell cd .. ; pwd)

all: \
  CASE-develop.ttl \
  CASE-unstable.ttl \
  CASE-unstable-2.0.0.ttl

CASE-develop.ttl: \
  $(top_srcdir)/.venv.done.log \
  $(case_develop_ttls)
	rm -f _$@
	source $(top_srcdir)/venv/bin/activate \
	  && rdfpipe \
	    --output-format turtle \
	    $(case_develop_ttls) \
	    > _$@
	mv _$@ $@

CASE-unstable.ttl: \
  $(top_srcdir)/.venv.done.log \
  $(case_unstable_ttls)
	rm -f _$@
	source $(top_srcdir)/venv/bin/activate \
	  && rdfpipe \
	    --output-format turtle \
	    $(case_unstable_ttls) \
	    > _$@
	mv _$@ $@

CASE-unstable-2.0.0.ttl: \
  $(top_srcdir)/.venv.done.log \
  $(case_unstable_next_major_ttls)
	rm -f _$@
	source $(top_srcdir)/venv/bin/activate \
	  && rdfpipe \
	    --output-format turtle \
	    $(case_unstable_next_major_ttls) \
	    > _$@
	mv _$@ $@

clean:
	@rm -f \
	  CASE-develop.ttl \
	  CASE-unstable.ttl \
	  CASE-unstable-2.0.0.ttl
