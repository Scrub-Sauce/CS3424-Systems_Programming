#!/bin/bash

# Creates item in a file with relavent information

while [ 0 ]; do

    # Item Number: (int) Simple Name: (String, no whitespace) Item name: (String) Current Quantity: (Integer) Max Quantity: (Integer) Description: (String)
    read -p "Item Number: " item_number

    # Reject whitespace entry
    while [ 0 ]; do
        read -p "Simple Name(No Whitespace): " simple_name
        if [[ ${simple_name} != *" "* ]]; then
            break
        else
            echo "ERROR: Simple Name cannot have spaces"
        fi
    done

    read -p "Item name: " item_name
    read -p "Current Quantity: " current_quantity
    read -p "Max Quantity: " max_quantity
    read -p "Description: " item_description

    # Check if the data directory exists and if it doesn't, create it
    if [ ! -d ./data ]; then
        mkdir data
    fi

    # Generate file name
    file_name="${item_number}.item"

    # If item exists error prompt
    if [ ! -f ./data/${file_name} ]; then
        
        # Create a new file in data directory with a .item extension
        echo -e "${simple_name} ${item_name}\n${current_quantity} ${max_quantity}\n${item_description}" > ./data/${file_name}

        # Append data/queries.log with "CREATED: simple_name - date"
        echo "CREATED: ${simple_name} - `date`" >> ./data/queries.log

        # Print file creation successful
        echo -e "\n${simple_name} file created as ${file_name}\n"

        # Break out of item creation once valid file is created
        break
    else
        # Send Error message if file already exists
        echo "ERROR: Item Number already exists."
    fi
done

