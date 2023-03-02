#!/usr/bin/awk -f

{
    username = $3
    usernames[username] = 1
    
    # All regular files
    # All hidden regular files
    # All other files
    # All directories
    # All storage space occupied by regular files

    if($1 ~ /^-/) {
        all_files[username]++
        storage[username] += $5

        if($NF ~ /^\./) {
            hidden_files[username]++
        }
    } else if($1 ~ /^d/) {
        directories[username]++
    } else {
        other_files[username]++
    }
}

END {
    for(username in usernames) {
        print(username ":")
        if(all_files[username]) {
            total_files += all_files[username]
            print("\tAll Files: ", all_files[username])
            if(hidden_files[username]) {
                print("\t\tHidden: ", hidden_files[username])
            }
        }
        if(directories[username]) {
            total_firectories += directories[username]
            print("\t\tDirectories: ", directories[username])
        }
        if(other_files[username]) {
            print("\t\tOther Files: " other_files[username])
        }
        if(storage[username]) {
            print("\t\tStorage (B): ", storage[username])
        }
        print("")
    }
    
    if(length(usernames) > 0) {
        print("Total users:\t", length(usernames))

        if(!total_firectories) {
            total_directories = "0"
        }
        print("Total Directories: ", total_directories)
}
