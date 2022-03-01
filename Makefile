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
	$(MAKE) \
	  --directory examples/illustrations

# Submodules are checked for having been cloned ever.  A global git
# submodule udpate command is not run, to prevent resetting any pointers
# for someone developing with different submodule pointers.
.git_submodule_init.done.log: \
  .gitmodules
	# CASE-Utilities-Python
	test -r dependencies/CASE-Utilities-Python/README.md \
	  || (git submodule init dependencies/CASE-Utilities-Python && git submodule update dependencies/CASE-Utilities-Python)
	test -r dependencies/CASE-Utilities-Python/README.md \
	  || (echo "ERROR:Makefile:CASE-Utilities-Python submodule README.md file not found, even though CASE-Utilities-Python submodule initialized." >&2 ; exit 2)
	# UCO-unstable
	test -r dependencies/UCO-unstable/README.md \
	  || (git submodule init dependencies/UCO-unstable && git submodule update dependencies/UCO-unstable)
	test -r dependencies/UCO-unstable/README.md \
	  || (echo "ERROR:Makefile:UCO-unstable submodule README.md file not found, even though UCO-unstable submodule initialized." >&2 ; exit 2)
	# Retrieve rdf-toolkit.jar.
	cd dependencies/CASE-Utilities-Python \
	  && git submodule update --init dependencies/CASE
	$(MAKE) \
	  --directory dependencies/CASE-Utilities-Python/dependencies/CASE \
	  .lib.done.log
	touch $@

.venv.done.log: \
  .git_submodule_init.done.log \
  requirements.txt
	rm -rf venv
	$(PYTHON3) -m venv \
	  venv
	source venv/bin/activate \
	  && pip install \
	    --upgrade \
	    pip \
	    setuptools \
	    wheel
	source venv/bin/activate \
	  && pip install \
	      dependencies/CASE-Utilities-Python
	source venv/bin/activate \
	  && pip install \
	      --requirement requirements.txt
	touch $@

check: \
  .venv.done.log
	$(MAKE) \
	  --directory examples/illustrations \
	  check

clean:
	@$(MAKE) \
	  --directory examples/illustrations \
	  clean
	@rm -f \
	  .git_submodule_init.done.log \
	  .venv.done.log
	@rm -rf \
	  venv
