<!--
GENERATED FILE  README.md is generated from source files.  Edits to it will be overwritten by automated processes.:

If you need to edit its content, edit src/README.md.in, and then re-run `make` to re-build the file.
-->


# Recoverability Examples

There is a requirement to represent the recoverability status of entries in file systems, particularly in digital forensic examinations. 
For clarity and completeness, it is necessary to represent the recoverability of unallocated filename, metadata, and content.

These states can be represented using the `UnallocatedRecoverabilityFacet` with the following properties and values:

* `nameRecoverabilityStatus`: recovered, overwritten, unknown
* `metadataRecoverabilityStatus`: recovered, overwritten, unknown 
* `contentRecoverabilityStatus`: recovered, partially recovered, overwritten, unknown

This representation applies to file systems as well as "file system within a file" data structures such as SQLite databases and Windows Registry hives.
For further details and background, see [Standardization of File Recovery Classification and Authentication](https://www.nist.gov/publications/standardization-file-recovery-classification-and-authentication). Additional recoverability scenarios are available in the initial proposal [Representing Recoverability of Unallocated Files](https://caseontology.org/resources/references/Representing%20Recoverability%20of%20Unallocated%20Files%20using%20CASE%20UCO%2031Jan2018.pdf) with the caveat that examples use an early version of CASE/UCO.

# File System Recoverability

Illustrative examples are provided here to cover conditions commonly encountered when recovering unallocated files. These examples use shared datasets that contain FAT and NTFS file systems, but the representation of unallocated recoverability can be translated to other file systems such as EXT. 

When information is recoverable, it is represented explicitly in these examples. Recoverable metadata are represented using the `FileFacet`, including `fileName` and `filePath`.

Using the NIST image `dfr-01-fat.dd` of a FAT 12 file system with unallocated files [see NIST website](https://cfreds-archive.nist.gov/dfr-test-images.html), particularly XBIED.txt at file offset 11040 (logical sector 170, physical sector 298):

```json
[
    {
        "@id": "kb:CB0354F5-2DBD-4C02-8A6C-011B77125EE2",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:createdTime": {
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
                "@type": "uco-observable:UnallocatedRecoverabilityFacet",
                "uco-observable:nameRecoverabilityStatus": "recovered",
                "uco-observable:metadataRecoverabilityStatus": "recovered",
                "uco-observable:contentRecoverabilityStatus": "recovered"
            }
        ]
    }
]
```

Using the [Crossover](https://caseontology.org/examples/crossover/) shared dataset, specifically the Windows computer available here: [Switch Drive](https://drive.switch.ch/index.php/s/0c7BiyQZRKOtMMq)
The following shows a file system entry that has recoverable filename "~badquinn3@gmail.com.ost.tmp" , but the status of associated metadata and content are unknown.

![AutopsyCrossoverDeleted.png](https://files.caseontology.org/CASE-Examples/examples/illustrations/recoverability/AutopsyCrossoverDeleted.png)

This recovered file system entry can be represented using the `observable:UnallocatedRecoverabilityFacet` as follows:

```json
[
    {
        "@id": "kb:BD64BDD9-3DCD-4828-A25B-A72C06E472CD",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:accessedTime": null,
                "uco-observable:extension": "tmp",
                "uco-observable:fileName": "~badquinn3@gmail.com.ost.tmp",
                "uco-observable:filePath": "/Users/Harley Quinn/AppData/Local/Microsoft/Outlook/badquinn3@gmail.com.ost",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": null,
                "uco-observable:createdTime": null,
                "uco-observable:modifiedTime": null
            },
            {
                "@type": "uco-observable:UnallocatedRecoverabilityFacet",
                "uco-observable:nameRecoverabilityStatus": "recovered",
                "uco-observable:metadataRecoverabilityStatus": "unknown",
                "uco-observable:contentRecoverabilityStatus": "unknown"
            }
        ]
    }
]
```

Again using the [Crossover](https://caseontology.org/examples/crossover/) shared dataset, the LNK file "Users/Harley Quinn/AppData/Roaming/Microsoft/Windows/Recent/Thebatplan.lnk" references a file on a USB device "D:\Thebatplan" with associated metadata represented here, and the `contentRecoverabilityStatus` unknown:

```json
[
    {
        "@id": "kb:665D63BE-93E6-4D3E-8E75-3112BE091E93",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "",
                "uco-observable:fileName": "Thebatplan",
                "uco-observable:filePath": "D:\\Thebatplan",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 1389601,
                "uco-observable:createdTime": {
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
                "@type": "uco-observable:UnallocatedRecoverabilityFacet",
                "uco-observable:nameRecoverabilityStatus": "recovered",
                "uco-observable:metadataRecoverabilityStatus": "recovered",
                "uco-observable:contentRecoverabilityStatus": "unknown"
            }
        ]
    }
]
```

Similar to a LNK file on Windows, entries in the external.db entry on the Samsung device in the Crossover shared dataset can be represented using the `observable:UnallocatedRecoverabilityFacet` with the `contentRecoverabilityStatus` unknown. For instance, the "files" table in the SQLite database "Samsung Galaxy S6 Edge / UFED File Root / USERDATA (ExtX) / Root / data / com.android.providers.media / databases / external.db" references the file IMG-20181120-WA0000.jpg:

```json
[
    {
        "@id": "kb:4026FABD-924D-4138-A6BA-73DF2EB37BCB",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "jpg",
                "uco-observable:fileName": "IMG-20181120-WA0000",
                "uco-observable:filePath": "/storage/emulated/0/WhatsApp/Media/WhatsApp Images/Sent/IMG-20181120-WA0000.jpg",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 1389601,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2018-11-19T00:29:15Z"
                }
            },
            {
                "@type": "uco-observable:UnallocatedRecoverabilityFacet",
                "uco-observable:nameRecoverabilityStatus": "recovered",
                "uco-observable:metadataRecoverabilityStatus": "recovered",
                "uco-observable:contentRecoverabilityStatus": "unknown"
            }
        ]
    }
]
```

# SQLite Entry Recoverability

SQLite records that are recoverable can also be represented using the `observable:UnallocatedRecoverabilityFacet`. For example, this Facebook messenger chat:

![FacebookChat.png](https://files.caseontology.org/CASE-Examples/examples/illustrations/recoverability/FacebookChat.png)


This recovered chat message can be represented using the `observable:UnallocatedRecoverabilityFacet`, noting that the sent location does not appear to be recovered, indicating that the content is partially recovered.

```json
[
    {
        "@id": "kb:C01E67F9-ADB5-48BD-B09D-E7326FA8D592",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
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
                "@type": "uco-observable:UnallocatedRecoverabilityFacet",
                "uco-observable:nameRecoverabilityStatus": "recovered",
                "uco-observable:metadataRecoverabilityStatus": "recovered",
                "uco-observable:contentRecoverabilityStatus": "partially recovered"
            }
        ]
    }
]
```

