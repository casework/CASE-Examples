# Inference Examples

This illustration includes example investigative questions that require inference, and sample JSON-LD of *proposed* use of Inference object. The Inference object references the object(s) being evaluated and the hypothesis under consideration:

```json
{
 "@id": "inference-uuid",
 "@type": "Inference",
 "basisEvidence": ["(objects forming the basis for inference)"],
 "hypothesis": "(hypothesis object under consideration)",
 "usedMethod": "Reference to the defined process used to evaluate basisEvidence in light of the hypothesis",
 "evaluationType": "probability",
 "evidenceEvaluation": 0.95,
 "evaluationRationale": "The observations are compatible with simulated tests of the hypothesized action"
}
```

This structure is an updated example of Inference based on the paper [Standardization of File Recovery Classification and Authentication](https://doi.org/10.1016/j.diin.2019.06.004) by Casey, Nelson, and Hyde.  This example is also related to examples in [Standardization of forming and expressing preliminary evaluative opinions on digital evidence](https://doi.org/10.1016/j.fsidi.2019.200888) by Casey.  The data tampering examples ("Wiping", "Mass deletion") are inferences related to evidence tampering, with background provided in the DFRWS-EU 2020 presentation "[Expressing evaluative conclusions in cases involving tampering of digital evidence](https://dfrws.org/wp-content/uploads/2020/06/DFRWS-EU-2020-Expressing-evaluative-conclusions-in-cases-involving-tampering-of-digital-evidence.pdf)" by Bollé, Servida, Polewczyk, Souvignet and Casey.

When making an evidence-based inference, the evidenceEvaluation value is assigned to the observations, not the hypothesis.

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
        "rdfs:comment": "This methodology has been found applicable for deleted files, Recycle bin records, and experimentation simulating mass deletion.",
        "uco-core:description": "Forensic file data and metadata recovery methodology described in https://doi.org/10.1016/j.diin.2019.06.004"
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
## Example - Wiping

*Observations*: Consider an example of a file named “abc.exe” that is a secure erase program which overwrites the content and name of selected files, rendering them unrecoverable. This program has the same hash value of the secure erase program called “sdelete.exe” which is freely available on the Internet. Observed file system patterns on the computer are compatible with  use of “sdelete.exe” (Name overwritten, Zeroed content). Dates in file system metadata of these files corresponding to dates of Registry entries (UserAssist) and Prefetch files recording use of “abc.exe” program.

* Hypothesis 1: File wiping occurred 
* Hypothesis 2: File wiping did not occur

The following inferences can be stated in words as the observations are exceedingly more probable in light of Hypothesis 1 (wiping), rather than Hypothesis 2 (no wiping).

```json
[
    {
        "@id": "kb:investigative-action-9ec40d34-1606-4fb1-94ca-b61f08bfc3eb",
        "@type": "case-investigation:InvestigativeAction",
        "uco-core:name": "file wiping detection",
        "uco-core:description": "Detection of secure erase wiping of files on storage media",
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
                    "@id": "kb:massdeletiondetector-841ee50b-2f39-4b4c-baf0-9022219b0845"
                },
                "uco-action:environment": {
                    "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
                },
                "uco-action:object": [
                    {
                        "@id": "kb:hypothesis-e304bcf3-b220-4102-9b75-c4e5c15225c2"
                    },
                    {
                        "@id": "kb:hypothesis-f0381f46-ad10-4c0a-a72c-7233f09ca7c7"
                    },
                    {
                        "@id": "kb:prefetch-b7671bf3-d6b2-4491-9cee-5817805004e8"
                    },
                    {
                        "@id": "kb:provenance-record-2dacb20f-02d3-4f13-b072-8227d625292c"
                    },
                    {
                        "@id": "kb:registry-b38dc916-acc8-40a7-a52d-65f435ec2850"
                    },
                    {
                        "@id": "kb:sdelete-30d63040-d606-4636-8aa2-ea16e20365ee"
                    },
                    {
                        "@id": "kb:wipedfilename-c322412e-9dd1-4989-8a3f-1a08006d629e"
                    }
                ],
                "uco-action:result": [
                    {
                        "@id": "kb:provenance-record-3c0930fb-5992-4b3d-b728-baad0e55ec57"
                    },
                    {
                        "@id": "kb:inference-1a06b278-1434-4a8f-887b-ea32448032de"
                    },
                    {
                        "@id": "kb:inference-491c1ef4-6542-450e-b8b0-a021142d2718"
                    }
                ]
            }
        ]
    },
    {
        "@id": "kb:hypothesis-e304bcf3-b220-4102-9b75-c4e5c15225c2",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "File wiping occurred"
    },
    {
        "@id": "kb:hypothesis-f0381f46-ad10-4c0a-a72c-7233f09ca7c7",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "File wiping did not occur"
    },
    {
        "@id": "kb:inference-1a06b278-1434-4a8f-887b-ea32448032de",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "hypothesis-e304bcf3-b220-4102-9b75-c4e5c15225c2"
        },
        "drafting:evaluationType": "Probability",
        "drafting:evaluationRationale": "Overwrite patterns of deleted files/filenames compatible with use of sdelete.exe wiping tool present on system.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.95"
        },
        "drafting:basisEvidence": [
            {
                "@id": "kb:prefetch-b7671bf3-d6b2-4491-9cee-5817805004e8"
            },
            {
                "@id": "kb:sdelete-30d63040-d606-4636-8aa2-ea16e20365ee"
            },
            {
                "@id": "kb:registry-b38dc916-acc8-40a7-a52d-65f435ec2850"
            },
            {
                "@id": "kb:wipedfilename-c322412e-9dd1-4989-8a3f-1a08006d629e"
            }
        ],
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:inference-491c1ef4-6542-450e-b8b0-a021142d2718",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-f0381f46-ad10-4c0a-a72c-7233f09ca7c7"
        },
        "drafting:evaluationType": "Probability",
        "drafting:evaluationRationale": "Hypothesis contradicts observed evidence of overwrite patterns of deleted files/filenames compatible with use of sdelete.exe wiping tool present on system.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.05"
        },
        "drafting:basisEvidence": [
            {
                "@id": "kb:prefetch-b7671bf3-d6b2-4491-9cee-5817805004e8"
            },
            {
                "@id": "kb:registry-b38dc916-acc8-40a7-a52d-65f435ec2850"
            },
            {
                "@id": "kb:sdelete-30d63040-d606-4636-8aa2-ea16e20365ee"
            },
            {
                "@id": "kb:wipedfilename-c322412e-9dd1-4989-8a3f-1a08006d629e"
            }
        ],
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    }
]
```

## Example - Mass Deletion

*Observations*: All of the previously existing directories that last contained files of interest are now in deleted state on the disks, but were recovered using forensic software. These directories are listed below along with their last accessed timestamp, which indicates when they changed to deleted state. These previously existing directories, and others under the same parent directory, all have last accessed dates on 17 April 2021. Entries in Recycle Bin for these files are dated 17 April 2021.

* Hypothesis 1: A folder and all its contents were deleted on 17 April 2021 
* Hypothesis 2: A folder and all its contents were not deleted on 17 April 2021

The following inferences can be stated in words as the observations are exceedingly more probable in light of Hypothesis 1 (targeted and deliberate deletion), rather than Hypothesis 2 (not targeted and deliberate deletion)

```json
[
    {
        "@id": "kb:investigative-action-9bb9f420-58b1-4bde-84db-f81de2077513",
        "@type": "case-investigation:InvestigativeAction",
        "uco-core:name": "mass deletion detection",
        "uco-core:description": "Detection of mass deletion of files on storage media",
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
                    "@id": "kb:massdeletiondetector-841ee50b-2f39-4b4c-baf0-9022219b0845"
                },
                "uco-action:environment": {
                    "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
                },
                "uco-action:object": [
                    {
                        "@id": "kb:provenance-record-2579e024-ca98-4a22-a520-a22786d5a85d"
                    },
                    {
                        "@id": "kb:directory-c76adc20-cf43-4d98-87a8-34f7d5eb6ab7"
                    },
                    {
                        "@id": "kb:directory-d8e55546-6813-40a7-9207-c4b39e5af403"
                    },
                    {
                        "@id": "kb:rbin-31ae9f1e-56fe-4238-9d98-ea5396374efa"
                    },
                    {
                        "@id": "kb:rbin-bc573937-f0ef-4695-8a12-2217218d4185"
                    },
                    {
                        "@id": "kb:hypothesis-ecf366ee-b3cd-42ba-a263-1531c6a5a287"
                    },
                    {
                        "@id": "kb:hypothesis-feee4b71-8566-46a3-bc55-74076365acca"
                    }
                ],
                "uco-action:result": [
                    {
                        "@id": "kb:provenance-record-3619643e-2435-4944-9f86-9a7bd42cad5d"
                    },
                    {
                        "@id": "kb:inference-1ccab5f9-8b02-4046-9ade-a2310b5c91c0"
                    },
                    {
                        "@id": "kb:inference-49c8f1db-0301-485e-95f3-d2cf92815323"
                    }
                ]
            }
        ]
    },
    {
        "@id": "kb:hypothesis-ecf366ee-b3cd-42ba-a263-1531c6a5a287",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Multiple folders and all their contents were deleted on 17 April 2021."
    },
    {
        "@id": "kb:hypothesis-feee4b71-8566-46a3-bc55-74076365acca",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Folders and all their contents were not deleted on 17 April 2021."
    },
    {
        "@id": "kb:inference-1ccab5f9-8b02-4046-9ade-a2310b5c91c0",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "hypothesis-ecf366ee-b3cd-42ba-a263-1531c6a5a287"
        },
        "drafting:evaluationType": "Probability",
        "drafting:evaluationRationale": "Folder and all subfolders in deleted state have the same last accessed date on 17 April 2021, which occurs when parent folder is deleted. This last accessed data is close in time to Recycle Bin records associated with deleted files.",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.9"
        },
        "drafting:basisEvidence": [
            {
                "@id": "kb:directory-c76adc20-cf43-4d98-87a8-34f7d5eb6ab7"
            },
            {
                "@id": "kb:directory-d8e55546-6813-40a7-9207-c4b39e5af403"
            },
            {
                "@id": "kb:rbin-31ae9f1e-56fe-4238-9d98-ea5396374efa"
            },
            {
                "@id": "kb:rbin-bc573937-f0ef-4695-8a12-2217218d4185"
            }
        ],
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    },
    {
        "@id": "kb:inference-49c8f1db-0301-485e-95f3-d2cf92815323",
        "@type": "drafting:Inference",
        "drafting:hypothesis": {
            "@id": "kb:hypothesis-feee4b71-8566-46a3-bc55-74076365acca"
        },
        "drafting:evaluationType": "Probability",
        "drafting:evaluationRationale": "Hypothesis contradicts observed evidence of multiple folders and contents being deleted, as well as Recycle Bin records",
        "drafting:evidenceEvaluation": {
            "@type": "xsd:float",
            "@value": "0.1"
        },
        "drafting:basisEvidence": [
            {
                "@id": "kb:directory-c76adc20-cf43-4d98-87a8-34f7d5eb6ab7"
            },
            {
                "@id": "kb:directory-d8e55546-6813-40a7-9207-c4b39e5af403"
            },
            {
                "@id": "kb:rbin-31ae9f1e-56fe-4238-9d98-ea5396374efa"
            },
            {
                "@id": "kb:rbin-bc573937-f0ef-4695-8a12-2217218d4185"
            }
        ],
        "drafting:usedMethod": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        }
    }
]
```

