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

all:
	$(MAKE) \
	  --directory src \
	  normalize
	$(MAKE) \
	  --directory src
	cp src/generated-README.md README.md
	cp src/generated-inference.json inference.json

check:
	$(MAKE) \
	  --directory src \
	  generated-README.md \
	  generated-inference.json
	$(MAKE) \
	  --directory src \
	  check
	diff \
	  src/generated-inference.json \
	  inference.json \
	  || (echo "UPDATE:examples/illustrations/inference/Makefile:The generated inference.json does not match the Git-tracked inference.json.  If the above reported changes look fine, run 'cp src/generated-inference.json inference.json' to get a file ready to commit to Git." >&2 ; exit 1)
	diff \
	  src/generated-README.md \
	  README.md \
	  || (echo "UPDATE:examples/illustrations/inference/Makefile:The generated README.md does not match the Git-tracked README.md.  If the above reported changes look fine, run 'cp src/generated-README.md README.md' to get a file ready to commit to Git." >&2 ; exit 1)

clean:
	@$(MAKE) \
	  --directory src \
	  clean
