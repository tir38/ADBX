_ax_completions() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="add_wifi launch_app layout_bounds list_packages help max_bright permissions pull_apks reboot settings_app uninstall_package "

    # only tab complete second word in command string
    if [[ ${#COMP_WORDS[@]}  == 2 ]] ; then
	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    	return 0
    fi
}
complete -F _ax_completions ax
