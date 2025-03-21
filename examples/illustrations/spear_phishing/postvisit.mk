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

top_srcdir := $(shell cd ../../.. ; pwd)

time_ttl := $(top_srcdir)/dependencies/UCO-Profile-Time/dependencies/CDO-Shapes-Time/dependencies/time.ttl
sh_time_ttl := $(top_srcdir)/dependencies/UCO-Profile-Time/dependencies/CDO-Shapes-Time/shapes/sh-time.ttl
profile_uco_time_ttl := $(top_srcdir)/dependencies/UCO-Profile-Time/ontology/uco-time.ttl
sh_uco_time_ttl := $(top_srcdir)/dependencies/UCO-Profile-Time/ontology/uco-time.ttl

all:

.uco-profiles.done.log: \
  $(profile_uco_time_ttl) \
  $(sh_time_ttl) \
  $(sh_uco_time_ttl) \
  $(time_ttl) \
  $(top_srcdir)/.venv.done.log \
  spear_phishing.json
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --ontology-graph $(profile_uco_time_ttl) \
	    --ontology-graph $(sh_time_ttl) \
	    --ontology-graph $(sh_uco_time_ttl) \
	    --ontology-graph $(time_ttl) \
	    --ontology-graph drafting.ttl \
	    spear_phishing.json
	touch $@

check: \
  .uco-profiles.done.log

clean:
	@rm -f \
	  .uco-profiles.done.log
