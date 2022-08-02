<!--
GENERATED FILE  README.md is generated from source files.  Edits to it will be overwritten by automated processes.:

If you need to edit its content, edit src/README.md.in, and then re-run `make` to re-build the file.
-->


# Recoverability Examples

*A file containing all of the JSON-LD content within this page is here: [`database_records.json`](database_records.json).*

*A file containing draft ontology concepts is here: [`drafting.ttl`](drafting.ttl).  It is expected to be removed with the completion of [UCO Issue 251](https://github.com/ucoProject/UCO/issues/415).*

There is a requirement to represent database records and the assocation between their values and identified forensic artifacts. This is primarily scoped to SQLite, but can be generalized to other relational database models.

The database file itself can be represented as a `uco-observable:File` object with associated facets.

```json
[
    {
        "@id": "kb:sqlite-file-1",
        "@type": "uco-observable:File",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "sqlite3",
                "uco-observable:fileName": "my-database",
                "uco-observable:filePath": "/path/to/my-database.sqlite3",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 123456,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-01T00:00:00Z"
                }
            }
        ]
    }
]
```


If there are supporting files such as WAL or Journal files as defined at [https://www.sqlite.org/tempfiles.html](https://www.sqlite.org/tempfiles.html), they can be related to the primary database file as well.

```json
[
    {
        "@id": "kb:sqlite-file-1",
        "@type": "uco-observable:File",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "sqlite3",
                "uco-observable:fileName": "my-database",
                "uco-observable:filePath": "/path/to/my-database.sqlite3",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 123456,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-01T00:00:00Z"
                }
            }
        ]
    },
    {
        "@id": "kb:sqlite-wal-file-1",
        "@type": "uco-observable:File",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "sqlite3-wal",
                "uco-observable:fileName": "my-database",
                "uco-observable:filePath": "/path/to/my-database.sqlite3-wal",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 12345,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-01T00:00:00Z"
                }
            }
        ]
    },
    {
        "@id": "kb:sqlite-wal-relationship-1",
        "@type": "uco-observable:ObservableRelationship",
        "uco-core:source": {
            "@id": "kb:sqlite-wal-file-1"
        },
        "uco-core:target": {
            "@id": "kb:sqlite-file-1"
        },
        "uco-core:kindOfRelationship": "Related_To",
        "uco-core:isDirectional": false
    },
    {
        "@id": "kb:sqlite-journal-file-1",
        "@type": "uco-observable:File",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "sqlite3-journal",
                "uco-observable:fileName": "my-database",
                "uco-observable:filePath": "/path/to/my-database.sqlite3-journal",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 12345,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-01T00:00:00Z"
                }
            }
        ]
    },
    {
        "@id": "kb:sqlite-journal-relationship-1",
        "@type": "uco-observable:ObservableRelationship",
        "uco-core:source": {
            "@id": "kb:sqlite-journal-file-1"
        },
        "uco-core:target": {
            "@id": "kb:sqlite-file-1"
        },
        "uco-core:kindOfRelationship": "Related_To",
        "uco-core:isDirectional": false
    }
]
```


The records within the database itself can be represented in newly proposed CASE objects as demonstrated below:

```json
[
    {
        "@id": "kb:sqlite-record-1",
        "@type": "drafting:DatabaseRecord",
        "uco-core:hasFacet": [
            {
                "@type": "drafting:DatabaseRecordFacet",
                "drafting:databaseTable": "messages",
                "drafting:databaseRowID": "12345",
                "drafting:databaseFieldName": "message_content",
                "drafting:databaseFieldValue": "Hello World"
            }
        ]
    },
    {
        "@id": "kb:sqlite-file-1",
        "@type": "uco-observable:File",
        "uco-core:hasFacet": [
            {
                "@type": "uco-observable:FileFacet",
                "uco-observable:extension": "sqlite3",
                "uco-observable:fileName": "my-database",
                "uco-observable:filePath": "/path/to/my-database.sqlite3",
                "uco-observable:isDirectory": false,
                "uco-observable:sizeInBytes": 123456,
                "uco-observable:createdTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-01T00:00:00Z"
                }
            }
        ]
    },
    {
        "@id": "kb:sqlite-record-relationship-1",
        "@type": "uco-observable:ObservableRelationship",
        "uco-core:source": {
            "@id": "kb:sqlite-record-1"
        },
        "uco-core:target": {
            "@id": "kb:sqlite-file-1"
        },
        "uco-core:kindOfRelationship": "Derived_From",
        "uco-core:isDirectional": true
    }
]
```



TODO - link to all
