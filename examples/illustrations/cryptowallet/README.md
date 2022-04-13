<!--
GENERATED FILE

README.md is generated from a template file, src/README.md.in, and JSON snippets under src/.  If you need to revise narrative text, edit src/README.md.in.  If you need to revise data, please find and revise the containing snippet.  Editing patterns follow the patterns described in the CASE website's CONTRIBUTE.md:
https://github.com/casework/casework.github.io/blob/master/CONTRIBUTE.md#maintenance-of-generated-files
-->


# Cryptowallet and Cryptoaddress Examples

This illustration includes example investigative questions involving cryptowallets and cryptoaddresses.


## Disclaimer

Participation by NIST in the creation of the documentation of mentioned software is not intended to imply a recommendation or endorsement by the National Institute of Standards and Technology, nor is it intended to imply that any specific software is necessarily the best available for the purpose.


## Example representations

The proposed representation of cryptoaddress is illustrated using the seizure of assets from BitCoin address `1HQ3Go3ggs8pFnXuHVHRytPCq5fGG8Hbhx` related to the Silk Road marketplace.

The seizure is documented here:

* [https://www.justice.gov/usao-ndca/press-release/file/1334771/download](https://www.justice.gov/usao-ndca/press-release/file/1334771/download)
   - Alternatively available here: [https://storage.courtlistener.com/recap/gov.uscourts.cand.368440/gov.uscourts.cand.368440.1.0.pdf](https://storage.courtlistener.com/recap/gov.uscourts.cand.368440/gov.uscourts.cand.368440.1.0.pdf)

```json
[
    {
        "@id": "kb:fc4ec649-9fe9-4b7a-acbc-0d453d35336f",
        "@type": "drafting:CryptoAddress",
        "uco-core:hasFacet": [
            {
                "@type": "drafting:CryptoAddressFacet",
                "drafting:addressValue": "1HQ3Go3ggs8pFnXuHVHRytPCq5fGG8Hbhx",
                "drafting:cryptoCurrencyType": "BitCoin",
                "drafting:cryptoAddressFormat": "P2PKH",
                "drafting:cryptoAddressCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2013-04-09T17:03:36Z"
                },
                "drafting:cryptoCurrencyCompletedTransactionCount": "260",
                "drafting:cryptoCurrencyBalance": {
                    "@id": "kb:cryptocurrency-sent-9301548a-a60e-41a8-8cb6-27a748639850"
                }
            }
        ]
    }
]
```

Observations of that address from two sources yield certain measurements of the account associated with that address, including the count of transactions and the balance in Bitcoin and/or other denominations.

Two address summary pages are here:

* [https://www.blockchain.com/btc/address/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A](https://www.blockchain.com/btc/address/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A)
* [https://btc.com/btc/address/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A](https://btc.com/btc/address/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A)

At `Wed Apr 13 12:02:13 EDT 2022`, these were the transaction-count and balance, according to the above two presentations of the Bitcoin blockchain:

* 37 transactions
* 0.00069789 BTC


### Representation of address measurements

Certain properties of a cryptowallet are frequently-changing features, such as its transaction count or balance.  The [Semantic Sensor Network (SSN) Ontology](https://www.w3.org/TR/vocab-ssn) provides a vocabulary for measuring *features of interest*.  See [Section 7.3, Quantity Values and Units of Measure](https://www.w3.org/TR/vocab-ssn/#quantity-values-and-unit-of-measures), and/or the ["Apartment 134"](https://www.w3.org/TR/vocab-ssn/#apartment-134) example for full demonstration of measurement.

Applying SSN to the Bitcoin address, we assign these class and property descriptions:

* The Bitcoin account, i.e. `drafting:CryptoWallet` is the [feature of interest](https://www.w3.org/TR/vocab-ssn/#SOSAFeatureOfInterest).
* The account has two [observable properties](https://www.w3.org/TR/vocab-ssn/#SOSAObservableProperty) (among others) we are interested in measuring - the transaction count, and the balance.

A representation of the account balance being 0.00069789 BTC at the above-noted time would be as follows.  Note that this representation is scoped to only using concepts from the SSN, SOSA, and QUDT namespaces, plus the extension to QUDT of BTC as a subclass (transitively so) of `qudt:CurrencyUnit`.

The result of the observation is a QUDT `QuantityValue` representing the balance in Bitcoin.

```json
[
    {
        "@id": "kb:result-3ce85104-af5f-42af-8e0a-e0763fdb0dc5",
        "@type": "qudt:QuantityValue",
        "qudt:numericValue": {
            "@type": "xsd:decimal",
            "@value": "0.00069789"
        },
        "qudt:unit": "drafting-taxonomy:BTC"
    }
]
```

The observation links the result with `sosa:hasResult`, also linking the ["sensor"](https://www.w3.org/TR/vocab-ssn/#SOSASensor) that made the result with the [property being observed](https://www.w3.org/TR/vocab-ssn/#SOSAobservedProperty).

```json
[
    {
        "@id": "kb:observation-81129ccd-14c5-4686-b632-a0bd0d66fa17",
        "@type": "sosa:Observation",
        "sosa:hasResult": {
            "@id": "kb:result-3ce85104-af5f-42af-8e0a-e0763fdb0dc5"
        },
        "sosa:madeBySensor": {
            "@id": "kb:transaction-cb296982-e0c7-47b5-9bea-334a0e32cb7c"
        },
        "sosa:observedProperty": {
            "@id": "kb:observable-property-86c3d313-b95c-4a16-b6b5-d737efb82218"
        },
        "sosa:resultTime": {
            "@type": "xsd:dateTimeStamp",
            "@value": "2022-04-13T12:02:13-05:00"
        }
    }
]
```

The property being observed is the wallet's balance.  In SSN, the minimum type declarations needed to link the wallet balance to the `drafting:CryptoWallet` are as follows:

```json
[
    {
        "@id": "kb:fc4ec649-9fe9-4b7a-acbc-0d453d35336f",
        "@type": "sosa:FeatureOfInterest",
        "ssn:hasProperty": {
            "@id": "kb:observable-property-86c3d313-b95c-4a16-b6b5-d737efb82218"
        }
    },
    {
        "@id": "kb:observable-property-86c3d313-b95c-4a16-b6b5-d737efb82218",
        "@type": "sosa:ObservableProperty"
    }
]
```

An example of cryptowallet and cryptoaddress related to the investigation of the Silk Road marketplace and the BitCoin address 127B3qwztPyA67uq63LG8G5izwhFcJ7j4A associated with Shaun Bridges.
Reference: https://btc.com/btc/search/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A:

```json
[
    {
        "@id": "kb:wallet-426a-0be4-db43-a66e-c43b6edc6b3a",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "drafting:cryptoWalletIdentifier": "73108d1b19",
                "@type": "drafting:CryptoWalletFacet",
                "drafting:cryptoWalletAddress": {
                    "@id": "kb:cryptoaddress-9de3-a681-db43-a66e-b70a7ecc4a2e"
                },
                "drafting:cryptoWalletName": "Jane Doe",
                "drafting:cryptoWalletCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2022-01-25T18:37:52Z"
                }
            }
        ]
    }
]
```


The relationship between cryptoAddresses and the verified owner can be represented as follows:

```json
       {
            "@id": "kb:cryptoaddress-ownedby-relationship-uuid",
            "@type": "uco-core:Relationship",
            "uco-core:source": {
                "@id": "kb:cryptoAddress1-uuid"
            },
            "uco-core:target": {
                "@id": "kb:ShaunBridgesIdentity-uuid"
            },
            "uco-core:kindOfRelationship": "Owned_By",
            "uco-core:isDirectional": true
        },
```

