#!/usr/bin/env python3

import re
import sys

string1 = "9 is less than 15"

print("search (no groups):")
mo = re.search(r"\d", string1)
print("mo = " + str(mo))
print("mo.group() = " + str(mo.group()))
print("mo.groups() = " + str(mo.groups()))
print()

print("findall (no groups):")
print(re.findall(r"(\d)", string1))
print()

print("finditer (no groups):")
print(re.finditer(r"\d", string1))
iter = re.finditer(r"\d", string1)
for mo in iter:
   print("iter mo: " + str(mo))
   print("iter mo.group(): " + str(mo.group()))
   print("iter mo.groups(): " + str(mo.groups()))
print()
print()
print()

print("search (with groups):")
mo = re.search(r"(\d).*(\d)", string1)
print("mo = " + str(mo))
print("mo.group() = " + str(mo.group()))
print("mo.groups() = " + str(mo.groups()))
print()

print("findall (with groups):")
print(re.findall(r"(\d).*(\d)", string1))
print()

print("finditer (with groups):")
print(re.finditer(r"(\d).*(\d)", string1))
iter = re.finditer(r"(\d).*(\d)", string1)
for mo in iter:
   print("iter mo: " + str(mo))
   print("iter mo.group(): " + str(mo.group()))
   print("iter mo.groups(): " + str(mo.groups()))
