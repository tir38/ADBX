_ax_completions() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    primary_opts="add_wifi launch_app layout_bounds list_packages help max_bright permissions pull_apks reboot screenshot, settings_app uninstall_package version_name test"
    test_opts="alpha beta gamma"

    #remember: COMP_WORDS[0] is `ax`
    # tab complete primary word in command string
    if [[ ${#COMP_WORDS[@]}  == 2 ]] ; then
	    COMPREPLY=( $(compgen -W "${primary_opts}" -- ${cur}) )
    	return 0
    fi

    # example: tab complete secondary word IFF primary command is "test"
    if [[ ${#COMP_WORDS[@]}  == 3  && ${COMP_WORDS[1]}  == "test" ]] ; then
      COMPREPLY=( $(compgen -W "${test_opts}" -- ${cur}) )
      return 0
    fi
}
complete -F _ax_completions ax
