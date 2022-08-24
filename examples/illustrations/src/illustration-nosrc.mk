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

# This Makefile contains generic steps each illustration will follow for
# content review.  For examples that do not compile their JSON-LD graph
# or README documentation, this can be included with a Make `include`
# directive, or by using a Makefile that passes through the typical
# automatic targets (`all`, `check`, `clean`) as well as building other
# resources.

SHELL := /bin/bash

# The expected execution context is in any sibling directory of this Makefile's directory.
top_srcdir := $(shell cd ../../.. ; pwd)

RDF_TOOLKIT_JAR := $(top_srcdir)/dependencies/UCO-develop/lib/rdf-toolkit.jar

example_name := $(shell basename $$PWD)

# Use a drafting.ttl file in the validation and dependency list, if it is present.
drafting_ttl := $(wildcard drafting.ttl)
ifeq ($(drafting_ttl),)
drafting_validation_flag :=
else
drafting_validation_flag := --ontology-graph $(wildcard drafting.ttl)
endif

all: \
  $(example_name)_validation.ttl \
  $(example_name)_validation-develop.ttl \
  $(example_name)_validation-unstable.ttl

$(RDF_TOOLKIT_JAR):
	@echo "ERROR:illustration-nosrc.mk:Could not find rdf-toolkit.jar.  Did you run 'make' or 'make download' from the top source directory ($(top_srcdir))?" >&2
	@test -r $@

$(example_name)_validation.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --output __$@ \
	    $< \
	    $(drafting_ttl) \
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

$(example_name)_validation-develop.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-develop.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-develop.ttl \
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

$(example_name)_validation-unstable.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-unstable.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-unstable.ttl \
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
  $(example_name)_validation.ttl \
  $(example_name)_validation-develop.ttl \
  $(example_name)_validation-unstable.ttl

clean:
	@rm -f \
	  $(example_name)_validation*.ttl
