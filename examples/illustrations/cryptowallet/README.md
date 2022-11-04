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
        "@id": "kb:cryptoaddress-fc4ec649-9fe9-4b7a-acbc-0d453d35336f",
        "@type": "drafting:CryptoAddress",
        "uco-core:hasFacet": [
            {
                "@id": "kb:crypto-address-facet-744448c8-ea85-4bb6-bfa2-dad437f71fd5",
                "@type": "drafting:CryptoAddressFacet",
                "drafting:addressValue": "1HQ3Go3ggs8pFnXuHVHRytPCq5fGG8Hbhx",
                "drafting:cryptoCurrencyType": "BitCoin",
                "drafting:cryptoAddressFormat": "P2PKH",
                "drafting:cryptoAddressCreatedTime": {
                    "@type": "xsd:dateTime",
                    "@value": "2013-04-09T17:03:36Z"
                },
                "rdfs:comment": "TODO - Turn cryptoCurrencyCompletedTransactionCount of 260 into measurement"
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
* The account has four [observable properties](https://www.w3.org/TR/vocab-ssn/#SOSAObservableProperty) (among others) we are interested in measuring:
    - the transaction count
    - the balance
    - the total amount of cryptocurrency received
    - the total amount of cryptocurrency sent
* Those observable properties can be observed either by a passive mean or active mean.
    - A passive mean could be reviewing a blockchain summarization, as was done above by reviewing two websites.  These would yield `sosa:Observation` objects.
    - An active mean could be by transacting with the address, updating the address's values.  In SOSA terms, this would be an [actuation](sosa:Actuation).  Because an actuation is also tied to one observable property, a blockchain transaction enacts one actuation per property.

One of the behaviors of block chains is their transactions tend to both be publicly listed, and include account balances.  This is true for Bitcoin transactions once added to the public ledger.  Hence, each transaction in this example serves as both passive and active measurement instruments.

A representation of the account balance being 0.00069789 BTC at the above-noted time would be as follows.  Note that this representation is scoped to only using concepts from the SSN, SOSA, and QUDT namespaces, plus the extension to QUDT that adds BTC as an instance of `qudt:CurrencyUnit` (or rather, an instance of a subclass of `qudt:CurrencyUnit`, `drafting:CryptoCurrencyUnit`).

Whether the result of an observation or transaction (or actuation), the result includes a QUDT `QuantityValue` representing the balance in Bitcoin.  This `qudt:QuantityValue` will be associated with the `sosa:Observation`.

```json
[
    {
        "@id": "kb:result-3ce85104-af5f-42af-8e0a-e0763fdb0dc5",
        "@type": "qudt:QuantityValue",
        "qudt:numericValue": {
            "@type": "xsd:decimal",
            "@value": "0.00069789"
        },
        "qudt:unit": {
            "@id": "drafting-taxonomy:BTC"
        }
    }
]
```

Both the observation and actuation link the result with `sosa:hasResult`, also tying in the [property being observed](https://www.w3.org/TR/vocab-ssn/#SOSAobservedProperty), and the ["sensor"](https://www.w3.org/TR/vocab-ssn/#SOSASensor) (for observations) or actuator (for actuations).  The transaction serves as both sensor and actuator.

This snippet shows the transaction enacting a `sosa:Observation`:

```json
[
    {
        "@id": "kb:transaction-cb296982-e0c7-47b5-9bea-334a0e32cb7c",
        "@type": "sosa:Sensor",
        "sosa:madeObservation": {
            "@id": "kb:observation-81129ccd-14c5-4686-b632-a0bd0d66fa17"
        }
    },
    {
        "@id": "kb:balance-86c3d313-b95c-4a16-b6b5-d737efb82218",
        "@type": "sosa:ObservableProperty"
    },
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
            "@id": "kb:balance-86c3d313-b95c-4a16-b6b5-d737efb82218"
        },
        "sosa:resultTime": {
            "@type": "xsd:dateTimeStamp",
            "@value": "2016-01-19T15:45:17Z"
        }
    }
]
```

This snippet shows the transaction enacting a `sosa:Actuation`:

```json
[
    {
        "@id": "kb:transaction-cb296982-e0c7-47b5-9bea-334a0e32cb7c",
        "@type": "sosa:Actuator",
        "sosa:madeActuation": {
            "@id": "kb:actuation-69144892-bacf-466e-9f06-5e05e55a1e09"
        }
    },
    {
        "@id": "kb:balance-86c3d313-b95c-4a16-b6b5-d737efb82218",
        "@type": "sosa:ActuatableProperty"
    },
    {
        "@id": "kb:actuation-69144892-bacf-466e-9f06-5e05e55a1e09",
        "@type": "sosa:Actuation",
        "sosa:actsOnProperty": {
            "@id": "kb:balance-86c3d313-b95c-4a16-b6b5-d737efb82218"
        },
        "sosa:hasResult": {
            "@id": "kb:result-3ce85104-af5f-42af-8e0a-e0763fdb0dc5"
        },
        "sosa:madeByActuator": {
            "@id": "kb:transaction-cb296982-e0c7-47b5-9bea-334a0e32cb7c"
        },
        "sosa:resultTime": {
            "@type": "xsd:dateTimeStamp",
            "@value": "2016-01-19T15:45:17Z"
        }
    }
]
```

The property being observed is the wallet's balance.  In SSN, the minimum type declarations needed to link the wallet balance to the `drafting:CryptoWallet` are as follows:

```json
[
    {
        "@id": "kb:cryptoaddress-fc4ec649-9fe9-4b7a-acbc-0d453d35336f",
        "@type": "sosa:FeatureOfInterest",
        "ssn:hasProperty": {
            "@id": "kb:balance-86c3d313-b95c-4a16-b6b5-d737efb82218"
        }
    }
]
```

Altogether, the above render of a cryptowallet and transaction enable this view of the history of balances of this wallet:

|    | ?lAddressValue                     | ?lTransactionEndTime   |   ?lNumericValue | ?lUnitLabel   |
|----|------------------------------------|------------------------|------------------|---------------|
|  0 | 1HQ3Go3ggs8pFnXuHVHRytPCq5fGG8Hbhx | 2016-01-19T15:45:17Z   |       0.00069789 | BTC           |

An example of cryptowallet and cryptoaddress related to the investigation of the Silk Road marketplace and the BitCoin address 127B3qwztPyA67uq63LG8G5izwhFcJ7j4A associated with Shaun Bridges.
Reference: https://btc.com/btc/search/127B3qwztPyA67uq63LG8G5izwhFcJ7j4A:

```json
[
    {
        "@id": "kb:wallet-ae926768-b80e-4fbd-81c0-fa43508334c2",
        "@type": "drafting:CryptoWallet",
        "uco-core:hasFacet": [
            {
                "@id": "kb:crypto-wallet-facet-e2628662-84fb-427a-8657-3d5d98ce4c6c",
                "@type": "drafting:CryptoWalletFacet",
                "drafting:cryptoWalletAddress": {
                    "@id": "kb:cryptoaddress-e3b9060e-c01a-4794-ad88-82f6fd733b30"
                },
                "drafting:cryptoWalletIdentifier": "73108d1b19",
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

