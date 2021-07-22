_ax_completions() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="add_wifi reboot max_bright list_packages help permissions settings_app uninstall_package"

    # only tab complete second word in command string
    if [[ ${#COMP_WORDS[@]}  == 2 ]] ; then
	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    	return 0
    fi
}
complete -F _ax_completions ax
