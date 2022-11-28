These examples were drafted as part of introducing the Analysis namespace in [UCO Issue 400](https://github.com/ucoProject/UCO/issues/400).


## Malware analysis

This example illustrates manual software malware analysis within the Cyber Threat Intelligence application domain.

```json
[
    {
        "@id": "kb:organization-fb6c05a0-b6be-4a10-ba62-0e7b1da4c0ec",
        "@type": "uco-identity:Organization",
        "uco-core:name": "hex-rays"
    },
    {
        "@id": "kb:AnalyticTool-0b635b9f-bdb8-4492-9b4e-dec6797b82db",
        "@type": "uco-tool:AnalyticTool",
        "uco-core:name": "IDA Pro",
        "uco-tool:toolType": "binary code analysis tool",
        "uco-tool:creator": {
            "@id": "kb:organization-fb6c05a0-b6be-4a10-ba62-0e7b1da4c0ec"
        },
        "uco-tool:version": "7.7"
    },
    {
        "@id": "kb:Analysis-f365add7-1326-426f-9266-406bdeed86a1",
        "@type": "uco-analysis:Analysis",
        "uco-core:name": "Reverse engineer software to determine malicious intent",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-12T10:21:00.00Z"
        },
        "uco-core:endTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-14T15:58:00.00Z"
        },
        "drafting:isAutomated": false,
        "uco-action:location": {
            "@id": "kb:9b82c2bc-10f7-47b2-81a8-443a9f458440"
        },
        "uco-action:performer": {
            "@id": "kb:Analyst-c1d5f9cc-10cd-4fdb-9570-e9d00e6df6f7"
        },
        "uco-action:instrument": {
            "@id": "kb:AnalyticTool-0b635b9f-bdb8-4492-9b4e-dec6797b82db"
        },
        "uco-action:environment": {
            "@id": "kb:Computer-e640f827-1f5b-4e8a-bd89-7afdf2c85caa"
        },
        "uco-action:object": [
            {
                "@id": "kb:Software1-2ef1d3c7-eb2d-470d-89ea-291daed6549b"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:ProvenanceRecord-aa90afe6-9069-49bb-8ad8-b05d3f4f143b"
            },
            {
                "@id": "kb:AnalyticResult-67fb2d95-dc94-4833-a270-582c37feb879"
            }
        ]
    },
    {
        "@id": "kb:AnalyticResult-67fb2d95-dc94-4833-a270-582c37feb879",
        "@type": "uco-analysis:AnalyticResult",
        "uco-analysis:originatingAnalysis": {
            "@id": "kb:Analysis-f365add7-1326-426f-9266-406bdeed86a1"
        },
        "uco-core:statement": "Software exhibits malicious intent"
    }
]
```


## Multimedia classification

This example illustrates multimedia classification.

```json
[
    {
        "@id": "kb:organization-2b3b98e2-aea2-4270-876a-7f9917623cb7",
        "@type": "uco-identity:Organization",
        "uco-core:name": "NFI"
    },
    {
        "@id": "kb:AnalyticTool-DAE5EE58-E5ED-4588-93BE-CDEC6FAA9C6A",
        "@type": [
            "uco-tool:AnalyticTool",
            "uco-tool:ConfiguredTool"
        ],
        "uco-core:name": "Hansken",
        "uco-tool:toolType": "DFaaS",
        "uco-tool:creator": {
            "@id": "kb:organization-2b3b98e2-aea2-4270-876a-7f9917623cb7"
        },
        "uco-tool:version": "1.0",
        "uco-configuration:usesConfiguration": [
            {
                "@id": "kb:configuration-3d49f77f-9332-47c2-aa9f-d4b8bb1d5f9c",
                "@type": "uco-configuration:Configuration",
                "uco-configuration:configurationEntry": [
                    {
                        "@id": "kb:configuration-entry-9de0c74d-b009-4228-ac09-19692eba1559",
                        "@type": "uco-configuration:ConfigurationEntry",
                        "uco-configuration:itemName": "classifier",
                        "uco-configuration:itemValue": "nfi-forensic"
                    },
                    {
                        "@id": "kb:configuration-entry-caa1090c-9ef4-4ea9-86ff-375eb5c8ebfd",
                        "@type": "uco-configuration:ConfigurationEntry",
                        "uco-configuration:itemName": "TrainingSet",
                        "uco-configuration:itemValue": "0.0.7"
                    }
                ]
            }
        ]
    },
    {
        "@id": "kb:Analysis-7cd51fa7-63ee-4f40-a482-9ce8333c7556",
        "@type": "uco-analysis:Analysis",
        "uco-core:name": "compute string similarity",
        "uco-core:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-10T08:49:00.00Z"
        },
        "uco-core:endTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-10T09:54:00.00Z"
        },
        "drafting:isAutomated": true,
        "uco-action:location": {
            "@id": "kb:ESC-6FAC81EF-0966-4F05-94BB-2A5D572513CA"
        },
        "uco-action:performer": {
            "@id": "kb:Analyst-13A167EE-D3B5-4AA4-B8BA-83C25F8B8FF4"
        },
        "uco-action:instrument": {
            "@id": "kb:AnalyticTool-DAE5EE58-E5ED-4588-93BE-CDEC6FAA9C6A"
        },
        "uco-action:environment": {
            "@id": "kb:Computer-533FA61A-BE79-469E-A05F-1A341848B925"
        },
        "uco-action:object": [
            {
                "@id": "kb:RasterPicture1-b67308c0-c31b-41a6-805a-10ec526ec8bc"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:ProvenanceRecord-d628b0f6-686d-4d22-a577-ec737e5947bc"
            },
            {
                "@id": "kb:AnalyticResult-3205CB19-0820-4009-B70B-646DBD19598B"
            }
        ]
    },
    {
        "@id": "kb:AnalyticResult-3205CB19-0820-4009-B70B-646DBD19598B",
        "@type": "uco-analysis:AnalyticResult",
        "uco-analysis:originatingAnalysis": {
            "@id": "kb:Analysis-7cd51fa7-63ee-4f40-a482-9ce8333c7556"
        },
        "uco-core:hasFacet": [
            {
                "@id": "kb:artifact-classification-result-facet-61a3c100-7614-4699-8ef2-1ec140018ced",
                "@type": "uco-analysis:ArtifactClassificationResultFacet",
                "uco-analysis:classification": [
                    {
                        "@id": "kb:artifact-classification-74e83eb2-e011-4af1-ad41-b7e915264c68",
                        "@type": "uco-analysis:ArtifactClassification",
                        "uco-analysis:class": "money",
                        "uco-analysis:classificationConfidence": {
                            "@type": "xsd:decimal",
                            "@value": "0.997359037"
                        }
                    }
                ]
            }
        ]
    }
]
```
