#!/usr/bin/env python3

# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to title 17 Section 105 of the
# United States Code this software is not subject to copyright
# protection and is in the public domain. NIST assumes no
# responsibility whatsoever for its use by other parties, and makes
# no guarantees, expressed or implied, about its quality,
# reliability, or any other characteristic.
#
# We would appreciate acknowledgement if the software is used.

"""
This single-purpose script combines the portions of the Inference JSON-LD
into a single JSON-LD file.  This script is likely to be replaced with
an alternative mechanism.
"""

__version__ = "0.1.0"

import logging
import json
import os
import sys

_logger = logging.getLogger(os.path.basename(__file__))

def main():
    obj = None
    _logger.info("args.in_json = %r.", args.in_json)

    # Key: 2-tuple:
    #   * String form of node ID.
    #   * Node "@type" value, in recorded (likely prefixed) form.
    # Value: JSON dictionary.
    nodes = dict()

    for in_json in args.in_json:
        _logger.info("in_json = %r.", in_json)
        with open(in_json, "r") as in_fh:
            in_obj = json.load(in_fh)
            if obj is None:
                obj = in_obj
            else:
                assert isinstance(in_obj, list)
                for item in in_obj:
                    node_id = item.get("@id", "")
                    node_type = item.get("@type", "")
                    nodes[(node_id, tuple(sorted(node_type)))] = item

    for key in sorted(nodes.keys()):
        obj["@graph"].append(nodes[key])

    json.dump(obj, sys.stdout, indent=4, sort_keys=True)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("in_json", nargs="+")
    args = parser.parse_args()
    logging.basicConfig(level=logging.INFO)
    main()
