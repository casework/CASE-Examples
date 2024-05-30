#!/usr/bin/env python3

# Portions of this file contributed by NIST are governed by the
# following statement:
#
# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to Title 17 Section 105 of the
# United States Code, this software is not subject to copyright
# protection within the United States. NIST assumes no responsibility
# whatsoever for its use by other parties, and makes no guarantees,
# expressed or implied, about its quality, reliability, or any other
# characteristic.
#
# We would appreciate acknowledgement if the software is used.

import logging
from collections import defaultdict
from pathlib import Path
from pprint import pformat
from typing import DefaultDict, Dict, Set
from uuid import UUID

from rdflib import Graph, URIRef

srcdir = Path(__file__).parent


def test_uuid_unique_usage_case_examples_illustrations() -> None:
    """
    This test confirms that if two node IRIs end with the same UUID, then the IRI matches.
    This test is likely to be copied and adjusted between several example repositories.
    """
    uuid_to_urirefs: DefaultDict[UUID, Set[URIRef]] = defaultdict(set)
    graph = Graph()
    graph.parse(srcdir / "kb.ttl")

    def _ingest(n_thing: URIRef) -> None:
        thing_iri = str(n_thing)
        if len(thing_iri) < 40:
            # Not long enough to contain scheme, colon, and UUID.
            return
        try:
            thing_uuid = UUID(thing_iri[-36:])
        except ValueError:
            return
        uuid_to_urirefs[thing_uuid].add(n_thing)

    for triple in graph.triples((None, None, None)):
        if isinstance(triple[0], URIRef):
            _ingest(triple[0])
        if isinstance(triple[2], URIRef):
            _ingest(triple[2])

    computed: Dict[str, Set[str]] = dict()
    for _uuid in uuid_to_urirefs:
        if len(uuid_to_urirefs[_uuid]) > 1:
            computed[str(_uuid)] = {str(x) for x in uuid_to_urirefs[_uuid]}

    try:
        assert len(computed) == 0
    except AssertionError:
        logging.debug(pformat(computed))
        raise
