#!/usr/bin/env python3

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

import logging
import os
import pathlib

import rdflib.plugins.sparql

def test_messages_have_sent_times() -> None:
    expected = set()
    computed = set()

    graph = rdflib.Graph()
    srcdir_path = pathlib.Path(__file__).parent
    message_json_path = srcdir_path / "message.json"
    assert message_json_path.exists(), "message.json not found in same directory as test."

    # TODO - Remove 'format' parameter when an rdflib release with this PR is issued:
    # https://github.com/RDFLib/rdflib/pull/1403
    graph.parse(str(message_json_path), format="json-ld")

    nsdict = {k:v for (k,v) in graph.namespace_manager.namespaces()}

    query_str = """\
SELECT ?nMessage
WHERE {
  ?nMessage uco-core:hasFacet ?nMessageFacet .
  ?nMessageFacet a uco-observable:MessageFacet .
  FILTER NOT EXISTS {
    ?nMessageFacet uco-observable:sentTime ?lSentTime .
  } 
}
"""
    query_object = rdflib.plugins.sparql.prepareQuery(query_str, initNs=nsdict)
    for result in graph.query(query_object):
        n_message = result[0]
        computed.add(n_message.toPython())

    assert expected == computed, "Message objects with IRIs in the 'computed' set do not have sent-times.  Please ensure this example has sent-times."
