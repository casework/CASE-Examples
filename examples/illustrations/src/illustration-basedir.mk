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

illustration_name := $(shell basename $$PWD)

RENDER_PROV ?=

# `diff` is used to determine if a copy operation should happen.
# If it happens each time, validation files will be regenerated on every
# `make` call.
all:
	$(MAKE) \
	  --directory src
	cp src/generated-README.md README.md
	diff \
	  $(illustration_name).json \
	  src/generated-$(illustration_name).json \
	  || cp \
	    src/generated-$(illustration_name).json \
	    $(illustration_name).json
	$(MAKE) \
	  RENDER_PROV="$(RENDER_PROV)" \
	  --file ../src/illustration-nosrc.mk

check:
	$(MAKE) \
	  --directory src \
	  generated-README.md \
	  generated-$(illustration_name).json
	$(MAKE) \
	  --directory src \
	  check
	$(MAKE) \
	  RENDER_PROV="$(RENDER_PROV)" \
	  --file ../src/illustration-nosrc.mk \
	  check
	diff \
	  src/generated-$(illustration_name).json \
	  $(illustration_name).json \
	  || (echo "UPDATE:examples/illustrations/$(illustration_name)/Makefile:The generated $(illustration_name).json does not match the Git-tracked $(illustration_name).json.  If the above reported changes look fine, run 'cp src/generated-$(illustration_name).json $(illustration_name).json' to get a file ready to commit to Git." >&2 ; exit 1)
	diff \
	  src/generated-README.md \
	  README.md \
	  || (echo "UPDATE:examples/illustrations/$(illustration_name)/Makefile:The generated README.md does not match the Git-tracked README.md.  If the above reported changes look fine, run 'cp src/generated-README.md README.md' to get a file ready to commit to Git." >&2 ; exit 1)

clean:
	@$(MAKE) \
	  --file ../src/illustration-nosrc.mk \
	  clean
	@$(MAKE) \
	  --directory src \
	  clean
