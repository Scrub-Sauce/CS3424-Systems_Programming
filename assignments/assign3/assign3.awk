#!/usr/bin/awk -f

NF == 8 {
    username = $3
    usernames [username] = 1
    
    if($1 ~ /^-/) {
        all_files[username]++
        storage[username] += $5
        tmp_file_date = $6 $7
        
        if(!newest){
            newest = tmp_file_date
            newest_info = $0
        } if(newest < tmp_file_date) {
            newest = tmp_file_date
            newest_info = $0
        }
        
        if(!oldest){
            oldest = tmp_file_date
            oldest_info = $0
        } if(oldest > tmp_file_date) {
            oldest = tmp_file_date
            oldest_info = $0
        }

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
        print ("Username:", username)
        if(all_files[username]) {
            print("   Files:")
            total_files += all_files[username]
            print("                All:", all_files[username])
            if(hidden_files[username]) {
                total_hidden += hidden_files[username]
                print("             Hidden:", hidden_files[username])
            }else {
                print("             Hidden: 0")
            }
        }

        if(directories[username]) {
            total_directories += directories[username]
            print("        Directories:", directories[username])
        }
        if(other_files[username]) {
            total_other += other_files[username]
            print("             Others:", other_files[username])
        }
        if(storage[username]) {
            total_storage += storage[username]
            print("        Storage (B):", storage[username], "bytes")
        }
        print("")
    }

    print("Oldest file:")
    printf("    %s\n", oldest_info)
    print("Newest file:")
    printf("    %s\n", newest_info)
    print("")

    if(length(usernames) > 0) {
        printf("Total users:           %d\n", length(usernames))

        if(!total_files) {
            total_files = "0"
        }

        if(!total_hidden) {
            total_hidden = "0"
        }
        printf("Total files:\n")
        printf("    (All / Hidden):    ( %d / %d )\n", total_files, total_hidden)

        if(!total_directories) {
            total_directories = "0"
        }
        printf("Total directories:     %d\n", total_directories)

        if(!total_other) {
            total_other = "0"
        }
        
        printf("Total others:          %d\n", total_other)

        if(!total_storage) {
            total_storage = "0"
        }
        printf("Storage (B):           %d bytes\n", total_storage)
        print("")
    }
}
