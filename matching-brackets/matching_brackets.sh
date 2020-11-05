#!/usr/bin/env bash

LEFT_PARENTHIS="("
RIGHT_PARENTHIS=")"
LEFT_SQUARE_BRACKET="["
RIGHT_SQUARE_BRACKET="]"
LEFT_BRACKET="{"
RIGHT_BRACKET="}"


main () {
    
    BUFFER=""
    
    for ((i=0; i<${#1}; i++)); do
        ch=${1:$i:1}
        
        [[ $ch == $LEFT_BRACKET || $ch == $LEFT_PARENTHIS || $ch == $LEFT_SQUARE_BRACKET ]] && BUFFER+=$ch
        
        
        [[ $ch == $RIGHT_BRACKET ]] && {
            [[ ${BUFFER: -1} == $LEFT_BRACKET ]] && BUFFER=${BUFFER:0:${#BUFFER}-1} || {
                echo 'false'
                exit 0
            }
        }
        [[ $ch == $RIGHT_PARENTHIS ]] && {
            [[  ${BUFFER: -1} == $LEFT_PARENTHIS ]] && BUFFER=${BUFFER:0:${#BUFFER}-1} || {
                echo 'false'
                exit 0
            }
        }
        [[ $ch == $RIGHT_SQUARE_BRACKET ]] && {
            [[  ${BUFFER: -1} == $LEFT_SQUARE_BRACKET ]]  && BUFFER=${BUFFER:0:${#BUFFER}-1} || {
                echo 'false'
                exit 0
            }
        }
    done
    
    [[ -z $BUFFER ]] && echo "true" || echo "false"
}

main "$@"

