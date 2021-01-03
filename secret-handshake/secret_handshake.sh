#!/usr/bin/env bash

declare -a moves;

moves=( 'wink' 'double blink' 'close your eyes' 'jump');

number_to_binary() {
  echo "obase=2;${1}" | bc;
}


main () { 
    codes=$(number_to_binary $1);
    pad_codes=$(printf "%05d" $codes);
    should_reverse=0;

    declare -a decoded_moves;

    move_index=0;
    for ((i=((${#pad_codes}-1));i>=0;i--)); do
        should_decode="${pad_codes:$i:1}";
        move=${moves[$move_index]};
        
        if (( $should_decode == 1 )); then
            if (( $move_index == 4 )); then
                should_reverse=1;
            else
                decoded_moves+=("${moves[$move_index]}");
            fi
        fi

        move_index=$((move_index + 1));
    done

    if (( should_reverse == 1)); then
        declare -a reversed_decoded_moves;

        for ((i=((${#decoded_moves[@]}-1));i>=0;i--)); do
            reversed_decoded_moves+=("${decoded_moves[$i]}");
        done
        
        (IFS=$','; echo "${reversed_decoded_moves[*]}");
        exit 0;
    fi

    (IFS=$','; echo "${decoded_moves[*]}");
}

main "$@"

