# Spear Phishing

This directory contains an illustration of the [Open Cybersecurity Alliance "Spear Phishing" Use Case](https://github.com/opencybersecurityalliance/oca-ontology/tree/1850684bbbbb954957a630cd283cd5df2dd066f6/Use%20Case), rendered in CASE and UCO.


## Development conventions

The illustration here has been started by sketching all nodes and illustrations of the OCA PowerPoint presentation.  Named individuals start with the knowledge base IRI prefix `http://www.semanticweb.org/OpenCyberSecurityAlliance/Ontology/EndpointProtection/`, with shorthand prefix `kb:`.  Edges use the ontology prefix `urn:example:unmapped/`, with shorthand prefix `unmapped:`.

The UCO rule requiring all named individuals end with a UUID has been deactivated for this illustration, to support direct comparison with another mapping of this scenario using another ontology.

As documentation and figures are transcribed to RDF, all named individuals are initially given only the type `uco-core:UcoThing`.

At the end of the scenario rendering process, all individuals will have the most specific types available within CASE and UCO, and all predicates in the graph with the prefix `unmapped:` will be replaced with approprate properties or `uco-core:Relationship` objects.
