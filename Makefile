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
  .dependencies.done.log
	$(MAKE) \
	  --directory examples/illustrations

.dependencies.done.log: \
  .venv.done.log
	$(MAKE) \
	  --directory dependencies
	touch $@

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
	# UCO (CASE 0.3.0)
	test -r dependencies/CASE-0.3.0/UCO/README.md \
	  || (git submodule init dependencies/CASE-0.3.0/UCO && git submodule update dependencies/CASE-0.3.0/UCO)
	@test -r dependencies/CASE-0.3.0/UCO/README.md \
	  || (echo "ERROR:Makefile:CASE-0.3.0 UCO submodule README.md file not found, even though UCO submodule initialized." >&2 ; exit 2)
	# CASE (CASE 0.3.0)
	test -r dependencies/CASE-0.3.0/CASE/README.md \
	  || (git submodule init dependencies/CASE-0.3.0/CASE && git submodule update dependencies/CASE-0.3.0/CASE)
	@test -r dependencies/CASE-0.3.0/CASE/README.md \
	  || (echo "ERROR:Makefile:CASE-0.3.0 CASE submodule README.md file not found, even though CASE submodule initialized." >&2 ; exit 2)
	# UCO (CASE 0.4.0)
	test -r dependencies/CASE-0.4.0/UCO/README.md \
	  || (git submodule init dependencies/CASE-0.4.0/UCO && git submodule update dependencies/CASE-0.4.0/UCO)
	@test -r dependencies/CASE-0.4.0/UCO/README.md \
	  || (echo "ERROR:Makefile:CASE-0.4.0 UCO submodule README.md file not found, even though UCO submodule initialized." >&2 ; exit 2)
	# CASE (CASE 0.4.0)
	test -r dependencies/CASE-0.4.0/CASE/README.md \
	  || (git submodule init dependencies/CASE-0.4.0/CASE && git submodule update dependencies/CASE-0.4.0/CASE)
	@test -r dependencies/CASE-0.4.0/CASE/README.md \
	  || (echo "ERROR:Makefile:CASE-0.4.0 CASE submodule README.md file not found, even though CASE submodule initialized." >&2 ; exit 2)
	touch $@

.venv.done.log: \
  .git_submodule_init.done.log
	rm -rf venv
	$(PYTHON3) -m venv \
	  venv
	source venv/bin/activate \
	  && pip install \
	    --upgrade \
	    pip \
	    setuptools
	source venv/bin/activate \
	  && pip install \
	      dependencies/CASE-Utilities-Python
	touch $@

check: \
  .dependencies.done.log
	$(MAKE) \
	  --directory dependencies \
	  check
	$(MAKE) \
	  --directory examples/illustrations \
	  check

clean:
	@$(MAKE) \
	  --directory examples/illustrations \
	  clean
	@rm -f \
	  .dependencies.done.log \
	  .git_submodule_init.done.log \
	  .venv.done.log
	@rm -rf \
	  venv
