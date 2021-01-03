#!/usr/bin/env bash

start=2;
end=$1;

sieve="";
primes="";

addMultiplesToSieve () {
  multiples="";
  nextMultiple=$1;

  while (( $nextMultiple <= $end )); do
    multiples+="${nextMultiple} ";
    nextMultiple=$(( $nextMultiple + $1 ));
  done

  sieve+="${multiples} ";
}

main () {
  (( $1 < 2 )) && exit 0; 

  for i in $( seq $start $end ); do
      if [[ ! $sieve =~ " ${i} " ]]; then
        primes+="${i} ";
        addMultiplesToSieve $i;
      fi
  done

  echo "${primes% }"
}

main "$@"
