#!/usr/bin/env bash

rollDice () {
    echo "$(( 1 + RANDOM % 6 ))"
}

rollStat () {
    declare -a stats

    numberOfStats=3
    currentMin=$(rollDice)


    i=0
    while (( $i < $numberOfStats )); do
        stat=$(rollDice)
        (( $stat > $currentMin )) && stats+=($stat) || { 
            stats+=($currentMin); currentMin=$stat; 
        }
        (( i+=1 ))
    done

    value=0
    for val in stats; do 
        value=$(( value + val )) 
    done

    echo "${value}"
}

calcModifier() {
    echo $(( ($1 - 10 - ( $1 % 2 )) / 2 ))
}

generate() {
    baseStats=(strength dexterity constitution intelligence wisdom charisma)
    constitution=0

    for stat in ${baseStats[*]}; do
        statValue=$( rollStat )
        [[ $stat == "constitution" ]] && constitution=$statValue
        echo -e "${stat} ${statValue}"
    done

    modifier=$( calcModifier $constitution )

    echo "hitpoints $(( 10 + $modifier ))"
}

main () {
    if [[ $1 == 'modifier' ]]; then
        echo "$(calcModifier $2)"
    fi

    if [[ $1 == 'generate' ]]; then 
        echo "$(generate)"
    fi

}

main "$@"

