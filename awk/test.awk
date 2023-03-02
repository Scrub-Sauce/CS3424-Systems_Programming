BEGIN {
    printf("%-6s %4s %10-s\n", "ID", "QTY", "UNIT PRICE");
    numitems = 0  
}

$2 > 200 {
    printf("%6s %4d %8.2f\n", $1, $2, $4);
    numitems++;
}

END {
    print "Total items =", numitems
}
