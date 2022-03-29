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

all: \
  HermiT.jar

HermiT.jar: \
  HermiT.zip
	unzip $< $@
	touch -c $@

HermiT.zip:
	test -r HermiT.zip.sha512
	wget \
	  --output-document $@_ \
	  https://www.cs.ox.ac.uk/isg/tools/HermiT/download/1.3.8/HermiT.zip
	test \
	  "x$$(openssl dgst -sha512 $@_ | awk '{print($$NF)}')" \
	  == \
	  "x$$(head -n1 HermiT.zip.sha512)"
	mv $@_ $@
