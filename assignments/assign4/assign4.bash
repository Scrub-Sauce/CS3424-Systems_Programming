#!/bin/bash

# Check if valid arguments were provided
if [ $# -eq 4 ]; then
    data_dir="${1}"
    template="${2}"
    date="${3}"
    output_dir="${4}"

    # Check if provided data directory exists
    if [ ! -d ${data_dir} ];then
        echo "Error: Provided data directory does not exist." >&2
        exit 2
    fi

    # Check if an provided output directory exists
    if [ ! -d ${output_dir} ];then
        mkdir ${output_dir}
    fi

    # Find all valid data files and perform relavent actions
    for file in $(find ${data_dir} -name '[A-Z][A-Z][0-9][0-9][0-9][0-9].crs' -o -name '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9].crs');do
    
    # Read in all variables from each file
    {
        read dept_code dept_name
        read course_name
        read course_sched course_start course_end
        read credit_hours
        read num_students
    } < ${file}
        
        # Parse Course number from data file name
        course_num=`echo "${file}" | grep -oG '[0-9][0-9][0-9][0-9]'`

        # Check if course is over occupancy
        if [ ${num_students} -gt 50 ]; then
            
            # Create new .warn file name
            outfile="${output_dir}/${dept_code}${course_num}.warn"

            # Generate sed script using awk
            gawk -f assign4.awk -v date="${date}" dept_code="${dept_code}" dept_name="${dept_name}" course_name="${course_name}" course_shed="${course_shed}" course_start="${course_start}" course_end="${course_end}" credit_hours="${credit_hours}" num_students="${num_students}" course_num="${course_num}" ${file} > pTmp.sed
        
        # Impliment Generated Sed script on our template using the data provided and create or over write outfile
        sed -f pTmp.sed ${template} > ${outfile}
        fi
    done
    
    # Delete generated sed script
    rm pTmp.sed

# Invalid input prompt
else
    echo "USAGE: ./assign4.bash <data_dir> <template> <date> <output_dir>" >&2
    exit 1
fi

