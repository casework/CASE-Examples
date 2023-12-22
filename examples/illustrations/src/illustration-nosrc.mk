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

# This Makefile contains generic steps each illustration will follow for
# content review.  For examples that do not compile their JSON-LD graph
# or README documentation, this can be included with a Make `include`
# directive, or by using a Makefile that passes through the typical
# automatic targets (`all`, `check`, `clean`) as well as building other
# resources.

SHELL := /bin/bash

# The expected execution context is in any sibling directory of this Makefile's directory.
top_srcdir := $(shell cd ../../.. ; pwd)

RDF_TOOLKIT_JAR := $(top_srcdir)/dependencies/CASE-develop/dependencies/UCO/lib/rdf-toolkit.jar

example_name := $(shell basename $$PWD)

# Use a drafting.ttl file in the validation and dependency list, if it is present.
drafting_ttl := $(wildcard drafting.ttl)
ifeq ($(drafting_ttl),)
drafting_dependency :=
drafting_dependency_develop :=
drafting_dependency_develop_2_0_0 :=
drafting_dependency_unstable :=
drafting_dependency_unstable_2_0_0 :=
drafting_validation_flag :=
else
drafting_dependency := .drafting.ttl.validates.log
drafting_dependency_develop := .drafting.ttl.validates-develop.log
drafting_dependency_develop_2_0_0 := .drafting.ttl.validates-develop-2.0.0.log
drafting_dependency_unstable := .drafting.ttl.validates-unstable.log
drafting_dependency_unstable_2_0_0 := .drafting.ttl.validates-unstable-2.0.0.log
drafting_validation_flag := --ontology-graph $(drafting_ttl)
endif

RENDER_PROV ?=
ifeq ($(RENDER_PROV),yes)
prov_svgs := \
  figures/$(example_name)-prov-all.svg \
  figures/$(example_name)-prov-activities-agents.svg \
  figures/$(example_name)-prov-activities-entities.svg \
  figures/$(example_name)-prov-activities.svg \
  figures/$(example_name)-prov-agents-entities.svg \
  figures/$(example_name)-prov-agents.svg \
  figures/$(example_name)-prov-entities.svg \
  figures/$(example_name)-prov-time-all.svg \
  figures/$(example_name)-prov-time-activities-agents.svg \
  figures/$(example_name)-prov-time-activities-entities.svg \
  figures/$(example_name)-prov-time-agents-entities.svg \
  figures/$(example_name)-prov-time-activities.svg \
  figures/$(example_name)-prov-time-agents.svg \
  figures/$(example_name)-prov-time-entities.svg
else
prov_svgs :=
endif

RENDER_RELATIONSHIPS ?=
ifeq ($(RENDER_RELATIONSHIPS),yes)
relationship_svgs := \
  figures/$(example_name)-relationships.svg
else
relationship_svgs :=
endif

all: \
  $(example_name)_validation.ttl \
  $(prov_svgs) \
  $(relationship_svgs) \
  $(example_name)_validation-develop.ttl \
  $(example_name)_validation-develop-2.0.0.ttl \
  $(example_name)_validation-unstable.ttl \
  $(example_name)_validation-unstable-2.0.0.ttl

.PHONY: \
  check-pytest

$(RDF_TOOLKIT_JAR):
	@echo "ERROR:illustration-nosrc.mk:Could not find rdf-toolkit.jar.  Did you run 'make' or 'make download' from the top source directory ($(top_srcdir))?" >&2
	@test -r $@

%.svg: \
  %.dot
	dot \
	  -T svg \
	  -o $@_ \
	  $<
	mv $@_ $@

$(example_name)-prov.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log
	rm -f __$@
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_rdf \
	      --allow-empty-results \
	      --use-deterministic-uuids \
	      __$@ \
	      $(drafting_ttl) \
	      $<
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

$(example_name)_validation.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_dependency) \
  $(top_srcdir)/.venv.done.log
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --output __$@ \
	    $(drafting_ttl) \
	    $<
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

$(example_name)_validation-develop.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_dependency_develop) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-develop.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-develop.ttl \
	    --output __$@ \
	    $< \
	    ; rc=$$? ; test 0 -eq $$rc -o 1 -eq $$rc
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

$(example_name)_validation-develop-2.0.0.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_dependency_develop_2_0_0) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-develop-2.0.0.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-develop-2.0.0.ttl \
	    --output __$@ \
	    $< \
	    ; rc=$$? ; test 0 -eq $$rc -o 1 -eq $$rc
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

$(example_name)_validation-unstable.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_dependency_unstable) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-unstable.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-unstable.ttl \
	    --output __$@ \
	    $< \
	    ; rc=$$? ; test 0 -eq $$rc -o 1 -eq $$rc
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

$(example_name)_validation-unstable-2.0.0.ttl: \
  $(example_name).json \
  $(RDF_TOOLKIT_JAR) \
  $(drafting_dependency_unstable_2_0_0) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-unstable-2.0.0.ttl
	rm -f __$@
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --format turtle \
	    $(drafting_validation_flag) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-unstable-2.0.0.ttl \
	    --output __$@ \
	    $< \
	    ; rc=$$? ; test 0 -eq $$rc -o 1 -eq $$rc
	test -s __$@
	java -jar $(RDF_TOOLKIT_JAR) \
	  --inline-blank-nodes \
	  --source __$@ \
	  --source-format turtle \
	  --target _$@ \
	  --target-format turtle
	rm __$@
	mv _$@ $@

.drafting.ttl.validates.log: \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --metashacl \
	    --ontology-graph $(drafting_ttl) \
	    --review-tbox \
	    $(drafting_ttl)
	touch $@

.drafting.ttl.validates-develop.log: \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-develop.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --metashacl \
	    --ontology-graph $(drafting_ttl) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-develop.ttl \
	    --review-tbox \
	    $(drafting_ttl)
	touch $@

.drafting.ttl.validates-develop-2.0.0.log: \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-develop-2.0.0.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --metashacl \
	    --ontology-graph $(drafting_ttl) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-develop-2.0.0.ttl \
	    --review-tbox \
	    $(drafting_ttl)
	touch $@

.drafting.ttl.validates-unstable.log: \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-unstable.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --metashacl \
	    --ontology-graph $(drafting_ttl) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-unstable.ttl \
	    --review-tbox \
	    $(drafting_ttl)
	touch $@

.drafting.ttl.validates-unstable-2.0.0.log: \
  $(drafting_ttl) \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/dependencies/CASE-unstable-2.0.0.ttl
	source $(top_srcdir)/venv/bin/activate \
	  && case_validate \
	    --allow-infos \
	    --built-version none \
	    --metashacl \
	    --ontology-graph $(drafting_ttl) \
	    --ontology-graph $(top_srcdir)/dependencies/CASE-unstable-2.0.0.ttl \
	    --review-tbox \
	    $(drafting_ttl)
	touch $@

check: \
  check-pytest \
  $(example_name)_validation.ttl \
  $(example_name)_validation-develop.ttl \
  $(example_name)_validation-develop-2.0.0.ttl \
  $(example_name)_validation-unstable.ttl \
  $(example_name)_validation-unstable-2.0.0.ttl

# Run pytest tests only if any are written.
# (Pytest exits in an error state if called with no tests found.)
check-pytest: \
  $(top_srcdir)/.venv.done.log
	test 0 -eq $$(/bin/ls *_test.py test_*.py 2>/dev/null | wc -l) \
	  || ( \
	    source $(top_srcdir)/venv/bin/activate \
	      && pytest \
	      --log-level=DEBUG \
	  )

clean:
	@rm -f \
	  .drafting.ttl.*.log \
	  figures/*.dot \
	  figures/*.svg \
	  $(example_name)_validation*.ttl

figures/$(example_name)-prov-activities-agents.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --agent-delegating \
	      --dash-unqualified \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-activities-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --dash-unqualified \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-activities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --dash-unqualified \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-agents-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --agent-delegating \
	      --dash-unqualified \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-agents.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --agent-delegating \
	      --dash-unqualified \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-all.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --dash-unqualified \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --dash-unqualified \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-activities-agents.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --agent-delegating \
	      --dash-unqualified \
	      --display-time-links \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-activities-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --dash-unqualified \
	      --display-time-links \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-activities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --activity-informing \
	      --dash-unqualified \
	      --display-time-links \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-agents.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --agent-delegating \
	      --dash-unqualified \
	      --display-time-links \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-agents-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --agent-delegating \
	      --dash-unqualified \
	      --display-time-links \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-all.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --dash-unqualified \
	      --display-time-links \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-prov-time-entities.dot: \
  $(example_name)-prov.ttl
	mkdir -p figures
	export CASE_DEMO_NONRANDOM_UUID_BASE="$(top_srcdir)" \
	  && source $(top_srcdir)/venv/bin/activate \
	    && case_prov_dot \
	      --dash-unqualified \
	      --display-time-links \
	      --entity-deriving \
	      --use-deterministic-uuids \
	      $@_ \
	      $(drafting_ttl) \
	      $(example_name)-prov.ttl \
	      $(example_name).json
	mv $@_ $@

figures/$(example_name)-relationships.dot: \
  $(example_name).json \
  $(top_srcdir)/.venv.done.log \
  $(top_srcdir)/src/case_relationships_dot.py
	mkdir -p figures
	source $(top_srcdir)/venv/bin/activate \
	  && python3 $(top_srcdir)/src/case_relationships_dot.py \
	    $@_ \
	    $<
	mv $@_ $@

figures/$(example_name)-relationships.svg: \
  figures/$(example_name)-relationships.dot
	neato \
	  -T svg \
	  -o $@_ \
	  $<
	mv $@_ $@
