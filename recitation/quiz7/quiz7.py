#!/usr/bin/env python3

import sys

name = input("Enter your name: ")
date_of_birth = input("Enter your Date of Birth: ")

try:
    new_file = open(name, 'x')
    new_file.write(date_of_birth)

except FileExistsError:
    print("Error File already exists")
    sys.exit(1)

new_file.close()
