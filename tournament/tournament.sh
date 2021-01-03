#!/usr/bin/env bash

declare -A wins
declare -A draws
declare -A losses
declare -A teams

header () {
    format="%-31s%s\n"
    printf "$format" "Team" "| MP |  W |  D |  L |  P"
}

results () {
    format="%-31s|%3s |%3s |%3s |%3s |%3s\n"
    
    mp=$(( wins["$1"] + draws["$1"] + losses["$1"] ))
    p=$(( wins["$1"] * 3 + draws["$1"] * 1 ))

    printf "$format" "$1" "$mp" "${wins["$1"]:-0}" "${draws["$1"]:-0}" "${losses["$1"]:-0}" "$p"
}

main () {
    IFS=";"

    while read -r team1 team2 result 
    do
        if [[ -n "$team1" ]] && [[ -n "$team2" ]]; then
            teams["$team1"]=1
            teams["$team2"]=1
        fi

        if [[ "$result" == "win" ]]; then
            wins["$team1"]=$(( ${wins["$team1"]:-0} + 1 ))
            losses["$team2"]=$(( ${losses["$team2"]:-0} + 1 ))
        fi

        if [[ "$result" == "loss" ]]; then
            wins["$team2"]=$(( ${wins["$team2"]:-0} + 1 ))
            losses["$team1"]=$(( ${losses["$team1"]:-0} + 1 ))
        fi

        if [[ "$result" == "draw" ]]; then
            draws["$team1"]=$(( ${draws["$team1"]:-0} + 1 ))
            draws["$team2"]=$(( ${draws["$team2"]:-0} + 1 ))
        fi
    done <  <( [[ -f "$1" ]] || [[ -s /dev/stdin ]] && cat "${1:-/dev/stdin}" || echo "${1}" );

     results=$(
        echo "$(header)"
        for team in ${!teams[@]}; do
            echo "$( results $team)"
        done | sort  -t "|" -k 6,6nr -k 1,1d
    )

    echo "$results"
}

main "$@"
