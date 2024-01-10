#!/usr/bin/make -f

# Portions of this file contributed by NIST are governed by the
# following statement:
#
# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to Title 17 Section 105 of the
# United States Code, this software is not subject to copyright
# protection within the United States. NIST assumes no responsibility
# whatsoever for its use by other parties, and makes no guarantees,
# expressed or implied, about its quality, reliability, or any other
# characteristic.
#
# We would appreciate acknowledgement if the software is used.

SHELL := /bin/bash

top_srcdir := $(shell cd ../../../.. ; pwd)

all: \
  partitions-prov-focused-27762c2c.svg \
  partitions-prov-focused-5a191a50.svg \
  partitions-prov-focused-8589174a.svg \
  partitions-prov-focused-b6ab7ce4.svg

%.svg: \
  %.dot
	dot \
	  -T svg \
	  -o _$@ \
	  $<
	mv _$@ $@

check: \
  all

clean:
	@rm -f \
	  *.dot \
	  *.svg

partitions-prov-focused-27762c2c.dot: \
  ../partitions.json \
  ../partitions-prov.ttl
	export CDO_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --entity-ancestry 'http://example.org/kb/Relationship-27762c2c-7140-4ea9-924e-5c9941671c82' \
	      --use-deterministic-uuids \
	      _$@ \
	      ../partitions.json \
	      ../partitions-prov.ttl
	mv _$@ $@

partitions-prov-focused-5a191a50.dot: \
  ../partitions.json \
  ../partitions-prov.ttl
	export CDO_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --entity-ancestry 'http://example.org/kb/Relationship-5a191a50-c16f-4566-b8da-e4847f9bf9d1' \
	      --use-deterministic-uuids \
	      _$@ \
	      ../partitions.json \
	      ../partitions-prov.ttl
	mv _$@ $@

partitions-prov-focused-8589174a.dot: \
  ../partitions.json \
  ../partitions-prov.ttl
	export CDO_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --entity-ancestry 'http://example.org/kb/Relationship-8589174a-2a25-4b7d-9ff6-eee7f39e2fab' \
	      --use-deterministic-uuids \
	      _$@ \
	      ../partitions.json \
	      ../partitions-prov.ttl
	mv _$@ $@

partitions-prov-focused-b6ab7ce4.dot: \
  ../partitions.json \
  ../partitions-prov.ttl
	export CDO_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --entity-ancestry 'http://example.org/kb/Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2' \
	      --use-deterministic-uuids \
	      _$@ \
	      ../partitions.json \
	      ../partitions-prov.ttl
	mv _$@ $@
