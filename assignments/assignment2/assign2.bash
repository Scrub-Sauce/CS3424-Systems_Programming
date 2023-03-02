#!/bin/bash

# This program is used to redact personal information from a specified directory and/or sub-directories, if specified, from files that are not been used in a specified duration.

# Check if correct number of parameters are entered
if [[ ${#} < 2 ]] || [[ ${#} > 3 ]]; then
    echo "USAGE: ${0} [PATH] [AGE] [OPTION]" >&2
    exit 1
fi

# Assign variables from command line

file_path=${1}
file_age=${2}

# Check if recursive option is chosen
if [ "${3}" == "-r" ];then
    
else
    
fi

# If recursive, recursively search sub directories for specified criteria

# Else search current directory for specified criteria only

# Find files containing information to be converted

# Use sed to convert files
