#!/usr/bin/env bash

declare -A colorValue

colorValue[black]=0
colorValue[brown]=1
colorValue[red]=2
colorValue[orange]=3
colorValue[yellow]=4
colorValue[green]=5
colorValue[blue]=6
colorValue[violet]=7
colorValue[grey]=8
colorValue[white]=9

checkColor() {
    local value=${colorValue["$1"]+abc}
    [[ -z "$value" ]] && { echo 'invalid color provided'; exit 1; }
}

compileNumber() {
    let local value
    
    ((! colorValue["$1"] == 0 )) && value+=${colorValue["$1"]}
    value+=${colorValue["$2"]}

    value=$( echo "${value}*10^${colorValue[$3]}" | bc )

    echo $value
}

compileMagnitude() {
    magnitude=$( bc -l <<< "l($1)/l(10)")

    (( $(bc -l <<< "$magnitude > 10") )) && { echo "$( bc <<< "$1/1000000000") gigaohms"; exit 0; }
    (( $(bc -l <<< "$magnitude > 6") )) && { echo "$( bc <<< "$1/1000000") megaohms"; exit 0; }
    (( $(bc -l <<< "$magnitude > 3.30081279411811693942") )) && { echo "$( bc <<< "$1/1000") kiloohms"; exit 0; }

    echo "$1 ohms"
}

main () {
    checkColor "$1"
    checkColor "$2"
    checkColor "$3"

    compileMagnitude $(compileNumber "$@")
}

main "$@"