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
  .dependencies.done.log \
  .venv-pre-commit/var/.pre-commit-built.log
	$(MAKE) \
	  --directory examples/illustrations

.PHONY: \
  check-examples \
  check-tests

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
	# CASE-develop
	test -r dependencies/CASE-develop/README.md \
	  || (git submodule init dependencies/CASE-develop && git submodule update dependencies/CASE-develop)
	test -r dependencies/CASE-develop/README.md \
	  || (echo "ERROR:Makefile:CASE-develop submodule README.md file not found, even though CASE-develop submodule initialized." >&2 ; exit 2)
	# CASE-unstable
	test -r dependencies/CASE-unstable/README.md \
	  || (git submodule init dependencies/CASE-unstable && git submodule update dependencies/CASE-unstable)
	test -r dependencies/CASE-unstable/README.md \
	  || (echo "ERROR:Makefile:CASE-unstable submodule README.md file not found, even though CASE-unstable submodule initialized." >&2 ; exit 2)
	# UCO-develop
	test -r dependencies/UCO-develop/README.md \
	  || (git submodule init dependencies/UCO-develop && git submodule update dependencies/UCO-develop)
	test -r dependencies/UCO-develop/README.md \
	  || (echo "ERROR:Makefile:UCO-develop submodule README.md file not found, even though UCO-develop submodule initialized." >&2 ; exit 2)
	# UCO-unstable
	test -r dependencies/UCO-unstable/README.md \
	  || (git submodule init dependencies/UCO-unstable && git submodule update dependencies/UCO-unstable)
	test -r dependencies/UCO-unstable/README.md \
	  || (echo "ERROR:Makefile:UCO-unstable submodule README.md file not found, even though UCO-unstable submodule initialized." >&2 ; exit 2)
	# Retrieve rdf-toolkit.jar.
	$(MAKE) \
	  --directory dependencies/UCO-develop \
	  .lib.done.log
	touch $@

.lib.done.log:
	$(MAKE) \
	  --directory lib

# This virtual environment is meant to be built once and then persist, even through 'make clean'.
# If a recipe is written to remove this flag file, it should first run `pre-commit uninstall`.
.venv-pre-commit/var/.pre-commit-built.log:
	rm -rf .venv-pre-commit
	test -r .pre-commit-config.yaml \
	  || (echo "ERROR:Makefile:pre-commit is expected to install for this repository, but .pre-commit-config.yaml does not expect to exist." >&2 ; exit 1)
	$(PYTHON3) -m venv \
	  .venv-pre-commit
	source .venv-pre-commit/bin/activate \
	  && pip install \
	    --upgrade \
	    pip \
	    setuptools \
	    wheel
	source .venv-pre-commit/bin/activate \
	  && pip install \
	    pre-commit
	source .venv-pre-commit/bin/activate \
	  && pre-commit install
	mkdir -p \
	  .venv-pre-commit/var
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
	    --requirement requirements.txt
	touch $@

check: \
  check-examples \
  check-tests

check-examples: \
  .dependencies.done.log \
  .venv-pre-commit/var/.pre-commit-built.log
	$(MAKE) \
	  --directory examples/illustrations \
	  check

check-tests: \
  .venv.done.log
	$(MAKE) \
	  --directory tests/owl_inferencing \
	  check

clean:
	@$(MAKE) \
	  --directory examples/illustrations \
	  clean
	@rm -f \
	  .dependencies.done.log
	@$(MAKE) \
	  --directory dependencies \
	  clean
	@rm -f \
	  .git_submodule_init.done.log \
	  .venv.done.log
	@rm -rf \
	  venv
