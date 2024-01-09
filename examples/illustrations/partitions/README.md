<!--
GENERATED FILE  README.md is generated from source files.  Edits to it will be overwritten by automated processes.:

If you need to edit its content, edit src/README.md.in, and then re-run `make` to re-build the file.
-->


# Partitions Examples

*A file containing all of the JSON-LD content within this page is here: [`partitions.json`](partitions.json).*

*A file containing draft ontology concepts is here: [`drafting.ttl`](drafting.ttl).  It is expected to be removed with the completion of [UCO Issue 376](https://github.com/ucoProject/UCO/issues/376).*

Although an individual partition can be represented using [`uco-observable:DiskPartitionFacet`](https://ontology.unifiedcyberontology.org/documentation/class-observablediskpartitionfacet.html), there is a need to represent the `DiskPartitionSystem` that lists the `DiskPartition` details.

The following subclasses may be needed but are beyond the scope of this proposal: `GPTPartitionSystem`, `MBRPartitionSystem`, `BSDDiskLabel`, and `ApplePartitionMap`.


## Extended Partitions

Illustrative examples are provided here to cover conditions commonly encountered when parsing partitions and recovering lost partitions.

These examples use a shared dataset that contains an MBR partition table and FAT and NTFS file systems, but the representation of partitions can be translated to other partition schemes.

More specifically, these examples use the disk image `New USB Example.dd` created by Chris Hargreaves with three active partitions and one lost partition that was an extended partition [see CH website](https://github.com/chrishargreaves/):

A tested tool (named "Tool 4" in the accompanying CASE data) provides a list of active partitions, but does not automatically find the lost partition that was previously referenced by the extended partition.

Proposed representation of `DiskPartitionSystem` in CASE:

```json
[
    {
        "@id": "kb:DiskPartitionSystem-a639c005-a0be-4eab-ac44-e9f48cc84245",
        "@type": "drafting:DiskPartitionSystem",
        "uco-core:hasFacet": [
            {
                "@id": "kb:DiskPartitionSystemFacet-61ecd83f-5c20-4b41-bf6f-6d10bebfdb4c",
                "@type": "drafting:DiskPartitionSystemFacet",
                "drafting:diskPartitionSchemeType": "MBR",
                "drafting:diskSignature": "04A95A92",
                "drafting:unpartitionableSpace": "3997696",
                "drafting:partitionList": {
                    "@id": "kb:partitionlist-e0d00075-96fa-443e-be97-78efe0e8bc38",
                    "@type": "co:List",
                    "co:size": {
                        "@type": "xsd:nonNegativeInteger",
                        "@value": "4"
                    },
                    "co:element": [
                        {
                            "@id": "kb:DiskPartition1-d34878c1-5caf-4bea-9436-8d45a2603899"
                        },
                        {
                            "@id": "kb:DiskPartition2-7868ea24-0fcd-4484-9841-9fc9d4f25e20"
                        },
                        {
                            "@id": "kb:DiskPartition3-7aad22df-5d2e-40fc-8815-93cc2a815e15"
                        },
                        {
                            "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17"
                        }
                    ],
                    "co:item": [
                        {
                            "@id": "kb:partitionlist-item-470d9cd6-eab4-400f-988d-7b8decb07119",
                            "@type": "co:ListItem",
                            "co:index": {
                                "@type": "xsd:positiveInteger",
                                "@value": "1"
                            },
                            "co:itemContent": {
                                "@id": "kb:DiskPartition1-d34878c1-5caf-4bea-9436-8d45a2603899"
                            },
                            "co:nextItem": {
                                "@id": "kb:partitionlist-item-3739b0ad-e313-40a8-bfa5-b012449e7e93"
                            }
                        },
                        {
                            "@id": "kb:partitionlist-item-3739b0ad-e313-40a8-bfa5-b012449e7e93",
                            "@type": "co:ListItem",
                            "co:index": {
                                "@type": "xsd:positiveInteger",
                                "@value": "2"
                            },
                            "co:itemContent": {
                                "@id": "kb:DiskPartition2-7868ea24-0fcd-4484-9841-9fc9d4f25e20"
                            },
                            "co:nextItem": {
                                "@id": "kb:partitionlist-item-34eb880e-8ce6-4bc1-a78f-cc95653c11a2"
                            }
                        },
                        {
                            "@id": "kb:partitionlist-item-34eb880e-8ce6-4bc1-a78f-cc95653c11a2",
                            "@type": "co:ListItem",
                            "co:index": {
                                "@type": "xsd:positiveInteger",
                                "@value": "3"
                            },
                            "co:itemContent": {
                                "@id": "kb:DiskPartition3-7aad22df-5d2e-40fc-8815-93cc2a815e15"
                            },
                            "co:nextItem": {
                                "@id": "kb:partitionlist-item-9bd1300f-f544-4a27-9729-0c3d2112b6cd"
                            }
                        },
                        {
                            "@id": "kb:partitionlist-item-9bd1300f-f544-4a27-9729-0c3d2112b6cd",
                            "@type": "co:ListItem",
                            "co:index": {
                                "@type": "xsd:positiveInteger",
                                "@value": "4"
                            },
                            "co:itemContent": {
                                "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17"
                            }
                        }
                    ]
                }
            }
        ]
    }
]
```

A tested tool (named "Tool 1" in the accompanying CASE data) has a feature to recover lost partitions, which was successful with this dataset.

This recovered partition can be represented using the `observable:RecoveredObjectFacet` as follows:

```json
[
    {
        "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17",
        "@type": [
            "uco-observable:DiskPartition",
            "uco-observable:RecoveredObject"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:disk-partition-facet-588a0bb6-f791-445c-8d1c-826bd5465f3c",
                "@type": "uco-observable:DiskPartitionFacet",
                "uco-observable:observableCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2023-08-15T00:29:15Z"
                },
                "uco-observable:diskPartitionType": "FAT32",
                "drafting:partitionName": "NO NAME",
                "drafting:diskPartitionOffset": 377618432,
                "uco-observable:partitionID": "4",
                "drafting:diskPartitionLength": 52428800
            },
            {
                "@id": "kb:recovered-object-facet-f135ac26-bbf0-4eab-949b-6a5dfe147c22",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:contentRecoveredStatus": {
                    "@type": "uco-vocabulary:RecoveredObjectStatusVocab",
                    "@value": "recovered"
                },
                "uco-observable:metadataRecoveredStatus": {
                    "@type": "uco-vocabulary:RecoveredObjectStatusVocab",
                    "@value": "recovered"
                },
                "uco-observable:nameRecoveredStatus": {
                    "@type": "uco-vocabulary:RecoveredObjectStatusVocab",
                    "@value": "recovered"
                }
            }
        ]
    }
]
```

Once the lost partition has been recovered, the contained file system can be parsed and non-allocated files can be recovered.


## Result correspondence

One way to review tool results is seeing how the recovered objects compare with known information about the initial subject data.  For instance, the setup notes include that four partitions, plus the special container "Extended" partition, in an MBR partitioning system were created, and the last partition was unallocated but not wiped.  The tools' found partition objects can be related to the original objects using `Relationship`s produced from an `Analysis`.

```json
[
    {
        "@id": "kb:Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2",
        "@type": "uco-core:Relationship",
        "uco-core:isDirectional": false,
        "uco-core:kindOfRelationship": "Corresponds_to",
        "uco-core:source": {
            "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17"
        },
        "uco-core:target": {
            "@id": "kb:DiskPartition-5000a2e8-13d4-4cab-bf2a-bcf217b991f0"
        }
    },
    {
        "@id": "kb:Relationship-27762c2c-7140-4ea9-924e-5c9941671c82",
        "@type": "uco-core:Relationship",
        "uco-core:isDirectional": false,
        "uco-core:kindOfRelationship": "Corresponds_to",
        "uco-core:source": {
            "@id": "kb:DiskPartition-e8be10dc-44ec-4fb6-844e-53f18b7513c4"
        },
        "uco-core:target": {
            "@id": "kb:DiskPartition-4f68c4c7-8efc-4c0f-ad7f-20fe2ced2fb1"
        }
    }
]
```

The first `Relationship` relates the recovered partition to the partition that was deleted, and was drawn from review of the prepared partition system and the recovered partition system.  Illustration of the provenance of specifically the `Analysis`'s found `Relationship` is [here](figures/partitions-prov-focused-b6ab7ce4.svg?raw=true).

```json
[
    {
        "@id": "kb:AnalyticResult-e69d471d-e0a7-4647-9365-1fb662f02bdf",
        "@type": "uco-analysis:AnalyticResult",
        "uco-analysis:originatingAnalysis": {
            "@id": "kb:Analysis-313d688e-0bb9-4504-a474-d390b0a27010"
        },
        "uco-analysis:resultContent": {
            "@id": "kb:Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2"
        }
    },
    {
        "@id": "kb:Analysis-313d688e-0bb9-4504-a474-d390b0a27010",
        "@type": [
            "case-investigation:InvestigativeAction",
            "uco-analysis:Analysis"
        ],
        "uco-core:description": "Compare recovered partition against original",
        "uco-action:performer": {
            "@id": "kb:Role-3bfb3efb-ffaa-4d93-a27d-e9e52f345b1b"
        },
        "uco-action:object": [
            {
                "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17"
            },
            {
                "@id": "kb:ProvenanceRecord-0d32f92d-a906-4066-8ddb-bc264cc7d976"
            },
            {
                "@id": "kb:Relationship-05df462f-a09a-45f9-b0bc-33af56fad990"
            },
            {
                "@id": "kb:DiskPartitionSystem-a639c005-a0be-4eab-ac44-e9f48cc84245"
            },
            {
                "@id": "kb:DiskPartitionSystem-0c96e621-9eff-43e8-bd3d-9e4e8c075df0"
            },
            {
                "@id": "kb:DiskPartition-5000a2e8-13d4-4cab-bf2a-bcf217b991f0"
            },
            {
                "@id": "kb:Relationship-05f2c909-3a5c-433f-918d-3b410df21e69"
            },
            {
                "@id": "kb:ProvenanceRecord-3ac62016-0bbe-4f0e-bf7d-07d4de019fd1"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2"
            },
            {
                "@id": "kb:AnalyticResult-e69d471d-e0a7-4647-9365-1fb662f02bdf"
            },
            {
                "@id": "kb:ProvenanceRecord-ee82f650-2ccf-4363-8fe2-b3fd4c465681"
            }
        ]
    },
    {
        "@id": "kb:ProvenanceRecord-ee82f650-2ccf-4363-8fe2-b3fd4c465681",
        "@type": "case-investigation:ProvenanceRecord",
        "uco-core:object": [
            {
                "@id": "kb:Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2"
            },
            {
                "@id": "kb:AnalyticResult-e69d471d-e0a7-4647-9365-1fb662f02bdf"
            }
        ]
    }
]
```

The other `Relationship` relates the parsed, still-active "Extended" partition reported by Tool 4 to the prepared partition system's "Extended" partition.  Illustration of the provenance of specifically the `Analysis`'s found `Relationship` is [here](figures/partitions-prov-focused-27762c2c.svg?raw=true).

```json
[
    {
        "@id": "kb:AnalyticResult-8bf460c4-adaf-4839-83b6-ff1d80f7abbd",
        "@type": "uco-analysis:AnalyticResult",
        "uco-analysis:originatingAnalysis": {
            "@id": "kb:Analysis-39dcec1b-caa0-41c9-ab12-e45a39d73233"
        },
        "uco-analysis:resultContent": {
            "@id": "kb:Relationship-27762c2c-7140-4ea9-924e-5c9941671c82"
        }
    },
    {
        "@id": "kb:Analysis-39dcec1b-caa0-41c9-ab12-e45a39d73233",
        "@type": [
            "case-investigation:InvestigativeAction",
            "uco-analysis:Analysis"
        ],
        "uco-core:description": "Compare parsed partition against original",
        "uco-action:performer": {
            "@id": "kb:Role-3bfb3efb-ffaa-4d93-a27d-e9e52f345b1b"
        },
        "uco-action:object": [
            {
                "@id": "kb:DiskPartitionSystem-08e84357-d739-402b-a4b5-3d63c55622fa"
            },
            {
                "@id": "kb:DiskPartition-e8be10dc-44ec-4fb6-844e-53f18b7513c4"
            },
            {
                "@id": "kb:Relationship-122dd1b1-1da4-4fa3-a701-f5a334d85037"
            },
            {
                "@id": "kb:ProvenanceRecord-7d2c2d0f-e1d6-44ea-9a1d-68370efed01f"
            },
            {
                "@id": "kb:DiskPartitionSystem-0c96e621-9eff-43e8-bd3d-9e4e8c075df0"
            },
            {
                "@id": "kb:DiskPartition-4f68c4c7-8efc-4c0f-ad7f-20fe2ced2fb1"
            },
            {
                "@id": "kb:Relationship-c439b4b4-e07e-4bbe-b9b1-4fccb762e565"
            },
            {
                "@id": "kb:ProvenanceRecord-4e73ba28-8741-41d8-b774-acf06cbd976f"
            },
            {
                "@id": "kb:ProvenanceRecord-3ac62016-0bbe-4f0e-bf7d-07d4de019fd1"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:Relationship-27762c2c-7140-4ea9-924e-5c9941671c82"
            },
            {
                "@id": "kb:AnalyticResult-8bf460c4-adaf-4839-83b6-ff1d80f7abbd"
            },
            {
                "@id": "kb:ProvenanceRecord-14fde3cf-b65a-4ef8-b539-ef43e0763787"
            }
        ]
    },
    {
        "@id": "kb:ProvenanceRecord-14fde3cf-b65a-4ef8-b539-ef43e0763787",
        "@type": "case-investigation:ProvenanceRecord",
        "uco-core:object": [
            {
                "@id": "kb:Relationship-27762c2c-7140-4ea9-924e-5c9941671c82"
            },
            {
                "@id": "kb:AnalyticResult-8bf460c4-adaf-4839-83b6-ff1d80f7abbd"
            }
        ]
    }
]
```

These two `AnalyticResults` complement one another by discussing separate interdependent objects from the original partition system.  From them and ground truth knowledge of the initial `Relationship`s, another conclusion is drawn, that the file system recovered by Tool 1 corresponds with the file system in the partition that had been deleted.  That correspondence between file systems is then fed into a similar analysis determining the correspondence between recovered `SECOND.TXT` files.  Illustration of the provenance of specifically the file systems' `Analysis`'s found `Relationship` is [here](figures/partitions-prov-focused-8589174a.svg?raw=true), and the files' [here](figures/partitions-prov-focused-5a191a50.svg?raw=true), though the history by now attains sufficient visual complexity that it is likely total review of the chain of communication and possibly delegation would be more accessible.  See the table in [provenance illustrations](#provenance-illustrations).  Each of the linked SVGs contains searchable text, if one wishes to locate where in an object's history a certain node enters.

```json
[
    {
        "@id": "kb:Relationship-8589174a-2a25-4b7d-9ff6-eee7f39e2fab",
        "@type": "uco-core:Relationship",
        "uco-core:isDirectional": false,
        "uco-core:kindOfRelationship": "Corresponds_to",
        "uco-core:source": {
            "@id": "kb:FileSystem-0cb3c77d-6333-405f-b376-e9e30340cfd4"
        },
        "uco-core:target": {
            "@id": "kb:FileSystem-4c4577c2-cbf2-41c6-a615-02a78c0577a4"
        }
    },
    {
        "@id": "kb:AnalyticResult-2ffdd3da-9eb5-409c-bcce-6ad289c869fe",
        "@type": "uco-analysis:AnalyticResult",
        "uco-analysis:originatingAnalysis": {
            "@id": "kb:Analysis-32be09b3-89cd-4461-9098-c5204220abd5"
        },
        "uco-analysis:resultContent": {
            "@id": "kb:Relationship-8589174a-2a25-4b7d-9ff6-eee7f39e2fab"
        }
    },
    {
        "@id": "kb:Analysis-32be09b3-89cd-4461-9098-c5204220abd5",
        "@type": [
            "case-investigation:InvestigativeAction",
            "uco-analysis:Analysis"
        ],
        "uco-core:description": "Using belief of correspondence between parsed extended partition with original extended partition; and recovered partition with original last partition; compare recovered file system against original file system in last partition",
        "uco-action:performer": {
            "@id": "kb:Role-3bfb3efb-ffaa-4d93-a27d-e9e52f345b1b"
        },
        "uco-action:object": [
            {
                "@id": "kb:Relationship-27762c2c-7140-4ea9-924e-5c9941671c82"
            },
            {
                "@id": "kb:AnalyticResult-8bf460c4-adaf-4839-83b6-ff1d80f7abbd"
            },
            {
                "@id": "kb:ProvenanceRecord-14fde3cf-b65a-4ef8-b539-ef43e0763787"
            },
            {
                "@id": "kb:AnalyticResult-e69d471d-e0a7-4647-9365-1fb662f02bdf"
            },
            {
                "@id": "kb:Relationship-b6ab7ce4-9f8c-4adc-9fdb-d5ab36f5aad2"
            },
            {
                "@id": "kb:ProvenanceRecord-ee82f650-2ccf-4363-8fe2-b3fd4c465681"
            },
            {
                "@id": "kb:FileSystem-0cb3c77d-6333-405f-b376-e9e30340cfd4"
            },
            {
                "@id": "kb:Relationship-e6679bc7-e4df-416e-9565-c33883f3716e"
            },
            {
                "@id": "kb:DiskPartition4-5715fe11-06b8-45ac-832d-c4167f4aac17"
            },
            {
                "@id": "kb:ProvenanceRecord-0d32f92d-a906-4066-8ddb-bc264cc7d976"
            },
            {
                "@id": "kb:FileSystem-4c4577c2-cbf2-41c6-a615-02a78c0577a4"
            },
            {
                "@id": "kb:Relationship-de84dae6-9be2-4ac1-b334-c667b2fe4b28"
            },
            {
                "@id": "kb:DiskPartition-5000a2e8-13d4-4cab-bf2a-bcf217b991f0"
            },
            {
                "@id": "kb:ProvenanceRecord-3ac62016-0bbe-4f0e-bf7d-07d4de019fd1"
            },
            {
                "@id": "kb:ProvenanceRecord-4e73ba28-8741-41d8-b774-acf06cbd976f"
            }
        ],
        "uco-action:result": [
            {
                "@id": "kb:Relationship-8589174a-2a25-4b7d-9ff6-eee7f39e2fab"
            },
            {
                "@id": "kb:AnalyticResult-2ffdd3da-9eb5-409c-bcce-6ad289c869fe"
            },
            {
                "@id": "kb:ProvenanceRecord-ead0d8a8-b8b7-41cc-876e-3a7529cff711"
            }
        ]
    },
    {
        "@id": "kb:ProvenanceRecord-ead0d8a8-b8b7-41cc-876e-3a7529cff711",
        "@type": "case-investigation:ProvenanceRecord",
        "uco-core:object": [
            {
                "@id": "kb:Relationship-8589174a-2a25-4b7d-9ff6-eee7f39e2fab"
            },
            {
                "@id": "kb:AnalyticResult-2ffdd3da-9eb5-409c-bcce-6ad289c869fe"
            }
        ]
    }
]
```


## Relationship illustrations

Using a proof-of-concept illustration system, a render of this scenario's `uco-core:Relationship` objects is available:

![figures/partitions-relationships.svg](figures/partitions-relationships.svg?raw=true)


## Provenance illustrations

Following visual-design practices of [PROV-O](https://www.w3.org/TR/prov-o/), the following renders of this scenario are available:

| Figure's contents | Time hidden | Time displayed |
| --- | --- | --- |
| All | ![figures/partitions-prov-all.svg](figures/partitions-prov-all.svg?raw=true) | ![figures/partitions-prov-time-all.svg](figures/partitions-prov-time-all.svg?raw=true) |
| Chains of communication (activities) | ![figures/partitions-prov-activities.svg](figures/partitions-prov-activities.svg?raw=true) | ![figures/partitions-prov-time-activities.svg](figures/partitions-prov-time-activities.svg?raw=true) |
| Chains of delegation (agents) | ![figures/partitions-prov-agents.svg](figures/partitions-prov-agents.svg?raw=true) | ![figures/partitions-prov-time-agents.svg](figures/partitions-prov-time-agents.svg?raw=true) |
| Chains of derivation (entities) | ![figures/partitions-prov-entities.svg](figures/partitions-prov-entities.svg?raw=true) | ![figures/partitions-prov-time-entities.svg](figures/partitions-prov-time-entities.svg?raw=true) |
| Chains of communication and delegation | ![figures/partitions-prov-activities-agents.svg](figures/partitions-prov-activities-agents.svg?raw=true) | ![figures/partitions-prov-time-activities-agents.svg](figures/partitions-prov-time-activities-agents.svg?raw=true) |
| Chains of communication and derivation | ![figures/partitions-prov-activities-entities.svg](figures/partitions-prov-activities-entities.svg?raw=true) | ![figures/partitions-prov-time-activities-entities.svg](figures/partitions-prov-time-activities-entities.svg?raw=true) |
| Chains of delegation and derivation | ![figures/partitions-prov-agents-entities.svg](figures/partitions-prov-agents-entities.svg?raw=true) | ![figures/partitions-prov-time-agents-entities.svg](figures/partitions-prov-time-agents-entities.svg?raw=true) |
