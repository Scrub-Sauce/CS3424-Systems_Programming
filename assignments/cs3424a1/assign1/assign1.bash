#!/bin/bash

# This script will be used to create and maintain a simple inventory system

not_EOF=0

# Display menu and valid choices
while [ ${not_EOF} ]; do
  echo -e "Enter one of the following actions or press CTRL-D to exit.\nC - create a new item\nR - read an existing item\nU - update an existing item\nD - delete an existing item\n"

  # Break while loop if user CTRL-D
  if ! read user_choice; then
      break
  fi

  # Check if choice is valid, if not prompt again
  case "${user_choice}" in

    # C call create.bash
    [Cc]) ./create.bash;;

    # R call read.bash
    [Rr]) ./read.bash;;

    # U call update.bash
    [Uu]) ./update.bash;;

    # D call delete.bash
    [Dd]) ./delete.bash;;

    # If invalid character print invalid option error
    *) echo "ERROR: Invalid Option";;
  esac
done

