# Inference Examples

This illustration includes example investigative questions that require inference, and sample JSON-LD of *proposed* use of Inference object. The Inference object references the object(s) being evaluated and the hypothesis under consideration:

```json
{
 "@id": "inference-uuid",
 "@type": "Inference",
 "hypothesis": "(hypothesis object under consideration)",
 "usedMethod": "Reference to the defined process used to evaluate basisEvidence in light of the hypothesis",
 "evaluationType": "probability",
 "evidenceEvaluation": 0.95,
 "evidenceRationale": "The observations are compatible with simulated tests of the hypothesized action",
 "basisEvidence": ["(objects forming the basis for inference)"]
}
```

This structure is an updated example of Inference based on the paper [Standardization of File Recovery Classification and Authentication](https://doi.org/10.1016/j.diin.2019.06.004) by Casey, Nelson, and Hyde.  This example is also related to examples in [Standardization of forming and expressing preliminary evaluative opinions on digital evidence](https://doi.org/10.1016/j.fsidi.2019.200888) by Casey.

When making inferences on the basis of observed evidence, it is important to consider alternatives. Selecting a single hypothesis without consideration of alternatives increases risk of confirmation bias. When conducting a cyber-investigation, observed evidence is the result of an activity, not the activity itself. The observed evidence could have an alternative explanation than the most obvious or initially imagined one. Therefore, it is good practice to consider alternative hypotheses when evaluating observed evidence, including the opposing hypothesis.


## State of this illustration

This illustration has been written in support of a Change Proposal under design and discussion, and hence may change in response to the proposal's evolution.  New ontology concepts are in the file [`drafting.ttl`](drafting.ttl).

Notes on how to revise this page are in [`CONTRIBUTE.md`](CONTRIBUTE.md).

A total JSON-LD file of the data on this page, plus supplementary data needed to support queries, is available here: [`inference.json`](inference.json).


## Example - Recovery of a xlsx file

*Observations*: A digital forensic tools presents a non-allocated file named `contacts.xlsx` as recovered with associated metadata, but further authentication is necessary to assess whether the data on disk presented by the tool is the actual original content of the file. Further forensic examination finds that the data on disk presented by the tool is incompatible with the file metadata and expected content type (Microsoft Excel file). 

* Hypothesis 1: The file is `Fully Recovered`
* Hypothesis 2: The file is `Partially Recovered`
* Hypothesis 3: Only `Name and Metadata Recovered`
* Hypothesis 4: Only `Name Recovered`

The following inferences can be stated in words as "the observations are exceedingly more probable given Hypothesis 3 (`Only Name and Metadata Recovered`), rather than the other hypotheses."

```json
[
    {
        "@id": "kb:investigative-action-9d3e78d9-8376-4277-9852-8e6bf9267456",
        "@type": "case-investigation:InvestigativeAction",
        "uco-core:name": "authentication",
        "uco-core:description": "Authentication of automated file recovery results",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-core:hasFacet": [
            {
                "@type": "uco-action:ActionReferencesFacet",
                "uco-action:location": {
                    "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
                },
                "uco-action:performer": {
                    "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
                },
                "uco-action:instrument": {
                    "@id": "kb:autoauthenticator-83715215-c5fc-4231-99ff-29a3c51cb5f1"
                },
                "uco-action:environment": {
                    "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
                },
                "uco-action:object": [
                    {
                        "@id": "kb:provenance-record-2fceaee2-60da-4192-b4eb-54868cbeaa41"
                    },
                    {
                        "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
                    },
                    {
                        "@id": "kb:hypothesis-32c8f595-388d-48fe-989b-4c81053e2c51"
                    },
                    {
                        "@id": "kb:hypothesis-b3ef496f-714e-4479-9f82-382ce5d751c2"
                    },
                    {
                        "@id": "kb:hypothesis-e125ff00-bb1c-4020-8cc6-2ed6ff963402"
                    },
                    {
                        "@id": "kb:hypothesis-fa7bb4d5-e9eb-4a5f-aa1f-e6af19f2eaa0"
                    }
                ],
                "uco-action:result": [
                    {
                        "@id": "kb:provenance-record-35ef9e5a-a8e7-49d4-8667-301e0b0f7f16"
                    },
                    {
                        "@id": "kb:inference-1c050613-1144-4622-853a-48291f63ef54"
                    },
                    {
                        "@id": "kb:inference-2aaf35bb-6ca9-4b30-98e4-192552a2468e"
                    },
                    {
                        "@id": "kb:inference-3c0014ff-8616-4103-915f-54a69f486576"
                    },
                    {
                        "@id": "kb:inference-4b880bde-9afb-4c60-a277-29f53a0df283"
                    }
                ]
            }
        ]
    },
    {
        "@id": "kb:inference-1c050613-1144-4622-853a-48291f63ef54",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-32c8f595-388d-48fe-989b-4c81053e2c51"
        },
        "drafting:evaluationType": "C-Scale",
        "drafting:evaluationRationale": "Recovered content data not compatible with expected based on file type. No complete recovered content could be attributed to this file.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.1"
        },
        "drafting:basisEvidence": {
            "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
        },
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:inference-2aaf35bb-6ca9-4b30-98e4-192552a2468e",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-b3ef496f-714e-4479-9f82-382ce5d751c2"
        },
        "drafting:evaluationType": "C-Scale",
        "drafting:evaluationRationale": "No fragment of recovered content could be attributed to this file.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.1"
        },
        "drafting:basisEvidence": {
            "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
        },
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:inference-3c0014ff-8616-4103-915f-54a69f486576",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-e125ff00-bb1c-4020-8cc6-2ed6ff963402"
        },
        "drafting:evaluationType": "C-Scale",
        "drafting:evaluationRationale": "Filename and metadata were recovered for this file, but no associated content was recovered.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "5.5"
        },
        "drafting:basisEvidence": {
            "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
        },
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:inference-4b880bde-9afb-4c60-a277-29f53a0df283",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-fa7bb4d5-e9eb-4a5f-aa1f-e6af19f2eaa0"
        },
        "drafting:evaluationType": "C-Scale",
        "drafting:evaluationRationale": "Metadata was recovered along with filename, but no associated content was recovered.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.1"
        },
        "drafting:basisEvidence": {
            "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
        },
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701",
        "@type": "drafting:Method",
        "uco-core:description": "File recovery method described in https://doi.org/10.1016/j.diin.2019.06.004"
    }
]
```


### Query - Most probable hypothesis

To ask whether the file is `Fully Recovered` is the wrong question because it does not consider alternatives and raises the risk of confirmation bias.

Rather, the question is "Which class/category of file recovery is more supported by the evidence?" In this example, the result of only `Name and Metadata Recovered` has the highest assigned probability versus the others.

|    | ?lStatement                      | ?lEvaluationType   |   ?lEvidenceEvaluation | ?lEvaluationRationale                                                                                                                   |
|----|----------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
|  0 | Fully recovered                  | C-Scale            |                    0.1 | Recovered content data not compatible with expected based on file type. No complete recovered content could be attributed to this file. |
|  1 | Partially recovered              | C-Scale            |                    0.1 | No fragment of recovered content could be attributed to this file.                                                                      |
|  2 | Only name and metadata recovered | C-Scale            |                    5.5 | Filename and metadata were recovered for this file, but no associated content was recovered.                                            |
|  3 | Only name recovered              | C-Scale            |                    0.1 | Metadata was recovered along with filename, but no associated content was recovered.                                                    |

## Example - Machine learning and image location

Consider an example of a photograph of the Washington monument from an angle at dusk (fading light). Two machine learning classifiers produce the following assertions:

* *ML1 Hypothesis*: The object in the photograph is the Washington Monument in Washington, DC.
* *ML2 Hypothesis*: The object in the photograph is Cleopatra's Needle in New York City.

Further forensic analysis is performed of the photograph and its metadata, which reveals that it was taken in Washington DC. Inference assigns a value (e.g., probability, strength) to the observations (photograph content) and analysis outputs (geolocation information) given each Hypothesis:

*Inference 1*: The observations and analysis results are exceedingly more likely given the assertion that the object in the photograph is the Washington Monument in Washington, DC, rather than Cleopatra's Needle in New York City. 

```json
[
    {
        "@id": "kb:investigative-action-3d5a8d9-8376-4277-9852-8e6bf9263c55",
        "@type": "case-investigation:InvestigativeAction",
        "uco-core:name": "identification",
        "uco-core:description": "Identify the object in the photograph",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-02T10:12:00.00Z"
        },
        "uco-core:hasFacet": [
            {
                "@type": "uco-action:ActionReferencesFacet",
                "uco-action:location": {
                    "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
                },
                "uco-action:performer": {
                    "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
                },
                "uco-action:instrument": {
                    "@id": "kb:autoauthenticator-83715215-c5fc-4231-99ff-29a3c51cb5f1"
                },
                "uco-action:environment": {
                    "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
                },
                "uco-action:object": [
                    {
                        "@id": "kb:provenance-record-0cd1ceaf-9d35-42fa-abe6-8f4e237e027a"
                    },
                    {
                        "@id": "kb:provenance-record-9e555155-a9bc-43ef-95a1-aeb83fb3ca72"
                    },
                    {
                        "@id": "kb:location-9d25eb6e-1077-42a7-b531-1d170d4b585b"
                    },
                    {
                        "@id": "kb:relationship-74cb5afd-8bec-4544-a724-bfbf11df29a0"
                    },
                    {
                        "@id": "kb:photograph-2808aaa6-f53c-4e89-b0a9-2e47677489b1"
                    }
                ],
                "uco-action:result": [
                    {
                        "@id": "kb:provenance-record-1a609160-fe75-4908-8a0e-ab323a9b1fb7"
                    },
                    {
                        "@id": "kb:inference-839fcf98-b2f2-47ef-8dd0-d85d395a9ac7"
                    }
                ]
            }
        ]
    },
    {
        "@id": "kb:inference-839fcf98-b2f2-47ef-8dd0-d85d395a9ac7",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-2fc331cc-25ad-47a4-a9c1-d11132b4ea68"
        },
        "drafting:evaluationType": "probability",
        "drafting:evaluationRationale": "Looks like the obelisk at Washington Monument and photo Exif contains geolocation data that resolves to a location near the Washington monument.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.9"
        },
        "drafting:basisEvidence": [
            {
                "@id": "kb:location-9d25eb6e-1077-42a7-b531-1d170d4b585b"
            },
            {
                "@id": "kb:relationship-74cb5afd-8bec-4544-a724-bfbf11df29a0"
            },
            {
                "@id": "kb:photograph-2808aaa6-f53c-4e89-b0a9-2e47677489b1"
            }
        ]
    }
]
```

However, a skeptic might argue that photographs can be faked or geolocation information can be spoofed, and might make the following Hypothesis and Inference:

* *Skeptic's Hypothesis*: The photograph is fake.

*Skeptic's Inference*: The observations and analysis results are equally probable given the assertion that the object in the photograph is the Washington Monument in Washington, DC or Cleopatra's Needle in New York City. 

```json
[
    {
        "@id": "kb:inference-baf0e98e-94da-4de4-af12-c5cac897d027",
        "@type": "drafting:Inference",
        "rdfs:comment": [
            "(This inference is skeptical.)",
            "(In this current state of illustration, this inference has no further supporting evidence.)"
        ],
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-901bc2b4-5878-4c4d-aad9-59f30a4ce5e1"
        },
        "drafting:evaluationType": "probability",
        "drafting:evaluationRationale": "Photograph contents and Exif data can be altered.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.9"
        },
        "drafting:basisEvidence": {
            "@id": "kb:photograph-2808aaa6-f53c-4e89-b0a9-2e47677489b1"
        }
    }
]
```

If there is no indication that the photograph was tampered with, a reasonable decision maker would favor the first inference over the Skeptic's. Conversely, if further analysis reveals that the photograph was tampered with, the decision maker might give more consideration to the Skeptic's inference. Furthermore, the first inference could be updated to match the Skeptic's. Therefore, inferences can change as new information becomes available.


### Query - Differences in basis evidence

Two inferences are referenced above (`kb:inference-839fcf98...` and `kb:inference-baf0e98e...`).  What differences in basis evidence did the two have?

The following table is the results of [this query](src/query-select-skeptic-difference.sparql).  "Supports A" is support for only the initial analyst's finding, "Supports B" is support for only the skeptic's finding.

|    | ?nBasisObject                                                           | ?lSupports   |
|----|-------------------------------------------------------------------------|--------------|
|  0 | http://example.org/kb/location-9d25eb6e-1077-42a7-b531-1d170d4b585b     | A            |
|  1 | http://example.org/kb/relationship-74cb5afd-8bec-4544-a724-bfbf11df29a0 | A            |
|  2 | http://example.org/kb/photograph-2808aaa6-f53c-4e89-b0a9-2e47677489b1   | both         |