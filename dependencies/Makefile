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

all: \
  case-0.3.0.pkl

case-0.3.0.pkl: \
  $(top_srcdir)/.venv.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && serialize \
	    -c case-0.3.0 \
	    -o _$@ \
	    CASE-0.3.0/
	mv _$@ $@

check: \
  case-0.3.0.pkl
	$(MAKE) \
	  --directory CASE-0.3.0 \
	  check
	source $(top_srcdir)/venv/bin/activate \
	  && describe \
	    case-0.3.0.pkl
