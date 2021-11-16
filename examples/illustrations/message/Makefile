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

RDF_TOOLKIT_JAR := $(top_srcdir)/dependencies/CASE-0.3.0/CASE/lib/rdf-toolkit.jar

example_name := $(shell basename $$PWD)

all: \
  $(example_name)_validation.ttl

$(example_name)_validation.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(top_srcdir)/.venv.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --format turtle \
	    --output __$@ \
	    $< \
	    ; rc=$$? ; test 0 -eq $$rc -o 1 -eq $$rc
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

check: \
  $(example_name)_validation.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && pytest \
	    --verbose

clean:
	@rm -f \
	  $(example_name)_validation.ttl
