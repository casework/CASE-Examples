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
  all-dependencies \
  .venv-pre-commit/var/.pre-commit-built.log
	$(MAKE) \
	  --directory examples/illustrations

.PHONY: \
  all-dependencies \
  check-supply-chain \
  check-supply-chain-pre-commit \
  check-supply-chain-submodules \
  download

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
	$(MAKE) \
	  --directory dependencies/CASE-develop \
	  .git_submodule_init.done.log
	# CASE-develop-2.0.0
	test -r dependencies/CASE-develop-2.0.0/README.md \
	  || git submodule update --init dependencies/CASE-develop-2.0.0
	$(MAKE) \
	  --directory dependencies/CASE-develop-2.0.0 \
	  .git_submodule_init.done.log
	# CASE-unstable
	test -r dependencies/CASE-unstable/README.md \
	  || (git submodule init dependencies/CASE-unstable && git submodule update dependencies/CASE-unstable)
	test -r dependencies/CASE-unstable/README.md \
	  || (echo "ERROR:Makefile:CASE-unstable submodule README.md file not found, even though CASE-unstable submodule initialized." >&2 ; exit 2)
	$(MAKE) \
	  --directory dependencies/CASE-unstable \
	  .git_submodule_init.done.log
	# CASE-unstable-2.0.0
	test -r dependencies/CASE-unstable-2.0.0/README.md \
	  || git submodule update --init dependencies/CASE-unstable-2.0.0
	$(MAKE) \
	  --directory dependencies/CASE-unstable-2.0.0 \
	  .git_submodule_init.done.log
	# CDO-Shapes-Time
	test -r dependencies/CDO-Shapes-Time/README.md \
	  || git submodule update --init dependencies/CDO-Shapes-Time
	test -r dependencies/CDO-Shapes-Time/README.md \
	  || (echo "ERROR:Makefile:CDO-Shapes-Time submodule README.md file not found, even though CDO-Shapes-Time submodule initialized." >&2 ; exit 2)
	# Retrieve rdf-toolkit.jar.
	$(MAKE) \
	  --directory dependencies/CASE-develop \
	  .lib.done.log
	touch $@

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

all-dependencies: \
  .venv.done.log
	$(MAKE) \
	  --directory dependencies

check: \
  all-dependencies \
  .venv-pre-commit/var/.pre-commit-built.log
	$(MAKE) \
	  --directory examples/illustrations \
	  check

# This target's dependencies potentially modify the working directory's Git state, so it is intentionally not a dependency of check.
check-supply-chain: \
  check-supply-chain-pre-commit \
  check-supply-chain-submodules

# Update pre-commit configuration and use the updated config file to
# review code.  Only have Make exit if 'pre-commit run' modifies files.
check-supply-chain-pre-commit: \
  .venv-pre-commit/var/.pre-commit-built.log
	source .venv-pre-commit/bin/activate \
	  && pre-commit autoupdate
	git diff \
	  --exit-code \
	  .pre-commit-config.yaml \
	  || ( \
	      source .venv-pre-commit/bin/activate \
	        && pre-commit run \
	          --all-files \
	          --config .pre-commit-config.yaml \
	    ) \
	    || git diff \
	      --stat \
	      --exit-code \
	      || ( \
	          echo \
	            "WARNING:Makefile:pre-commit configuration can be updated.  It appears the updated would change file formatting." \
	            >&2 \
	            ; exit 1 \
                )
	@git diff \
	  --exit-code \
	  .pre-commit-config.yaml \
	  || echo \
	    "INFO:Makefile:pre-commit configuration can be updated.  It appears the update would not change file formatting." \
	    >&2

check-supply-chain-submodules: \
  .git_submodule_init.done.log
	git submodule update \
	  --remote
	git diff \
	  --exit-code \
	  --ignore-submodules=dirty \
	  dependencies

clean:
	@$(MAKE) \
	  --directory examples/illustrations \
	  clean
	@$(MAKE) \
	  --directory dependencies \
	  clean
	@rm -f \
	  .git_submodule_init.done.log \
	  .venv.done.log
	@rm -rf \
	  venv

download: \
  .venv-pre-commit/var/.pre-commit-built.log \
  .venv.done.log
