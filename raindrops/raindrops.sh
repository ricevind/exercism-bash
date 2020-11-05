#!/usr/bin/env bash

declare -A factors_sounds_map
declare -a factors

factors=( 3 5 7 )

factors_sounds_map[${factors[0]}]=Pling
factors_sounds_map[${factors[1]}]=Plang
factors_sounds_map[${factors[2]}]=Plong

main () {
    sound_of_rain=""

    for factor in "${factors[@]}"; do
        (( $1 % "$factor" == 0 )) && sound_of_rain+="${factors_sounds_map[$factor]}"
    done

    echo "${sound_of_rain:=$1}"
}

main "$@"
