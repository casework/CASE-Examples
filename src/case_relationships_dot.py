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

__version__ = "0.1.0"

import argparse
from typing import Dict, List, Set, Tuple

import pydot
import rdflib
from case_prov.case_prov_dot import iri_to_gv_node_id, qname
from case_utils.namespace import NS_UCO_CORE
from rdflib import Literal, URIRef
from rdflib.query import ResultRow


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("out_dot")
    parser.add_argument("in_rdf", nargs="+")
    args = parser.parse_args()

    in_graph = rdflib.Graph()
    out_graph = pydot.Dot(
        "CASE render of directional relationships",
        graph_type="digraph",
        overlap="false",
    )

    for in_rdf in args.in_rdf:
        in_graph.parse(in_rdf)

    n_things_to_display: Set[URIRef] = set()
    query = """\
PREFIX uco-core: <https://ontology.unifiedcyberontology.org/uco/core/>
SELECT ?nSource ?nTarget
WHERE {
  ?nRelationship
    uco-core:kindOfRelationship ?lKind ;
    uco-core:source ?nSource ;
    uco-core:target ?nTarget ;
    .
}
"""
    for result in in_graph.query(query):
        assert isinstance(result, ResultRow)
        assert isinstance(result[0], URIRef)
        assert isinstance(result[1], URIRef)
        n_things_to_display.add(result[0])
        n_things_to_display.add(result[1])

    edges_to_display: Set[Tuple[URIRef, URIRef, str]] = set()
    query = """\
PREFIX uco-core: <https://ontology.unifiedcyberontology.org/uco/core/>
SELECT ?nSource ?nTarget ?lIsDirectional ?lKind
WHERE {
  ?nRelationship
    uco-core:isDirectional ?lIsDirectional ;
    uco-core:kindOfRelationship ?lKind ;
    uco-core:source ?nSource ;
    uco-core:target ?nTarget ;
    .
}
"""
    for result in in_graph.query(query):
        assert isinstance(result, ResultRow)
        assert isinstance(result[0], URIRef)
        assert isinstance(result[1], URIRef)
        assert isinstance(result[2], Literal)
        assert isinstance(result[3], Literal)
        edges_to_display.add(
            (result[0], result[1], result[2].toPython(), str(result[3]))
        )

    for n_thing in sorted(n_things_to_display):
        label_parts: List[str] = ["ID - " + qname(in_graph, n_thing)]
        for l_name in in_graph.objects(n_thing, NS_UCO_CORE.name):
            assert isinstance(l_name, Literal)
            label_parts.append(l_name)
        for l_description in in_graph.objects(n_thing, NS_UCO_CORE.description):
            assert isinstance(l_description, Literal)
            label_parts.append(l_description)
        dot_node = pydot.Node(
            iri_to_gv_node_id(n_thing),
            label="\n\n".join(label_parts),
            tooltip=str(n_thing),
        )
        out_graph.add_node(dot_node)

    # Represent the Relationship object as a "hinge" node to keep the
    # edge label from overlapping with nodes.
    for edge_to_display in sorted(edges_to_display):
        dot_edge_hinge = pydot.Node(
            iri_to_gv_node_id(
                str(edge_to_display[0]) + str(edge_to_display[1]) + edge_to_display[3]
            ),
            label=edge_to_display[3],
            shape="none",
            tooltip="",
        )

        # Work around 'dir' for arrowhead directionality being a reserved word in Python.
        # https://www.graphviz.org/docs/attrs/dir/
        edge_attributes: Dict[str, str] = {
            "dir": "forward" if edge_to_display[2] else "none"
        }
        dot_edge_0 = pydot.Edge(
            iri_to_gv_node_id(edge_to_display[0]),
            dot_edge_hinge,
            **edge_attributes,
        )
        dot_edge_1 = pydot.Edge(
            dot_edge_hinge,
            iri_to_gv_node_id(edge_to_display[1]),
            **edge_attributes,
        )
        out_graph.add_node(dot_edge_hinge)
        out_graph.add_edge(dot_edge_0)
        out_graph.add_edge(dot_edge_1)

    out_graph.write_raw(args.out_dot)


if __name__ == "__main__":
    main()
