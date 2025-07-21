<!--
GENERATED FILE  README.md is generated from source files.  Edits to it will be overwritten by automated processes.:

If you need to edit its content, edit src/README.md.in, and then re-run `make` to re-build the file.
-->


# Recoverability Examples

*A file containing all of the JSON-LD content within this page is here: [`recoverability.json`](recoverability.json).*

*A file containing draft ontology concepts is here: [`drafting.ttl`](drafting.ttl).  It is expected to be removed with the completion of [UCO Issue 251](https://github.com/ucoProject/UCO/issues/251).*

There is a requirement to represent the recoverability status of entries in file systems, particularly in digital forensic examinations. 
For clarity and completeness, it is necessary to represent the recoverability of unallocated filename, metadata, and content.

These states can be represented using the `RecoveredObjectFacet` with the following properties and values:

* `nameRecoveredStatus`: recovered, overwritten, unknown
* `metadataRecoveredStatus`: recovered, overwritten, unknown 
* `contentRecoveredStatus`: recovered, partially recovered, overwritten, unknown

This representation applies to file systems as well as "file system within a file" data structures such as SQLite databases and Windows Registry hives.
For further details and background, see [Standardization of File Recovery Classification and Authentication](https://www.nist.gov/publications/standardization-file-recovery-classification-and-authentication). Additional recoverability scenarios are available in the initial proposal [Representing Recoverability of Unallocated Files](https://caseontology.org/resources/references/Representing%20Recoverability%20of%20Unallocated%20Files%20using%20CASE%20UCO%2031Jan2018.pdf) with the caveat that examples use an early version of CASE/UCO.

# File System Recoverability

Illustrative examples are provided here to cover conditions commonly encountered when recovering unallocated files. These examples use shared datasets that contain FAT and NTFS file systems, but the representation of unallocated recoverability can be translated to other file systems such as EXT. 

When information is recoverable, it is represented explicitly in these examples. Recoverable metadata are represented using the `FileFacet`, including `fileName` and `filePath`.

Using the NIST image `dfr-01-fat.dd` of a FAT 12 file system with unallocated files [see NIST website](https://cfreds-archive.nist.gov/dfr-test-images.html), particularly XBIED.txt at file offset 11040 (logical sector 170, physical sector 298):

```json
[
    {
        "@id": "kb:cb0354f5-2dbd-4c02-8a6c-011b77125ee2",
        "@type": [
            "uco-observable:RecoveredObject",
            "uco-observable:File"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:file-facet-41e9483b-8b13-42d6-a05b-431b78906a05",
                "@type": "uco-observable:FileFacet",
                "uco-observable:observableCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2011-12-25T19:02:22Z"
                },
                "uco-observable:modifiedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2000-02-29T19:11Z"
                },
                "uco-observable:accessedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "1999-01-02T05:00Z"
                },
                "uco-observable:extension": "txt",
                "uco-observable:fileName": "_BEID.txt",
                "uco-observable:filePath": "/img_dfr-01-fat.dd/vol_vol2/_BEID.txt",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 712
            },
            {
                "@id": "kb:recovered-object-facet-cdb678d8-f75c-4997-a975-59966d8c5530",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:nameRecoveredStatus": "recovered",
                "uco-observable:metadataRecoveredStatus": "recovered",
                "uco-observable:contentRecoveredStatus": "recovered"
            }
        ]
    }
]
```

Using the [Crossover](https://caseontology.org/examples/crossover/) shared dataset, specifically the Windows computer available here: [Switch Drive](https://drive.switch.ch/index.php/s/0c7BiyQZRKOtMMq)
The following shows a file system entry that has recoverable filename "~badquinn3@gmail.com.ost.tmp" , but the status of associated metadata and content are unknown.

![AutopsyCrossoverDeleted.png](https://files.caseontology.org/CASE-Examples/examples/illustrations/recoverability/AutopsyCrossoverDeleted.png)

This recovered file system entry can be represented using the `observable:RecoveredObjectFacet` as follows:

```json
[
    {
        "@id": "kb:bd64bdd9-3dcd-4828-a25b-a72c06e472cd",
        "@type": [
            "uco-observable:RecoveredObject",
            "uco-observable:File"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:file-facet-ebb15653-ea33-43f4-995e-b8ab9a1e6378",
                "@type": "uco-observable:FileFacet",
                "uco-observable:accessedTime": null,
                "uco-observable:extension": "tmp",
                "uco-observable:fileName": "~badquinn3@gmail.com.ost.tmp",
                "uco-observable:filePath": "/Users/Harley Quinn/AppData/Local/Microsoft/Outlook/badquinn3@gmail.com.ost",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": null,
                "uco-observable:observableCreatedTime": null,
                "uco-observable:modifiedTime": null
            },
            {
                "@id": "kb:recovered-object-facet-b95a915a-d4f4-4dd7-8367-b11dce27c9cc",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:nameRecoveredStatus": "recovered",
                "uco-observable:metadataRecoveredStatus": "unknown",
                "uco-observable:contentRecoveredStatus": "unknown"
            }
        ]
    }
]
```

Again using the [Crossover](https://caseontology.org/examples/crossover/) shared dataset, the LNK file "Users/Harley Quinn/AppData/Roaming/Microsoft/Windows/Recent/Thebatplan.lnk" references a file on a USB device "D:\Thebatplan" with associated metadata represented here, and the `contentRecoveredStatus` unknown:

```json
[
    {
        "@id": "kb:665d63be-93e6-4d3e-8e75-3112be091e93",
        "@type": [
            "uco-observable:RecoveredObject",
            "uco-observable:File"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:file-facet-4783de40-fcad-4e9b-9090-5c5cb4871a93",
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "",
                "uco-observable:fileName": "Thebatplan",
                "uco-observable:filePath": "D:\\Thebatplan",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 1389601,
                "uco-observable:observableCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-11-19T00:29:15Z"
                },
                "uco-observable:accessedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-11-18T22:53:09.595Z"
                },
                "uco-observable:modifiedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-11-18T20:10:48.00Z"
                }
            },
            {
                "@id": "kb:recovered-object-facet-65fd4337-734a-4350-ab0c-18d8098b8b0e",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:nameRecoveredStatus": "recovered",
                "uco-observable:metadataRecoveredStatus": "recovered",
                "uco-observable:contentRecoveredStatus": "unknown"
            }
        ]
    }
]
```

Similar to a LNK file on Windows, entries in the external.db entry on the Samsung device in the Crossover shared dataset can be represented using the `observable:RecoveredObjectFacet` with the `contentRecoveredStatus` unknown. For instance, the "files" table in the SQLite database "Samsung Galaxy S6 Edge / UFED File Root / USERDATA (ExtX) / Root / data / com.android.providers.media / databases / external.db" references the file IMG-20181120-WA0000.jpg:

```json
[
    {
        "@id": "kb:4026fabd-924d-4138-a6ba-73df2eb37bcb",
        "@type": [
            "uco-observable:RecoveredObject",
            "uco-observable:File"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:file-facet-8ce65705-90ab-4934-abb3-67d9c84d81a0",
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "jpg",
                "uco-observable:fileName": "IMG-20181120-WA0000",
                "uco-observable:filePath": "/storage/emulated/0/WhatsApp/Media/WhatsApp Images/Sent/IMG-20181120-WA0000.jpg",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 1389601,
                "uco-observable:observableCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-11-19T00:29:15Z"
                }
            },
            {
                "@id": "kb:recovered-object-facet-95c7b098-ab46-4867-b050-6b095a7bd1b8",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:nameRecoveredStatus": "recovered",
                "uco-observable:metadataRecoveredStatus": "recovered",
                "uco-observable:contentRecoveredStatus": "unknown"
            }
        ]
    }
]
```

# SQLite Entry Recoverability

SQLite records that are recoverable can also be represented using the `observable:RecoveredObjectFacet`. For example, this Facebook messenger chat:

![FacebookChat.png](https://files.caseontology.org/CASE-Examples/examples/illustrations/recoverability/FacebookChat.png)


This recovered chat message can be represented using the `observable:RecoveredObjectFacet`, noting that the sent location does not appear to be recovered, indicating that the content is partially recovered.

```json
[
    {
        "@id": "kb:c01e67f9-adb5-48bd-b09d-e7326fa8d592",
        "@type": [
            "uco-observable:RecoveredObject",
            "uco-observable:Message"
        ],
        "uco-core:hasFacet": [
            {
                "@id": "kb:message-facet-1cd126fc-e556-4460-9c1e-37c2ed553367",
                "@type": "uco-observable:MessageFacet",
                "uco-observable:messageText": "Diana sent a location.",
                "uco-observable:from": {
                    "@id": "kb:e1e34d20-e77c-4087-a87d-d169d7155b8d"
                },
                "uco-observable:to": [
                    {
                        "@id": "kb:f96cfe21-1149-4a46-acb9-7299152c776b"
                    }
                ],
                "uco-observable:sentTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-12-04T07:52:47Z"
                }
            },
            {
                "@id": "kb:recovered-object-facet-1dc5e3f4-4951-44ff-b9f3-14bd63684b29",
                "@type": "uco-observable:RecoveredObjectFacet",
                "uco-observable:nameRecoveredStatus": "recovered",
                "uco-observable:metadataRecoveredStatus": "recovered",
                "uco-observable:contentRecoveredStatus": "partially recovered"
            }
        ]
    }
]
```

