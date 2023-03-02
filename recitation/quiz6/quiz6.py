#!/usr/bin/env python3

import os
import sys
import glob

try:
    with open(sys.argv[1], 'r') as infile:
        evenlines = infile.readlines()[1::2]
    for line in evenlines:
        print(line)

except IOError:
    print("Error opening file.")
    sys.exit(1)
