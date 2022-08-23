# Reconstructed File Example

This example shows how we can use the mechanisms described by [*file*](../file/) and
[*multipart_file*](../multipart_file/) to define how a file was reconstructed and/or repaired by
data carving software.

The `investigativeaction1` objects in both the `reconstructed_file` and `repaired_file` examples 
describe how the carving tool was run in order to create the provenance records that describe the 
resulting objects created by the tool. The `investigativeaction2` objects describe how the carving
tool combines the carved content to produce the recovered/repaired file.

In both examples, the `provenancerecord1` objects point to the reconstructed/repaired file itself
and the relationships that connect the data fragments to the created file.

The `provenancerecord2` objects points to the carved fragments along with the relationships that describe where 
data pieces where extracted from within the [NIST File Carving image files](https://www.nist.gov/itl/ssd/software-quality-group/computer-forensics-tool-testing-program-cftt/cftt-technical-0). 

In the `repaired_file` example, the `provenancerecord3` object points to the JPG file header (`data_piece0`) that was added
by the carving tool in order to repair and render visible the carved fragment.
