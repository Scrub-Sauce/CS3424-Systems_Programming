#!/bin/bash

# Update an existing item

# Prompt user for item parameters one at a time
read -p "Item Number: " tmp_item_number

# Check for white space in tmp_simple_name
while [ 0 ];do
    read -p "Simple Name(No Whitespace): " tmp_simple_name
    if [[ ${tmp_simple_name} != *" "* ]];then
        break
    else
        echo "ERROR: Simple name cannot contain spaces"
    fi
done

read -p "Item Name: " tmp_item_name
read -p "Current Quantity: " tmp_current_quantity
read -p "Maximum Quantity: " tmp_max_quantity
read -p "Description: " tmp_item_description

# Generate item's file name
file_name="${tmp_item_number}.item"

# Search for item's file
if [ -w ./data/${file_name} ];then

    # Read in existing data 
    {
        read simple_name item_name
        read current_quantity max_quantity
        read item_description
    } < ./data/${file_name}
    
    # Check if prompt was answered and if so store the new value
    if [ -n "${tmp_simple_name}" ];then
        simple_name="${tmp_simple_name}"
    fi

    if [ -n "${tmp_item_name}" ];then
        item_name="${tmp_item_name}"
    fi

    if [ -n "${tmp_current_quantity}" ];then
        current_quantity="${tmp_current_quantity}"
    fi

    if [ -n "${tmp_max_quantity}" ];then
        max_quantity="${tmp_max_quantity}"
    fi

    if [ -n "${tmp_item_description}" ];then
        item_description="${tmp_item_description}"
    fi

    # Overwrite existing file with updated information
    echo -e "${simple_name} ${item_name}\n${current_quantity} ${max_quantity}\n${item_description}" > ./data/${file_name}
    
    # Append queries.log to show "UPDATED: simple_name - date"
    echo "UPDATED: ${simple_name} - `date`" >> ./data/queries.log
else
    # If file does not exist or cant be written to print error
    echo "ERROR: File does not exist or you dont have permissions to write to it."
fi

