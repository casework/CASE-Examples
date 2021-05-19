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

top_srcdir := $(shell cd ../.. ; pwd)

ttl_basenames := $(wildcard *.ttl)

check_targets := $(foreach ttl_basename,$(ttl_basenames),check-$(ttl_basename))

all:

# The overall 'check' target handles one hard-coded test to handle the
# wildcard function not working.
check: \
  $(check_targets)
	test -r case.ttl  # Confirm case.ttl is readable.
	test -L case.ttl  # Confirm case.ttl is a soft-link.
	echo $(check_targets)

# This performs a soft-link-liveness check.  If Make does not think the
# recipe dependency exists, the soft-link is broken.
# If the file exists but is not a soft link, there may have been
# confusion, seen at times in Windows environments that perform a
# git-clone without soft-links enabled.
# This recipe intentionally creates no target file.
check-%: \
  %
	test -L $<  # Confirm dependency is a soft-link.
