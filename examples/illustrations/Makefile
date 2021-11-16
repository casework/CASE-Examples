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

illustration_dirs := \
  exif_data \
  location \
  message

all_targets := $(foreach illustration_dir,$(illustration_dirs),all-$(illustration_dir))

check_targets := $(foreach illustration_dir,$(illustration_dirs),check-$(illustration_dir))

clean_targets := $(foreach illustration_dir,$(illustration_dirs),clean-$(illustration_dir))

all: \
  $(all_targets)

.PHONY: \
  all-% \
  check-% \
  clean-%

all-%:
	export x=$@ \
	  && $(MAKE) \
	    --directory $${x/all-}

check: \
  $(check_targets)

check-%:
	export x=$@ \
	  && $(MAKE) \
	    --directory $${x/check-} \
	    check

clean: \
  $(clean_targets)

clean-%:
	@export x=$@ \
	  && $(MAKE) \
	    --directory $${x/clean-} \
	    clean
