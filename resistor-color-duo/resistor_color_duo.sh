#!/usr/bin/env bash

RESISTOR_BANDS=(
    "black:0"
    "brown:1"
    "red:2"
    "orange:3"
    "yellow:4"
    "green:5"
    "blue:6"
    "violet:7"
    "grey:8"
    "white:0"
)

color_check () {
   [[ "${RESISTOR_BANDS[@]}" =~ "${1}" ]] ||  { 
       echo 'input consisted invalid color in it' 1>&2;
       exit 1
    }
}


main () {
  RESISTANCY=""

  for COLOR in "${@:1:2}"; do
    color_check $COLOR
    for BAND in "${RESISTOR_BANDS[@]}"; do
        KEY="${BAND%%:*}"
        VALUE="${BAND##*:}"

        [[ $COLOR == $KEY ]] && RESISTANCY="$RESISTANCY$VALUE"
    done
  done

  echo $RESISTANCY
}

main "$@"

