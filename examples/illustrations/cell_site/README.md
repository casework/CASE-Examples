<!--
GENERATED FILE

README.md is generated from a template file, src/README.md.in, and JSON snippets under src/.  If you need to revise narrative text, edit src/README.md.in.  If you need to revise data, please find and revise the containing snippet.  Editing patterns follow the patterns described in the CASE website's CONTRIBUTE.md:
https://github.com/casework/casework.github.io/blob/master/CONTRIBUTE.md#maintenance-of-generated-files
-->


# Cell site examples

This illustration includes example investigative questions that require cell site information, and sample JSON-LD of using the proposed `CellSiteFacet`, `AntennaFacet`, and `CapturedTelecommunicationsInformationFacet`.

The importance of standardizing representation of Cell Site information is evident from errors in processing location-based mobile device evidence that prompted Danish authorities to review over 10,000 cases ([Flaws in Cellphone Evidence Prompt Review of 10,000 Verdicts in Denmark, New York Times, 20 August 2019](https://www.nytimes.com/2019/08/20/world/europe/denmark-cellphone-data-courts.html)).


## Disclaimer

Participation by NIST in the creation of the documentation of mentioned software is not intended to imply a recommendation or endorsement by the National Institute of Standards and Technology, nor is it intended to imply that any specific software is necessarily the best available for the purpose.


## State of this Illustration

This illustration has been written in support of a Change Proposal under design and discussion, and hence may change in response to the proposal's evolution. New ontology concepts are in the file [drafting.ttl](drafting.ttl).

A total JSON-LD file of the data on this page, plus supplementary data needed to support queries, is available here: [JSON](cell_site.json).


## Example - Connected Cell Sites(s)

The primary requirement of this proposal is to represent data showing which cell site(s) a given mobile device connected to during a specific time period. This information addresses the question of what location area(s) the mobile device was near during a time of interest.

*Observations*: The following shows Cell Site information extracted using Cellebrite from the Samsung device in the shared [Crossover](https://caseontology.org/examples/crossover/) dataset, contained within the file `/root/data/com.google.android.gms/databases/herrevad`.

![Application screenshot](https://files.caseontology.org/CASE-Examples/examples/illustrations/cell_tower/Picture1.png)

Properties of the Cell Site represented in CASE using the proposed `CellSiteFacet`. The term Cell Site refers to a radio network component that has an antenna with associated properties.

```json
[
    {
        "@id": "kb:dc9b8413-f681-4bc6-a66e-b70a7ecde4d4",
        "@type": "drafting:CellSite",
        "uco-core:hasFacet": [
            {
                "@type": "drafting:CellSiteFacet",
                "drafting:cellSiteType": "GSM",
                "drafting:cellSiteCountryCode": "228",
                "drafting:cellSiteNetworkCode": "2",
                "drafting:cellSiteLocationAreaCode": "22100",
                "drafting:cellSiteIdentifier": "29220952"
            },
            {
                "@type": "drafting:AntennaFacet",
                "drafting:azimuth": {
                    "@type": "xsd:decimal",
                    "@value": "45"
                },
                "drafting:elevation": {
                    "@type": "xsd:decimal",
                    "@value": "5"
                },
                "drafting:skew": {
                    "@type": "xsd:decimal",
                    "@value": "10"
                },
                "drafting:horizontalBeamWidth": {
                    "@type": "xsd:decimal",
                    "@value": "110"
                },
                "drafting:signalStrength": {
                    "@type": "xsd:decimal",
                    "@value": "20"
                },
                "drafting:antennaHeight": {
                    "@type": "xsd:decimal",
                    "@value": "25"
                }
            }
        ]
    }
]
```

The location of a Cell Site can change over time when it is moved by a telecommunication provider. Therefore, the location is represented using a `Location` object and a `Relationship` object, which can be time bounded:

```json
[
    {
        "@id": "kb:f2e90997-16c9-4822-be30-fa4f36553768",
        "@type": "uco-location:Location",
        "uco-core:hasFacet": [
            {
                "@type": "uco-location:LatLongCoordinatesFacet",
                "uco-location:latitude": {
                    "@type": "xsd:decimal",
                    "@value": "46.522316"
                },
                "uco-location:longitude": {
                    "@type": "xsd:decimal",
                    "@value": "6.566640"
                }
            }
        ]
    },
    {
        "@id": "kb:cdf48c35-c65d-41e4-843b-720f1ad24ab3",
        "@type": "uco-observable:ObservableRelationship",
        "uco-observable:startTime": {
            "@type": "xsd:dateTime",
            "@value": "2016-12-12T09:10:11Z"
        },
        "uco-observable:endTime": {
            "@type": "xsd:dateTime",
            "@value": "2018-06-10T15:36:39Z"
        },
        "uco-core:source": {
            "@id": "kb:dc9b8413-f681-4bc6-a66e-b70a7ecde4d4"
        },
        "uco-core:target": {
            "@id": "kb:f2e90997-16c9-4822-be30-fa4f36553768"
        },
        "uco-core:kindOfRelationship": "Located_At",
        "uco-core:isDirectional": true
    }
]
```


### Query - To which Cell Sites did the Mobile Device connect

To answer the question "To which Cell Site(s) did a given mobile device connect during the period of interest, and at what time(s)?" In this example, the result is the connected Cell Site(s) during the specified time period.

A SPARQL query can be written as:
```sparql
SELECT DISTINCT ?lCellSiteIdentifier ?lCellSiteLocationAreaCode ?lConnectionStartTime ?lConnectionEndTime
WHERE
{
  ?nConnectedRelationship
    a uco-observable:ObservableRelationship ;
    uco-core:source kb:3fef85a7-3fb4-4170-ba4d-fc69e2de4789 ;
    uco-core:target ?nCellSite ;
    uco-core:kindOfRelationship "Connected_To"
    .
    OPTIONAL {
      ?nConnectedRelationship uco-observable:startTime ?lConnectionStartTime .
    }
    OPTIONAL {
      ?nConnectedRelationship uco-observable:endTime ?lConnectionEndTime .
    }

  ?nCellSite
    a drafting:CellSite ;
    uco-core:hasFacet ?nCellSiteFacet ;
    .

  ?nCellSiteFacet
    a drafting:CellSiteFacet ;
    .
    OPTIONAL {
      ?nCellSiteFacet drafting:cellSiteIdentifier ?lCellSiteIdentifier .
    }
    OPTIONAL {
      ?nCellSiteFacet drafting:cellSiteLocationAreaCode ?lCellSiteLocationAreaCode .
    }
}
```

Note this query is tailored to `kb:3fef85a7-3fb4-4170-ba4d-fc69e2de4789`, by hard-coding as the object of `uco-core:source`.  The results of this query are:

|    |   ?lCellSiteIdentifier |   ?lCellSiteLocationAreaCode | ?lConnectionStartTime     | ?lConnectionEndTime       |
|----|------------------------|------------------------------|---------------------------|---------------------------|
|  0 |               29220952 |                        22100 | 2018-06-10 15:36:12+00:00 | 2018-06-10 15:36:39+00:00 |

Information represented using the `CellSiteFacet` provides the location of the Cell Site, not the specific location of the connected mobile device. However, this information is necessary for cell site analysts to form an opinion about where the mobile device was most likely located during a time of interest ([Structuring the Evaluation of Location-Related Mobile Device Evidence, DFRWS EU 2020](https://doi.org/10.1016/j.fsidi.2020.300928)).

Mistakes in analysing Cell Site information can result from incorrect location or cell identification information, as well as misinterpreted timestamps (e.g., incorrect timezone).

Cell Site information can also be used to determine which mobile devices were connected to a given Cell Site during a specific time period. This information answers the question of what devices were near a location of interest during a period of interest.


## Example - Captured Cell Site Information

Cell Site information can also be obtained from Call Detail Records (CDR) and wiretap data captured by telecommunication providers (specified by ETSI TS 102 232-5).

*Observations*: The following shows a subset of data that telecommunication providers captured from a Cell Site.

```
generalizedTime: 2017-11-22 09:32:41.590
imei TAC-SNR: 35643505-109247
msISDN address: 31642721nnn
Calling Party Number: 31642721nnn
Called Party Number: 0620623nnn
intercepted-Call-State: (e.g. idle)
userLocationInfo: 1802f440546e02f4400188130b
epsHI2Ops-gsmlocation-latitude: N520225.98
epsHI2Ops-gsmlocation-longitude: E0042133.98
epsHI2Ops-globalCellID: 02f46103f63457
Mobile Country Code (MCC): Netherlands (204)
Mobile Network Code (MNC): T-Mobile Netherlands B.V. (16)
Cell LAC: 0x03f6 (1014)
Cell CI: 0x3457 (13399)
azimuth: 60
```

The proposed `CapturedTelecommunicationsInformationFacet` represents the subset of information that is most commonly useful for cyber-investigations:

```json
[
    {
        "@id": "kb:9dcd8413-f681-4bc6-a66e-b70a7ecd3e4a",
        "@type": "drafting:CapturedTelecommunicationsInformation",
        "uco-core:hasFacet": [
            {
                "@type": "drafting:CapturedTelecommunicationsInformationFacet",
                "drafting:captureCellSite": {
                    "@id": "urn:example:cell-site-kb:cell-cite-204-16-1014-13399"
                },
                "observable:startTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2021-07-29T01:23:02Z"
                },
                "observable:endTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2021-07-30T02:10:50Z"
                },
                "drafting:interceptedCallState": "idle"
            }
        ]
    }
]
```

(The object referenced in `captureCellSite` is described under "Location review" below.)

This captured telecommunication information can also answer questions about the activities on a given device during the connection with a Cell Site, including details about the connected device identifier, SIM card identifier, mobile phone number, called phone number, call status, and SMS message text. These details are already covered by other CASE/UCO facets.


### Location review

Of data available from OpenCellID.org[^1], as accessed on 2022-05-27, this record most closely corresponds to the cell site described in the above `CapturedTelecommunicationsInformation`:

| radio | mcc | net | area | cell | unit | lon | lat | range | samples | changeable | created | updated | averageSignal |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GSM | 204 | 16 | 1014 | 13399 | 0 | 4.357681 | 52.039261 | 1000 | 3 | 1 | 1470196482 | 1487008296 | 0 |

From commentary in a [forum post](https://community.opencellid.org/t/documenting-the-columns-in-the-downloadable-cells-database-csv/186/25), "Unique cell identifiers consists of four parts: Mobile Country Code (MCC), Mobile Network Code (MNC), Location Area Code (LAC/ area) and Cell Identification (CI/cellID)."  An example organization chooses to use this information to populate a knowledge base of cell site objects[^2], so they may be reused across multiple `CapturedTelecommunicationsInformation` objects.

```json
[
    {
        "@id": "urn:example:cell-site-kb:cell-cite-204-16-1014-13399",
        "@type": "drafting:CellSite",
        "uco-core:hasFacet": [
            {
                "@type": "drafting:CellSiteFacet",
                "drafting:cellSiteType": "GSM",
                "drafting:cellSiteCountryCode": "204",
                "drafting:cellSiteNetworkCode": "16",
                "drafting:cellSiteLocationAreaCode": "1014",
                "drafting:cellSiteIdentifier": "13399"
            }
        ]
    }
]
```

This example organization chooses a process to associate the OpenCellID recorded location with this cell site.  The record includes a record creation and record update timestamp, which together form a two-member set of times the site was observed.

For both of those times, a `sosa:Observation` object is constructed, to represent that the cell site was observed as a feature of interest at both of those times.  The property[^3] observed was its location.

The result at the time of the record's creation is not known from the current data set (but might be known if the older versions of the data were reviewed), but the result of the update time is in that CSV record, and is linked using `sosa:hasResult`.

Per practice of this example organization, the derivation of the relationship is recorded with `case-investigation:wasDerivedFrom`.  They also record no time bounds on the `ObservableRelationship`, because the source `sosa:Observation` is only believed to have taken place at a single point during the time the relationship existed.

```json
[
    {
        "@id": "kb:observation-009101f6-ba93-4a3d-acb0-455102b5b1e1",
        "@type": [
            "uco-core:UcoObject",
            "sosa:Observation"
        ],
        "uco-core:objectCreatedTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-27T15:30:42Z"
        },
        "sosa:hasFeatureOfInterest": {
            "@id": "urn:example:cell-site-kb:cell-cite-204-16-1014-13399"
        },
        "sosa:resultTime": {
            "@type": "xsd:dateTime",
            "@value": "2016-08-02T23:54:42Z"
        }
    },
    {
        "@id": "kb:observation-21841f2a-6c14-48d7-b9d3-f081d43bc19b",
        "@type": [
            "uco-core:UcoObject",
            "sosa:Observation"
        ],
        "uco-core:objectCreatedTime": {
            "@type": "xsd:dateTime",
            "@value": "2022-05-27T15:30:42Z"
        },
        "sosa:hasFeatureOfInterest": {
            "@id": "urn:example:cell-site-kb:cell-cite-204-16-1014-13399"
        },
        "sosa:hasResult": {
            "@id": "kb:location-403d0147-f7ff-4f3e-aa43-19a988e8a3ee"
        },
        "sosa:resultTime": {
            "@type": "xsd:dateTime",
            "@value": "2017-02-13T12:51:36Z"
        }
    },
    {
        "@id": "kb:location-403d0147-f7ff-4f3e-aa43-19a988e8a3ee",
        "@type": "uco-location:Location",
        "uco-core:description": "Location of cell site, denoted by opencellid.org",
        "uco-core:hasFacet": [
            {
                "@type": "uco-location:LatLongCoordinatesFacet",
                "uco-location:latitude": {
                    "@type": "xsd:decimal",
                    "@value": "52.039261"
                },
                "uco-location:longitude": {
                    "@type": "xsd:decimal",
                    "@value": "4.357681"
                }
            }
        ]
    },
    {
        "@id": "kb:relationship-7cb73eaa-f2e5-45c1-b84e-0e97d0a828d4",
        "@type": "uco-observable:ObservableRelationship",
        "case-investigation:wasDerivedFrom": {
            "@id": "kb:observation-21841f2a-6c14-48d7-b9d3-f081d43bc19b"
        },
        "uco-core:source": {
            "@id": "urn:example:cell-site-kb:cell-cite-204-16-1014-13399"
        },
        "uco-core:target": {
            "@id": "kb:location-403d0147-f7ff-4f3e-aa43-19a988e8a3ee"
        },
        "uco-core:kindOfRelationship": "Located_At",
        "uco-core:isDirectional": true
    }
]
```

[^1]: <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://opencellid.org/images/ccbysa_4.0_80x15.png" /></a> <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title"><a xmlns:cc="https://creativecommons.org/ns#" href="https://opencellid.org" property="cc:attributionName" rel="cc:attributionURL">OpenCelliD Project</span></a> is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/" target='_blank'>Creative Commons Attribution-ShareAlike 4.0 International License</a>.
[^2]: The example organization has not discussed policy on how to handle matters such as cell sites being retired from service.  Such a policy would be necessary to process that no record is currently found with `cellSiteIdentifier` value `29220952` within their data source.  This is a practice that would be better explored by interested investigative community members.
[^3]: SOSA defines that a `sosa:Observation` uniquely has one `Property` that is the subject of the measurement.  As OWL ontology data, that property does not necessarily need to be recorded.  By leaving the property absent, we still express that the feature of interest, the cell site, was observed; we just do not say what about it we were observing.  "The property that expresses the location of this object" is not something for which CASE or UCO yet has a clear representation practice, so we omit it in this example.
