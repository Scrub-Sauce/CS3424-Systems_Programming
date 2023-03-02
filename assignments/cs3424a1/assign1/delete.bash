#!/bin/bash

# Delete an existing item

# Prompt user for item_number
read -p "Enter an item number: " item_number

file_name="${item_number}.item"

# If file_name exists, delete file
if [ -f ./data/${file_name} ]; then
    
    # Read Simple name for STDOUT
    read simple_name trash < ./data/${file_name}
    
    # Delete specified item file
    rm ./data/${file_name}

    # Update data/queries.log with deletion record
    echo "DELETED: ${simple_name} - `date`" >> ./data/queries.log

    # STDOUT simple_name was successfully deleted.
    echo "${simple_name} was successfully deleted."
else
    # If file doesnt exist send error
    echo "ERROR: Item Number does not exist"
fi

