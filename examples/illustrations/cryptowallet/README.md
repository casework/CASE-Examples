# Cryptowallet and Cryptoaddress Examples

This illustration includes example investigative questions involving cryptowallets and cryptoaddresses:

The proposed representation of cryptowallets:

```json
[
    {
        "@id": "kb:wallet-426a-0be4-db43-a66e-c43b6edc6b3a",
        "@type": "uco-observable:ObservableObject",
        "uco-core:hasFacet": [
            {
                "drafting:cryptoWalletIdentifier": "73108d1b19",
                "@type": "drafting:CryptoWalletFacet",
                "uco-core:cryptoWalletAddress": {
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

Case Example (Silk Road related address 127B3qwztPyA67uq63LG8G5izwhFcJ7j4A associated with Shaun Bridges)
Query Bitcoin (https://btc.com/btc/top-address).
Reference: https://www.google.com/url?q=http://www.kouett.net.eu.org/fci_refs/03/146/0/&sa=D&source=docs&ust=1649713536061842&usg=AOvVaw1-WxHD7En48B9KeEH6wiFz

Relationship between cryptoAddresses and the verified owner.

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

Another Case Example: Seizure of assets related to SilkRoad 1HQ3Go3ggs8pFnXuHVHRytPCq5fGG8Hbhx
Reference: https://storage.courtlistener.com/recap/gov.uscourts.cand.368440/gov.uscourts.cand.368440.1.0.pdf
