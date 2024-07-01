<!-- Look for TODOs. -->

# Existence Intervals

This example demonstrates various ontologies' representations of the period of time in which a thing exists.  Some effort is put into describing differences in representing the existence of endurants vs. perdurants.

Take as an example a thing---and the thing might be endurant, perdurant, physical, cyber, thought, event, etc.---that exists starting at a time `t0` and ceases to exist at a time `t1`.  In the illustrations below, the start will be labeled `t0`, the end `t1`, the interval bounded by start and end `i`, the thing `t`.

The starting time of this thing is `2020-01-02T03:04:05.6789Z`.  The ending time of this thing is `2021-02-03T04:05:06.7890Z`.  Each illustration goes as far as it can with concepts in the referenced ontology to eventually tie the thing `t` to these timestamp-literals.  Where available, reified "instant" objects will be favored over literal-valued properties.

![Abstraction - all](figures/abstraction_all.svg)

This suggests a mapping table:

| Example class or triple | Corresponding class or triple |
| --- | --- |
| `ex:TimeBoundedThing` | ... |
| `ex:ExistenceInterval` | ... |
| `ex:Instant` | ... |
| `kb:T ex:hasExistenceInterval kb:E` | ... |
| `kb:T ex:existsAtAndSince kb:T0` | ... |
| `kb:T ex:existsUntil kb:T1` | ... |
| `kb:T ex:hasCreationTimestamp "2020-..."^^xsd:dateTime` | ... |
| `kb:T ex:hasTerminationTimestamp "2021-..."^^xsd:dateTime` | ... |
| `kb:E ex:hasStart kb:T0` | ... |
| `kb:E ex:hasEnd kb:T1` | ... |
| `kb:E ex:hasBeginningTimestamp "2020-..."^^xsd:dateTime` | ... |
| `kb:E ex:hasEndingTimestamp "2021-..."^^xsd:dateTime` | ... |
| `kb:T0 ex:hasTimestamp "2020-..."^^xsd:dateTime` | ... |
| `kb:T1 ex:hasTimestamp "2021-..."^^xsd:dateTime` | ... |

The mapping table is filled in for the various ontologies below with:

* Corresponding statements (class IRIs or full triples);
* "N/A", for not-**available** when a concept is known to not be mappable now, typically because no corresponding class or property is currently defined; and
* "TBD", when a design decision can be taken, typically because of a potential class- or property-equality declaration.

Note that "N/A" does not mean that a mapping is not possible.  It only means that classes and properties are not defined at the present moment.

<!--
TODO - Also review whether each ontology states, or otherwise constrains, that an existence interval is unique.  E.g. denote whether an object can recur, such as with some models of relationships.
-->


## UCO 1.3.0

UCO declares two property-pairs setting time boundaries:

* `core:startTime` and `core:endTime`, used to bound `core:Event`s and `core:Relationship`s.
* `action:startTime` and `action:endTime`, used to bound `action:Action`s.

The following table shows the time coverage for the three UCO classes that currently encode constraints on time properties:

| UCO Class | Figure |
| --- | --- |
| `uco-action:Action` | ![Abstraction - UCO Action](figures/abstraction_uco_1_3_0_action.svg) |
| `uco-core:Event` | ![Abstraction - UCO Event](figures/abstraction_uco_1_3_0_event.svg) |
| `uco-core:Relationship` | ![Abstraction - UCO Relationship](figures/abstraction_uco_1_3_0_relationship.svg) |

The mapping for `uco-action:Action` would be as follows.

| Example class or triple | Corresponding class or triple |
| --- | --- |
| `ex:TimeBoundedThing` | `uco-action:Action` |
| `ex:ExistenceInterval` | TBD |
| `ex:Instant` | N/A |
| `kb:T ex:hasExistenceInterval kb:E` | TBD |
| `kb:T ex:existsAtAndSince kb:T0` | N/A |
| `kb:T ex:existsUntil kb:T1` | N/A |
| `kb:T ex:hasCreationTimestamp "2020-..."^^xsd:dateTime` | `kb:T uco-action:startTime "2020-..."^^xsd:dateTime` |
| `kb:T ex:hasTerminationTimestamp "2021-..."^^xsd:dateTime` | `kb:T uco-action:endTime "2021-..."^^xsd:dateTime` |
| `kb:E ex:hasStart kb:T0` | N/A |
| `kb:E ex:hasEnd kb:T1` | N/A |
| `kb:E ex:hasBeginningTimestamp "2020-..."^^xsd:dateTime` | TBD |
| `kb:E ex:hasEndingTimestamp "2021-..."^^xsd:dateTime` | TBD |
| `kb:T0 ex:hasTimestamp "2020-..."^^xsd:dateTime` | N/A |
| `kb:T1 ex:hasTimestamp "2021-..."^^xsd:dateTime` | N/A |

`uco-core:Event` and `uco-core:Relationship` will look similar.

The "TBD"s above pertain to a decision UCO can make on how endurants and perdurants relate to time, under discussion [UCO Issue 544](https://github.com/ucoProject/UCO/issues/544).


## OWL-Time

OWL-Time provides the class `time:TemporalEntity`.  Guidance offers options on how to relate time-things (`time:TemporalEntity`) to things that exist in time (like an activity or an object), drawn from [Section 3.1](https://www.w3.org/TR/owl-time/#topology).

> The properties `:hasTemporalDuration`, `:hasBeginning` and `:hasEnd`, together with a fourth generic property `:hasTime`, support the association of temporal information with any temporal entity, such as an activity or event, or other entity. These provide a standard way to attach time information to things, which may be used directly in applications if suitable, or specialized if needed.

The following figure shows the time coverage for the general usage of `time:TemporalEntity`:

![Abstraction - OWL-Time Temporal Entity](figures/abstraction_time.svg)

The mapping for `time:TemporalEntity` would be as follows.

| Example class or triple | Corresponding class or triple |
| --- | --- |
| `ex:TimeBoundedThing` | `owl:Thing` |
| `ex:ExistenceInterval` | `time:TemporalEntity` |
| `ex:Instant` | `time:Instant` |
| `kb:T ex:hasExistenceInterval kb:E` | `kb:T time:hasTime kb:E` |
| `kb:T ex:existsAtAndSince kb:T0` | N/A |
| `kb:T ex:existsUntil kb:T1` | N/A |
| `kb:T ex:hasCreationTimestamp "2020-..."^^xsd:dateTime` | N/A |
| `kb:T ex:hasTerminationTimestamp "2021-..."^^xsd:dateTime` | N/A |
| `kb:E ex:hasStart kb:T0` | `kb:E time:hasBeginning kb:T0` |
| `kb:E ex:hasEnd kb:T1` | `kb:E time:hasEnd kb:T1` |
| `kb:E ex:hasBeginningTimestamp "2020-..."^^xsd:dateTime` | N/A |
| `kb:E ex:hasEndingTimestamp "2021-..."^^xsd:dateTime` | N/A |
| `kb:T0 ex:hasTimestamp "2020-..."^^xsd:dateTime` | `kb:T0 time:inXSDDateTime "2020-..."^^xsd:dateTime` |
| `kb:T1 ex:hasTimestamp "2021-..."^^xsd:dateTime` | `kb:T1 time:inXSDDateTime "2021-..."^^xsd:dateTime` |

Some of the examples in the OWL-TIME specification include demonstrations of `time:TemporalEntity` that allow for endurants and perdurants as direct subclasses.  Note that the examples section is non-normative.

* [5.4, "iCalendar"](https://www.w3.org/TR/owl-time/#iCal) instantiates the endurant "Abraham Lincoln" (node `_:TE-2`).
* [5.6, "A Use Case for Scheduling"](https://www.w3.org/TR/owl-time/#scheduling) instantiates perdurants some teleconference and some meeting (nodes `ex:telecon` and `ex:meeting`, respectively).
* [5.7, "Alignment of PROV-O with OWL-Time"](https://www.w3.org/TR/owl-time/#time-prov) states that `prov:Activity` and `prov:InstantaneousEvent` can be subclasses of `time:TemporalEntity` and `time:Instant`, respectively.
