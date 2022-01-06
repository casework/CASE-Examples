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
import pathlib
import pprint
import typing

import owlrl  # type: ignore
import rdflib


_ground_truth_eval_birds = typing.Set[str]
_ground_truth_eval_feathers = typing.Set[typing.Tuple[str, bool]]


def _test_inference(
    use_inference: bool, assert_reified_axioms: bool
) -> typing.Tuple[_ground_truth_eval_birds, _ground_truth_eval_feathers]:
    """
    Test the set of returned owl:Individuals from an example ontology and knowledge base.

    :param use_inference: Use OWL-RL inferencing.
    :param assert_reified_axioms: For each owl:Axiom object in the input graph, assert the axiom (i.e., create a triple and add it to the graph).
    """
    graph = rdflib.Graph()
    graph.parse(str(pathlib.Path(__file__).parent / "animals.ttl"))

    computed_birds: _ground_truth_eval_birds = set()
    expected_birds: _ground_truth_eval_birds = set()

    computed_feathers: _ground_truth_eval_feathers = set()
    expected_feathers: _ground_truth_eval_feathers = set()

    # Define ground truth sets according to call parameters.

    # In all cases, we will have at least these as ground truth:
    expected_birds |= {"http://example.org/kb/animal-b"}
    expected_feathers |= {
        ("http://example.org/kb/animal-a", True),
        ("http://example.org/kb/animal-c", False),
        ("http://example.org/kb/animal-d", False),
    }
    if use_inference:
        expected_birds |= {"http://example.org/kb/animal-a"}
        expected_feathers |= {("http://example.org/kb/animal-b", True)}
    if assert_reified_axioms:
        expected_feathers |= {("http://example.org/kb/animal-eax", True)}
    if use_inference and assert_reified_axioms:
        expected_birds |= {"http://example.org/kb/animal-eax"}

    logging.debug("len(graph) = %d.  (initial state)", len(graph))

    if assert_reified_axioms:
        update_graph = rdflib.Graph()
        for triple in graph.query(
            """\
CONSTRUCT {
  ?s ?p ?o .
}
WHERE {
  ?nAxiom
    a owl:Axiom ;
    owl:annotatedProperty ?p ;
    owl:annotatedSource ?s ;
    owl:annotatedTarget ?o ;
    .
}"""
        ):
            update_graph.add(triple)
        graph += update_graph
        logging.debug("len(graph) = %d.  (asserted reified axioms)", len(graph))

    if use_inference:
        closure = owlrl.OWLRL.OWLRL_Semantics(graph, False, False)
        logging.debug("len(graph) = %d.  (defined closure object)", len(graph))
        closure.closure()
        logging.debug("len(graph) = %d.  (built closure)", len(graph))
        del closure

    for bird_result in graph.query(
        """\
SELECT ?nAnimal ?nClass
WHERE {
  ?nAnimal a ex:Bird .
}"""
    ):
        computed_birds.add(bird_result[0].toPython())

    for feather_result in graph.query(
        """\
SELECT ?nAnimal ?lHasFeathers
WHERE {
  ?nAnimal ex:hasFeathers ?lHasFeathers .
}"""
    ):
        computed_feathers.add(
            (feather_result[0].toPython(), feather_result[1].toPython())
        )

    assert expected_birds == computed_birds
    assert expected_feathers == computed_feathers

    return (expected_birds, expected_feathers)


def test_no_inference_no_assertion() -> None:
    logging.debug("Ground truth:\n" + pprint.pformat(_test_inference(False, False)))


def test_no_inference_yes_assertion() -> None:
    logging.debug("Ground truth:\n" + pprint.pformat(_test_inference(False, True)))


def test_owlrl_inference_no_assertion() -> None:
    logging.debug("Ground truth:\n" + pprint.pformat(_test_inference(True, False)))


def test_owlrl_inference_yes_assertion() -> None:
    logging.debug("Ground truth:\n" + pprint.pformat(_test_inference(True, True)))
