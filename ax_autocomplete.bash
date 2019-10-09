#!/bin/bash

_completions(){
    local currentWord previousWord

    COMPREPLY=()
    currentWord=${COMP_WORDS[COMP_CWORD]}
    previousWord=${COMP_WORDS[COMP_CWORD-1]}

 if [[ $COMP_CWORD -eq 1 ]]; then
    # auto complete first word
    COMPREPLY=($(compgen -W "reboot max_bright no_other" "${COMP_WORDS[1]}"))
  elif [[ $COMP_CWORD -eq 2 ]]; then
    # auto complete second word, if needed
    case "$previousWord" in
      "reboot")
        # no second option for reboot
        ;;
      "max_bright")
        COMPREPLY=( $(compgen -W "low high" -- ${currentWord}) )
        ;;
      *)
        ;;
    esac
  fi

  return 0
}
complete -F _completions main
