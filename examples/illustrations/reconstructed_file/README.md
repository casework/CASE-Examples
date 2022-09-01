# Reconstructed File Example

This example shows how we can use the mechanisms described by [*file*](../file/) and
[*multipart_file*](../multipart_file/) to define how a file was reconstructed by
data carving software.


The provenance record `provenance_record-a04bc3f3-3b3a-4098-b2bc-e636ba1bde75` object points 
to the reconstructed file itself (`reconstructed_file-de78a25a-542f-436a-b8d2-ffc90bd30cdf`) and 
the relationships that connect the data fragments to the created file.

The provenance record `provenance_record-0482e464-4a81-4810-ba35-e61cfd8b7044` object points to the two carved fragments; `data_piece-07e7e719-3904-4787-96ab-eb21a4b84074` and `data_piece-06a91826-f209-4b11-abad-461d09ab3898` respectively, along with the relationships `relationship-30c49e48-8136-4a93-aba9-b2106ec2132f` and `relationship-8e6f02f2-7ec3-4999-a74c-eb9a9e309231` which describe where the data pieces where extracted from within the `android_image-e35985c1-06d6-4ace-8e05-491d7ebefbdb`. 

The provenance record `provenance_record-9dc4b979-5d56-4d47-a4da-541039a1a200` object points to the JPG file header (`data_piece-d3d3dbdd-c294-414b-a3fb-70b95a16a5f0`) that was added by the carving tool in order to reconstruct a working file.

