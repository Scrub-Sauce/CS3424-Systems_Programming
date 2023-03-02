#!/usr/bin/env python3

import re
import sys
import os

# Check for correct number of arguments
if len(sys.argv) != 5:
    print("Usage: " + sys.argv[0] + " <data_dir> <template> <date> <output_dir>")
    sys.exit(1)

# Initialize variables from command line
data_dir = sys.argv[1]
template = sys.argv[2]
date = sys.argv[3]
output_dir = sys.argv[4]

# Check if provided data directory exists
if not os.path.isdir(sys.argv[1]):
    print("Error: data directory does not exist")
    sys.exit(1)

# Check if output directory exists and if not create it
if not os.path.isdir(sys.argv[4]):
    os.makedirs(sys.argv[4])

# Iterate through relavent files in data directory
for filename in os.listdir(data_dir):

# Check if file has the correct name format and if so read in the relavent data
    if re.match(r"^[A-Z]{2}\d{4}.crs$", filename) or re.match(r"^[A-Z]{3}\d{4}.crs$", filename):
        data_file = open(data_dir + "/" + filename, 'r')
        file_line1 = data_file.readline().split(" ",1)
        dept_code = file_line1[0]
        dept_name = file_line1[1].strip("\n")
        course_name = data_file.readline().strip("\n")
        file_line3 = data_file.readline().split(" ",3)
        course_shed = file_line3[0]
        course_start = file_line3[1]
        course_end = file_line3[2].strip("\n")
        credit_hours = data_file.readline().strip("\n")
        num_students = data_file.readline().strip("\n")
        course_num = filename.lstrip(dept_code).rstrip(".crs")

        data_file.close()

# Check if the number of students 
        if int(num_students) > 30:

# Generate Outfile path
            outfile_path = output_dir + "/" + dept_code + course_num + ".warn"

# Open Template file to be read
            template_file = open(template, 'r')

# Check if Outfile already exists and if so delete it for new file to be created
            if os.path.isfile(outfile_path):
                os.remove(outfile_path)

# Create Outfile and close it.
            outfile = open(outfile_path, 'x')
            outfile.close()

# Open outfile for appendment
            outfile = open(outfile_path, 'a')
            
# Read in line from template and replace relavent fields
            for line in template_file:
                tmp_line = line.replace("[[dept_code]]", dept_code)
                tmp_line = tmp_line.replace("[[dept_name]]", dept_name)
                tmp_line = tmp_line.replace("[[course_name]]", course_name)
                tmp_line = tmp_line.replace("[[course_start]]", course_start)
                tmp_line = tmp_line.replace("[[course_end]]", course_end)
                tmp_line = tmp_line.replace("[[credit_hours]]", credit_hours)
                tmp_line = tmp_line.replace("[[num_students]]", num_students)
                tmp_line = tmp_line.replace("[[course_num]]", course_num)
                tmp_line = tmp_line.replace("[[date]]", date)

# Write curated line to outfile
                outfile.write(tmp_line)

# Close opened files
            template_file.close()
            outfile.close()

    else:
        continue

