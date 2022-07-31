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

top_srcdir := $(shell cd .. ; pwd)

RDF_TOOLKIT_JAR := $(top_srcdir)/dependencies/UCO-develop/lib/rdf-toolkit.jar

all:

check: \
  .check-drafting.ttl
	diff \
	  drafting.ttl \
	  .check-drafting.ttl \
	  || (echo "ERROR:ontology/Makefile:drafting.ttl does not match the Turtle normalization process output. If the above reported changes look fine, run 'cp .check-drafting.ttl drafting.ttl' while in the sub-folder ontology/ to get a file ready to commit to Git." >&2 ; exit 1)

.check-drafting.ttl: \
  drafting.ttl \
  $(RDF_TOOLKIT_JAR)
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source $< \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	mv _$@ $@
