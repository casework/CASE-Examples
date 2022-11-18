<!--
GENERATED FILE

README.md is generated from a template file, src/README.md.in, and JSON snippets under src/.  If you need to revise narrative text, edit src/README.md.in.  If you need to revise data, please find and revise the containing snippet.  Editing patterns follow the patterns described in the CASE website's CONTRIBUTE.md:
https://github.com/casework/casework.github.io/blob/master/CONTRIBUTE.md#maintenance-of-generated-files
-->


# HypothesisTestResult (a.k.a. AnalyticInference) Examples

This illustration includes cyber-investigation examples that require hypothessis testing and a resulting evidence-based opinion/conclusion. The sample JSON-LD provides *proposed* use of a HypothesisTestResult facet atached to an AnalyticResult object. 

This structure is an updated example of AnalyticInference based on the paper [Standardization of File Recovery Classification and Authentication](https://doi.org/10.1016/j.diin.2019.06.004) by Casey, Nelson, and Hyde.  This example is also related to examples in [Standardization of forming and expressing preliminary evaluative opinions on digital evidence](https://doi.org/10.1016/j.fsidi.2019.200888) by Casey.  The data tampering examples ("Wiping", "Mass deletion") are analytic results related to evidence tampering, with background provided in the DFRWS-EU 2020 presentation "[Expressing evaluative conclusions in cases involving tampering of digital evidence](https://dfrws.org/wp-content/uploads/2020/06/DFRWS-EU-2020-Expressing-evaluative-conclusions-in-cases-involving-tampering-of-digital-evidence.pdf)" by Bollé, Servida, Polewczyk, Souvignet and Casey.

When performing evidence-based hypothesis testing, the evidenceEvaluation value is assigned to the observations, not the hypothesis.

When making inferences on the basis of observed evidence, it is important to consider alternatives. Selecting a single hypothesis without consideration of alternatives increases risk of confirmation bias. When conducting a cyber-investigation, observed evidence is the result of an activity, not the activity itself. The observed evidence could have an alternative explanation than the most obvious or initially imagined one. Therefore, it is good practice to consider alternative hypotheses when evaluating observed evidence, including the opposing hypothesis.


## State of this illustration

This illustration has been written in support of a Change Proposal under design and discussion, and hence may change in response to the proposal's evolution.  New ontology concepts are in the file [`drafting.ttl`](drafting.ttl).

Notes on how to revise this page are in [`CONTRIBUTE.md`](CONTRIBUTE.md).

A total JSON-LD file of the data on this page, plus supplementary data needed to support queries, is available here: [`inference.json`](inference.json).


## Example - Recovery of a xlsx file

A digital forensic tools presents a non-allocated file named `contacts.xlsx` as recovered with associated metadata. However, the tool does automatically check whether the recovered content currently stored on disk is the actual original content of the file. Therefore, it is necessary to treat this tool output as a hypothesis, and also assess alternative hypotheses

* Hypothesis 1: The file is `Fully Recovered`
* Hypothesis 2: The file is `Partially Recovered`
* Hypothesis 3: Only `Name and Metadata Recovered`
* Hypothesis 4: Only `Name Recovered`

Further analysis finds that the data on disk presented by the tool is incompatible with the file metadata and expected content type (Microsoft Excel file).

```json
[
    {
        "@id": "kb:hypothesis-18106707-C4F7-4807-8D4F-3376AFD7D33A",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Fully Recovered"
    },
    {
        "@id": "kb:hypothesis-D2129305-B562-44BB-8DE6-A68192050368",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Partially Recovered"
    },
    {
        "@id": "kb:hypothesis-A6D88832-49C4-483D-A1D1-33108EB6860D",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Name and Metadata Recovered"
    },
    {
        "@id": "kb:hypothesis-8D836E71-3394-49DA-9E7B-8ADE534D45A6",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Name Recovered"
    },
    {
        "@id": "kb:analysisaction-9d3e78d9-8376-4277-9852-8e6bf9267456",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "authentication",
        "uco-core:description": "Authentication of automated file recovery results",
        "drafting:isAutomated": "false",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
            },
            {
                "@id": "kb:hypothesis-18106707-C4F7-4807-8D4F-3376AFD7D33A"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-1c050613-1144-4622-853a-48291f63ef54"
            }
        ]
    },
    {
        "@id": "kb:analysisaction-DE007954-40FE-4F87-A0A7-BD67FB1F6E96",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "authentication",
        "uco-core:description": "Authentication of automated file recovery results",
        "drafting:isAutomated": "false",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
            },
            {
                "@id": "kb:hypothesis-D2129305-B562-44BB-8DE6-A68192050368"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-2aaf35bb-6ca9-4b30-98e4-192552a2468e"
            }
        ]
    },
    {
        "@id": "kb:analysisaction-71AF3D6E-6986-4977-A663-D0430FE074CB",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "authentication",
        "uco-core:description": "Authentication of automated file recovery results",
        "drafting:isAutomated": "false",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
            },
            {
                "@id": "kb:hypothesis-A6D88832-49C4-483D-A1D1-33108EB6860D"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-3c0014ff-8616-4103-915f-54a69f486576"
            }
        ]
    },
    {
        "@id": "kb:analysisaction-5F487329-6F1F-446C-80B7-13A52D3E0A51",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "authentication",
        "uco-core:description": "Authentication of automated file recovery results",
        "drafting:isAutomated": "false",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:file-c3001862-2b68-402d-a3c1-01311f178137"
            },
            {
                "@id": "kb:hypothesis-8D836E71-3394-49DA-9E7B-8ADE534D45A6"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-4b880bde-9afb-4c60-a277-29f53a0df283"
            }
        ]
    },
    {
        "@id": "kb:analysisresult-1c050613-1144-4622-853a-48291f63ef54",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-9d3e78d9-8376-4277-9852-8e6bf9267456",
        "uco-core:hasFacet": [
          {
            "@type": "drafting:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.1"
            },
            "drafting:evaluationType": "C-Scale",
            "drafting:conclusion": "false",
            "drafting:evaluationRationale": "Recovered content data not compatible with expected based on file type. No complete recovered content could be attributed to this file." 
          }
       ]
    },
    {
        "@id": "kb:analysisresult-2aaf35bb-6ca9-4b30-98e4-192552a2468e",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-DE007954-40FE-4F87-A0A7-BD67FB1F6E96",
        "uco-core:hasFacet": [
          {
            "@type": "drafting:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.1"
            },
            "drafting:evaluationType": "C-Scale",
            "drafting:conclusion": "false",
            "drafting:evaluationRationale": "No fragment of recovered content could be attributed to this file." 
          }
       ]
    },
    {
        "@id": "kb:analysisresult-3c0014ff-8616-4103-915f-54a69f486576",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-DE007954-40FE-4F87-A0A7-BD67FB1F6E96",
        "uco-core:hasFacet": [
          {
            "@type": "drafting:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "5.5"
            },
            "drafting:evaluationType": "C-Scale",
            "drafting:conclusion": "true",
            "drafting:evaluationRationale": "Filename and metadata were recovered for this file, but no associated content was recovered." 
          }
       ]
    },
    {
        "@id": "kb:analysisresult-4b880bde-9afb-4c60-a277-29f53a0df283",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-DE007954-40FE-4F87-A0A7-BD67FB1F6E96",
        "uco-core:hasFacet": [
          {
            "@type": "drafting:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.1"
            },
            "drafting:evaluationType": "C-Scale",
            "drafting:conclusion": "false",
            "drafting:evaluationRationale": "Metadata was recovered along with filename, but no associated content was recovered." 
          }
       ]
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

|    | ?lEvaluationType   |   ?lEvidenceEvaluation | ?lEvaluationRationale                                                                                                                   | ?lConclusion   |
|----|--------------------|------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|----------------|
|  0 | C-Scale            |                    0.1 | No fragment of recovered content could be attributed to this file.                                                                      | false          |
|  1 | C-Scale            |                    5.5 | Filename and metadata were recovered for this file, but no associated content was recovered.                                            | true           |
|  2 | C-Scale            |                    0.1 | Recovered content data not compatible with expected based on file type. No complete recovered content could be attributed to this file. | false          |
|  3 | C-Scale            |                    0.1 | Metadata was recovered along with filename, but no associated content was recovered.                                                    | false          |

## Example - Machine learning and image location

Consider an example of a photograph of the Washington monument from an angle at dusk (fading light). Two machine learning classifiers produce the following assertions:

* *ML1 Hypothesis*: The object in the photograph is the Washington Monument in Washington, DC.
* *ML2 Hypothesis*: The object in the photograph is Cleopatra's Needle in New York City.

Further forensic analysis is performed of the photograph and its metadata, which reveals that it was taken in Washington DC. Inference assigns a value (e.g., probability, strength) to the observations (photograph content) and analysis outputs (geolocation information) given each Hypothesis:

*AnalyticInference 1*: The observations and analysis results are exceedingly more likely given the assertion that the object in the photograph is the Washington Monument in Washington, DC, rather than Cleopatra's Needle in New York City. 

```json
[
    {
        "@id": "kb:hypothesis-382C613C-8E69-4F11-A54B-B5416FBC42BC",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Photograph depicts the Washington Monument in Washington DC"
    },
    {
        "@id": "kb:hypothesis-DFA763B2-5EB6-4320-9674-BC591C693948",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "Photograph depicts Cleopatra's Needle in New York City"
    },
    {
        "@id": "kb:analysisaction-B615357B-F1B5-40B0-BA97-368DC6C817B9",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "identification",
        "uco-core:description": "Identify the object in the photograph",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-02T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-A52482A9-185A-41E8-A0D2-F74D9185D178"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:hypothesis-382C613C-8E69-4F11-A54B-B5416FBC42BC"
            },
            {
                "@id": "kb:locationDC-9d25eb6e-1077-42a7-b531-1d170d4b585b"
            },
            {
                "@id": "kb:relationshipDC-74cb5afd-8bec-4544-a724-bfbf11df29a0"
            },
            {
                "@id": "kb:photograph-CC3FB8C7-26E7-4F71-889F-FAF75187E8F9"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-C16CEAB2-F25F-4E04-8227-244CB148B9A1"
            }
        ]
    },
    {
        "@id": "kb:analysisresult-C16CEAB2-F25F-4E04-8227-244CB148B9A1",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-B615357B-F1B5-40B0-BA97-368DC6C817B9",
        "uco-core:hasFacet": [
          {
            "@type": "uco-analysis:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.9"
            },
            "drafting:evaluationType": "probability",
            "drafting:conclusion": "true",
            "drafting:evaluationRationale": "Looks like the obelisk at Washington Monument and photo Exif contains geolocation data that resolves to a location near the Washington monument" 
          }
       ]
    },
    {
        "@id": "kb:analysisaction-F7CD9C61-1830-4158-8B15-8158C0E59082",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "identification",
        "uco-core:description": "Identify the object in the photograph",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-02T10:20:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-A52482A9-185A-41E8-A0D2-F74D9185D178"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
            {
                "@id": "kb:hypothesis-DFA763B2-5EB6-4320-9674-BC591C693948"
            },
            {
                "@id": "kb:locationNY-FB6B63E3-A6D8-453B-9754-D79B9527734D"
            },
            {
                "@id": "kb:relationshipNY-83CC5ECC-4FC1-41FD-846A-544F884C6A85"
            },
            {
                "@id": "kb:photograph-CC3FB8C7-26E7-4F71-889F-FAF75187E8F9"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisresult-BA5D0146-BA3B-467F-975C-763D85BAFC7D"
            }
        ]
    },
    {
        "@id": "kb:analysisresult-BA5D0146-BA3B-467F-975C-763D85BAFC7D",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-F7CD9C61-1830-4158-8B15-8158C0E59082",
        "uco-core:hasFacet": [
          {
            "@type": "uco-analysis:HypothesisTestResultFacet",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.1"
            },
            "drafting:evaluationType": "probability",
            "drafting:conclusion": "false",
            "drafting:evaluationRationale": "Does not looks like Cleopatra's Needle in New York City and photo Exif contains geolocation data that resolves to a location near the Washington monument" 
          }
       ]
    }
]
```

However, a skeptic might argue that photographs can be faked or geolocation information can be spoofed, and might make the following Hypothesis and AnalyticInference:

* *Skeptic's Hypothesis*: The photograph is fake.

*Skeptic's AnalyticInference*: The observations and analysis results are equally probable given the assertion that the object in the photograph is the Washington Monument in Washington, DC or Cleopatra's Needle in New York City. 

```json
[
    {
        "@id": "kb:analysisresult-5BCEDE9F-760E-46C4-A9DE-74EC0BA5FCDA",
        "@type": "drafting:AnalyticResult",
        "rdfs:comment": [
            "(This inference is skeptical.)",
            "(In this current state of illustration, this inference has no further supporting evidence.)"
        ],
        "drafting:originatingAnalysisAction": "kb:analysisaction-242CBB2B-9DCB-451B-994F-E70770F1BC50",
        "uco-core:hasFacet": [
          {
            "@type": "uco-analysis:HypothesisTestResultFacet",
            "drafting:evaluationType": "probability",
            "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.9"
            },
            "drafting:evaluationRationale": "Photograph contents and Exif data can be altered" 
          }
       ]
    }
]
```

If there is no indication that the photograph was tampered with, a reasonable decision maker would favor the first hypothesis test result over the Skeptic's. Conversely, if further analysis reveals that the photograph was tampered with, the decision maker might give more consideration to the Skeptic's hypothesis. Furthermore, the first AnalyticInference could be updated to match the Skeptic's. Therefore, hypothesis test results can change as new information becomes available.


### Query - Differences in basis evidence

Two hypothesis test results (analytic inferences) are referenced above (`kb:analysisresult-C16CEAB2...` and `kb:analysisresult-5BCEDE9F...`).  What differences in basis evidence did the two have?

The following table is the results of [this query](src/query-select-skeptic-difference.sparql).  "Supports A" is support for only the initial analyst's finding, "Supports B" is support for only the skeptic's finding.

| ?nBasisObject   | ?lSupports   |
|-----------------|--------------|
## Example - Wiping

*Observations*: Consider an example of a file named “abc.exe” that is a secure erase program which overwrites the content and name of selected files, rendering them unrecoverable. This program has the same hash value of the secure erase program called “sdelete.exe” which is freely available on the Internet. Observed file system patterns on the computer are compatible with  use of “sdelete.exe” (Name overwritten, Zeroed content). Dates in file system metadata of these files corresponding to dates of Registry entries (UserAssist) and Prefetch files recording use of “abc.exe” program.

* Hypothesis 1: File wiping occurred 
* Hypothesis 2: File wiping did not occur

The following hypothesis test results can be stated in words as the observations are exceedingly more probable in light of Hypothesis 1 (wiping), rather than Hypothesis 2 (no wiping).

```json
[
    {
        "@id": "kb:hypothesis-C2AF7986-39C1-4B80-836B-3B8B6817D337",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "File wiping occurred"
    },
    {
        "@id": "kb:hypothesis-55CB7EAF-933F-44C0-A266-55D5CB196C3F",
        "@type": "drafting:Hypothesis",
        "drafting:statement": "File wiping did not occur"
    },
    {
        "@id": "kb:analysisaction-321E1116-F203-41E4-9D66-86C96B0B9C34",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "file wiping detection",
        "uco-core:description": "Detection of secure erase wiping of files on storage media",
        "drafting-uco-action:isAutomated":"true",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
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
                "@id": "kb:hypothesis-C2AF7986-39C1-4B80-836B-3B8B6817D337"
            },
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
        "uco-action:result": [
            {
                "@id": "kb:analyticresult-BE7AF920-532E-4997-9282-9EE448CADF60"
            }
        ]
    },
    {
        "@id": "kb:analyticresult-BE7AF920-532E-4997-9282-9EE448CADF60",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-321E1116-F203-41E4-9D66-86C96B0B9C34",
        "uco-core:hasFacet": [
          {
            "@type": "uco-analysis:HypothesisTestResultFacet",
            "drafting:evaluationType": "probability",
              "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.95"
            },
            "drafting:conclusion": "true",
            "drafting:evaluationRationale": "Overwrite patterns of deleted files/filenames compatible with use of sdelete.exe wiping tool present on system" 
          }
       ]
    },
    {
        "@id": "kb:analysisaction-DFB676AA-ED89-43AC-B49F-AFF9E835152D",
        "@type": "case-investigation:InvestigativeAction",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "file wiping detection",
        "uco-core:description": "Detection of secure erase wiping of files on storage media",
        "drafting-uco-action:isAutomated":"true",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
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
                "@id": "kb:hypothesis-55CB7EAF-933F-44C0-A266-55D5CB196C3F"
            },
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
        "uco-action:result": [
            {
                "@id": "kb:analyticresult-0DF747A2-0CCA-415E-A1E3-B7DEF8C18C04"
            }
        ]
    },
    {
        "@id": "kb:analyticresult-0DF747A2-0CCA-415E-A1E3-B7DEF8C18C04",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-321E1116-F203-41E4-9D66-86C96B0B9C34",
        "uco-core:hasFacet": [
          {
            "@type": "uco-analysis:HypothesisTestResultFacet",
            "drafting:evaluationType": "probability",
              "drafting:evidenceEvaluation": {
                "@type": "xsd:decimal",
                "@value": "0.05"
            },
            "drafting:conclusion": "false",
            "drafting:evaluationRationale": "Hypothesis contradicts observed evidence of overwrite patterns of deleted files/filenames compatible with use of sdelete.exe wiping tool present on system" 
          }
       ]
    }
]
```

## Example - Mass Deletion

*Observations*: All of the previously existing directories that last contained files of interest are now in deleted state on the disks, but were recovered using forensic software. These directories are listed below along with their last accessed timestamp, which indicates when they changed to deleted state. These previously existing directories, and others under the same parent directory, all have last accessed dates on 17 April 2021. Entries in Recycle Bin for these files are dated 17 April 2021.

* Hypothesis 1: A folder and all its contents were deleted on 17 April 2021 
* Hypothesis 2: A folder and all its contents were not deleted on 17 April 2021

The following hypothesis test results can be stated in words as the observations are exceedingly more probable in light of Hypothesis 1 (targeted and deliberate deletion), rather than Hypothesis 2 (not targeted and deliberate deletion)

```json
[
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
        "@id": "kb:analysisaction-9bb9f420-58b1-4bde-84db-f81de2077513",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "mass deletion detection",
        "uco-core:description": "Detection of mass deletion of files on storage media",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
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
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisaction-1ccab5f9-8b02-4046-9ade-a2310b5c91c0"
            }
        ]
    },
    {
        "@id": "kb:analysisaction-BB624906-2C39-423E-B60F-6991C1D1B2B9",
        "@type": "drafting:AnalysisAction",
        "uco-core:name": "mass deletion detection",
        "uco-core:description": "Detection of mass deletion of files on storage media",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2021-05-01T10:12:00.00Z"
        },
        "uco-action:location": {
            "@id": "kb:lab-c44e4679-26e3-4585-aaa1-86110db936f8"
        },
        "uco-action:performer": {
            "@id": "kb:forensic-practitioner-09fb01ce-999e-4521-bd3f-f7be69a63a43"
        },
        "uco-action:instrument": {
            "@id": "kb:method-2473b57f-8c7e-4672-99a1-1107bf2cb701"
        },
        "uco-action:environment": {
            "@id": "kb:forensic-computer-2132063b-7753-4b51-b146-827e9a1d5037"
        },
        "uco-action:object": [
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
                "@id": "kb:hypothesis-feee4b71-8566-46a3-bc55-74076365acca"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:analysisaction-49c8f1db-0301-485e-95f3-d2cf92815323"
            }
        ]
    },
    {
        "@id": "kb:analysisresult-1ccab5f9-8b02-4046-9ade-a2310b5c91c0",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-9bb9f420-58b1-4bde-84db-f81de2077513",
        "uco-core:hasFacet": [
            {
                "@type": "uco-analysis:HypothesisTestResultFacet",
                "drafting:evidenceEvaluation": {
                    "@type": "xsd:decimal",
                    "@value": "0.9"
                },
                "drafting:evaluationType": "Probability",
                "drafting:conclusion": "true",
                "drafting:evaluationRationale": "Folder and all subfolders in deleted state have the same last accessed date on 17 April 2021, which occurs when parent folder is deleted. This last accessed data is close in time to Recycle Bin records associated with deleted files."
            }
        ]
    },
    {
        "@id": "kb:analysisresult-49c8f1db-0301-485e-95f3-d2cf92815323",
        "@type": "drafting:AnalyticResult",
        "drafting:originatingAnalysisAction": "kb:analysisaction-BB624906-2C39-423E-B60F-6991C1D1B2B9",
        "uco-core:hasFacet": [
            {
                "@type": "uco-analysis:HypothesisTestResultFacet",
                "drafting:evidenceEvaluation": {
                    "@type": "xsd:decimal",
                    "@value": "0.1"
                },
                "drafting:evaluationType": "Probability",
                "drafting:conclusion": "false",
                "drafting:evaluationRationale": "Hypothesis contradicts observed evidence of multiple folders and contents being deleted, as well as Recycle Bin records."
            }
        ]
    }
]
```

