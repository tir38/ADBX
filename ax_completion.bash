_ax_completions()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    primary_opts="add_wifi clear_app_data disable_audio display display_scale font_scale launch_app layout_bounds list_packages help max_bright night_mode permissions processor pull_apks reboot screenshot settings_app talkback uninstall_package version_name"

    #remember: COMP_WORDS[0] is `ax`
    # tab complete primary word in command string
    if [[ ${#COMP_WORDS[@]}  == 2 ]] ; then
	    COMPREPLY=( $(compgen -W "${primary_opts}" -- ${cur}) )
    	return 0
    fi

    # secondary tab completion for disable_audio
    disable_audio_opts="voice_call system ring music alarm notification dtfm accessibility"
    if [[ ${#COMP_WORDS[@]}  == 3  && ${COMP_WORDS[1]}  == "disable_audio" ]] ; then
      COMPREPLY=( $(compgen -W "${disable_audio_opts}" -- ${cur}) )
      return 0
    fi

    # secondary tab completion for night_mode
     night_mode_opts="on off auto"
        if [[ ${#COMP_WORDS[@]}  == 3  && ${COMP_WORDS[1]}  == "night_mode" ]] ; then
          COMPREPLY=( $(compgen -W "${night_mode_opts}" -- ${cur}) )
          return 0
        fi

    # secondary tab completion for font_scale
    font_scale_opts="small default large largest"
      if [[ ${#COMP_WORDS[@]}  == 3  && ${COMP_WORDS[1]}  == "font_scale" ]] ; then
        COMPREPLY=( $(compgen -W "${font_scale_opts}" -- ${cur}) )
        return 0
      fi

    # secondary tab completion for display_scale
    display_scale_opts="small default large larger largest"
      if [[ ${#COMP_WORDS[@]}  == 3  && ${COMP_WORDS[1]}  == "display_scale" ]] ; then
        COMPREPLY=( $(compgen -W "${display_scale_opts}" -- ${cur}) )
        return 0
      fi
}
complete -F _ax_completions ax
