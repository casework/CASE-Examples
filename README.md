# CASE Examples

This repository holds example data illustrating usage of the Cyber-investigation Analysis Standard Expression (CASE) language.

Further illustration can be found at the [CASE narratives gallery](https://caseontology.org/examples/).


## Illustrations in this repository

Mapping notes & respective JSON-LD output:

- [Accounts](examples/illustrations/accounts/accounts.json) ([*info*](examples/illustrations/accounts/))
- [Analysis](examples/illustrations/analysis/analysis.json) ([*info*](examples/illustrations/analysis/))
- [Bulk Extractor Forensic Path](examples/illustrations/bulk_extractor_forensic_path/bulk_extractor_forensic_path.json) (*[info](examples/illustrations/bulk_extractor_forensic_path/)*)
- [Call Log](examples/illustrations/call_log/call_log.json)
- [Cell Site](examples/illustrations/cell_site/cell_site.json) ([*info*](examples/illustrations/cell_site/))
- [Configured Tool](examples/illustrations/configured_tool/configured_tool.json)
- [Database records](examples/illustrations/database_records/database_records.json) ([*info*](examples/illustrations/database_records/))
- [Device](examples/illustrations/device/device.json)
- [EXIF Data](examples/illustrations/exif_data/exif_data.json)
- [Event](examples/illustrations/event/event.json)
- [Existence intervals](examples/illustrations/existence_intervals/existence_intervals.json) ([*info*](examples/illustrations/existence_intervals/README.md))
- [Files](examples/illustrations/file/file.json) (*[info](examples/illustrations/file/)*)
- [Forensic Lifecycle](examples/illustrations/forensic_lifecycle/forensic_lifecycle.json) ([*info*](examples/illustrations/forensic_lifecycle/))
- [Location](examples/illustrations/location/location.json)
- [Message](examples/illustrations/message/message.json) ([*info*](examples/illustrations/message/))
- [Mobile device and SIM card](examples/illustrations/mobile_device_and_sim_card/mobile_device_and_sim_card.json) ([*info*](examples/illustrations/mobile_device_and_sim_card/))
- [Multipart File](examples/illustrations/multipart_file/multipart_file.json) (*[info](examples/illustrations/multipart_file/)*)
- [Network connection](examples/illustrations/network_connection/network_connection.json) (*[info](examples/illustrations/network_connection/)*)
- [Oresteia](examples/illustrations/Oresteia/Oresteia.json) (*[info](examples/illustrations/Oresteia/)*)
- [Partitions](examples/illustrations/partitions/partitions.json) (*[info](examples/illustrations/partitions/)*)
- [Raw Data](examples/illustrations/raw_data/raw_data.json) (*[info](examples/illustrations/raw_data/)*)
- [Reconstructed File](examples/illustrations/reconstructed_file/reconstructed_file.json) (*[info](examples/illustrations/reconstructed_file/)*)
- [Recoverability](examples/illustrations/recoverability/recoverability.json) (*[info](examples/illustrations/recoverability/)*)
- [SMS and Contacts](examples/illustrations/sms_and_contacts/sms_and_contacts.json) (*[info](examples/illustrations/sms_and_contacts/)*)
- [Spear Phishing](examples/illustrations/spear_phishing/spear_phishing.json), scenario drafted by [Open Cybersecurity Alliance](https://github.com/opencybersecurityalliance/oca-ontology) (*[info](examples/illustrations/spear_phishing/)*)


This project uses [the `pre-commit` tool](https://pre-commit.com/) for linting the JSON files and ensuring consistent formatting. It can be installed with `pip`:
```bash
pip install pre-commit
pre-commit --version
```

The `pre-commit` tool hooks into Git's commit machinery to run a set of linters and static analyzers over each change. To install `pre-commit` into Git's hooks, run:
```bash
pre-commit install
```

To uninstall `pre-commit`, run either `pre-commit uninstall` or `rm .git/hooks/pre-commit`.
