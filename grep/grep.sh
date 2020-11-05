#!/usr/bin/env bash

print_line_numbers=0;
print_only_files_with_match=0;
match_case_insensitive=0;
invert_match=0;
match_whole_line=0;

usage_options() {
  echo "Usage: $0 [n l i v x] <pattern> <files>, $1 is not valid option" 1>&2; exit 1;
}

usage() {
    [[ -n "$1" ]] || ( echo "Usage: grep [options] <search phrase> <file>" 1>&2 && exit 1 );
    [[ -f "$2" ]] || ( echo "Please provide existing file" 1>&2 && exit 1 );
}

main() {
  usage "$@";

  case_phrase=$( (( match_case_insensitive == 1)) && echo "${1,,}" || echo "$1" );
  phrase=$( (( match_whole_line == 1)) && echo "^${case_phrase}$" || echo "$case_phrase" );

  for ((i=2;i<="${#}";i++)); do
    line_number=0;
    
    cat ${!i} | while read -r line; do
      line_number=$(( line_number + 1 ));
      result="";
      
      checked_line=$( (( match_case_insensitive == 1)) && echo "${line,,}" || echo "$line" );
      
      if ( (( invert_match == 0 )) && [[ "$checked_line" =~ ${phrase} ]] ) || 
         ( (( invert_match == 1 )) && [[ ! "$checked_line" =~ $phrase ]] ); then

        (( ${#} > 2 )) || (( $print_only_files_with_match == 1 )) && result+="${!i}";
        (( $print_only_files_with_match == 1 )) && echo "$result" && exit 0;

        [[ -n $result ]] && result+=":";
        (( $print_line_numbers == 1 )) && result+="${line_number}" && result+=":";

        (( $print_only_files_with_match == 0 )) && result+="$line";
        echo "$result";
      fi
    done
  done 
  
}

 while getopts ":nlivx" opt; do
    case ${opt} in
      n )
        print_line_numbers=1;
        ;;
      l )
        print_only_files_with_match=1;
        ;;
      i )
        match_case_insensitive=1;
        ;;
      v )
        invert_match=1;
        ;;
      x )
        match_whole_line=1;
        ;;
      \? )
        wrong_option=$((OPTIND -1));
        usage_options "${!wrong_option}";
        ;;
    esac 
  done

shift $((OPTIND-1))

main "$@"