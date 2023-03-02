#!/bin/bash

# Read an existing file's information

# Promp user for item number
read -p "Enter Item Number: " item_number

# Generate searched file name
file_name="${item_number}.item"

# Search for file base on item number
if [ -r ./data/${file_name} ]; then

    # Read file into parameters to be printe
    {
        read simple_name item_name
        read current_quantity max_quantity
        read item_description
     }< ./data/${file_name}

    # Print Item information
    echo -e "\nItem Name: ${item_name}\nSimple Name: ${simple_name}\nItem Number: ${item_number}\nQty: ${current_quantity}/${max_quantity}\nDescription: ${item_description}\n"
else
    # Print error if item not found
    echo "ERROR: File does not exist or you do not have read permisions"
fi

