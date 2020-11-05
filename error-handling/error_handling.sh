#!/usr/bin/env bash

usage () {
      echo "Usage: error_handling.sh <person>" 1>&2
      exit 1

}

main () {
  if (( $# != 1 )); then
    usage
  fi
  
  echo "Hello, $1"
}

main "$@"
