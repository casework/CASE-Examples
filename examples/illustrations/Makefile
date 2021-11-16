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

.PHONY: \
  all-exif_data \
  all-location \
  all-message \
  check-exif_data \
  check-location \
  check-message

all: \
  all-exif_data \
  all-location \
  all-message

all-exif_data:
	$(MAKE) \
	  --directory exif_data

all-location:
	$(MAKE) \
	  --directory location

all-message:
	$(MAKE) \
	  --directory message

check: \
  check-exif_data \
  check-location \
  check-message

check-exif_data:
	$(MAKE) \
	  --directory exif_data \
	  check

check-location:
	$(MAKE) \
	  --directory location \
	  check

check-message:
	$(MAKE) \
	  --directory message \
	  check

clean:
	@$(MAKE) \
	  --directory exif_data \
	  clean
	@$(MAKE) \
	  --directory location \
	  clean
	@$(MAKE) \
	  --directory message \
	  clean
