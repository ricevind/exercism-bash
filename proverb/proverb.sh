#!/usr/bin/env bash

echoForSentence() {
    echo "For want of a $1 the $2 was lost."
}

echoAndSentence() {
    echo "And all for the want of a $1."
}

main () {
    PROVERB="";
  
    for ((i=1; $i <= ${#@}; i++)); do
        if [[ $i -eq ${#@} ]]; then
            PROVERB+=$(echoAndSentence "${1}")
        else
            PROVERB+=$(echoForSentence "${@:$i:1}" "${@:$((i + 1)):1}")$'\n'
        fi
    done

    echo -e "$PROVERB"
}

main "$@"