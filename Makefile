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

PYTHON3 ?= $(shell which python3.9 2>/dev/null || which python3.8 2>/dev/null || which python3.7 2>/dev/null || which python3.6 2>/dev/null || which python3)

all: \
  .venv.done.log

# Submodules are checked for having been cloned ever.  A global git
# submodule udpate command is not run, to prevent resetting any pointers
# for someone developing with different submodule pointers.
.git_submodule_init.done.log: \
  .gitmodules
	# UCO-Utility-Pre-0.7.0-Validator
	test -r dependencies/UCO-Utility-Pre-0.7.0-Validator/README.md \
	  || (git submodule init dependencies/UCO-Utility-Pre-0.7.0-Validator && git submodule update dependencies/UCO-Utility-Pre-0.7.0-Validator)
	@test -r dependencies/UCO-Utility-Pre-0.7.0-Validator/README.md \
	  || (echo "ERROR:Makefile:UCO-Utility-Pre-0.7.0-Validator submodule README.md file not found, even though UCO-Utility-Pre-0.7.0-Validator submodule initialized." >&2 ; exit 2)
	# UCO
	test -r dependencies/UCO/README.md \
	  || (git submodule init dependencies/UCO && git submodule update dependencies/UCO)
	@test -r dependencies/UCO/README.md \
	  || (echo "ERROR:Makefile:UCO submodule README.md file not found, even though UCO submodule initialized." >&2 ; exit 2)
	# CASE
	test -r dependencies/CASE/README.md \
	  || (git submodule init dependencies/CASE && git submodule update dependencies/CASE)
	@test -r dependencies/CASE/README.md \
	  || (echo "ERROR:Makefile:CASE submodule README.md file not found, even though CASE submodule initialized." >&2 ; exit 2)
	touch $@

.venv.done.log: \
  .git_submodule_init.done.log
	rm -rf venv
	$(PYTHON3) -m virtualenv \
	  --python=$(PYTHON3) \
	  venv
	source venv/bin/activate \
	  && pip install \
	    --upgrade \
	    pip \
	    setuptools
	source venv/bin/activate \
	  && cd dependencies/UCO-Utility-Pre-0.7.0-Validator \
	    && pip install \
	      --editable \
	      src
	touch $@

clean:
	@rm -f \
	  .git_submodule_init.done.log \
	  .venv.done.log
	@rm -rf \
	  venv
