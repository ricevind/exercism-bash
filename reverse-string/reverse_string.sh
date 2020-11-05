#!/usr/bin/env bash

main() {
    reversed=""
    
    for ((i=0; i<"$#1"; i++)) do 
        reversed="${1:$i:1}${reversed}"
    done

    echo "${reversed}"
}

main "$@"
