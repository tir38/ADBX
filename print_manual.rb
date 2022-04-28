# frozen_string_literal: true

# remove rubocop suppression when we fix https://github.com/tir38/ADBX/issues/64
# rubocop:disable Metrics/AbcSize
def print_manual
  puts 'Usage: ax [command]'
  puts 'commands: '
  puts '   add_wifi [ssid] [password]:   add wifi to network configs'
  puts '   clear_app_data [package]:   clear app data, including cache and accepted permissions'
  puts '   disable_audio [audio_stream]:   lower a specific audio stream volume to zero'
  puts '   display:   print display size and density'
  puts '   help:            print this help manual'
  puts '   launch_app [package]:  launch a specific application by package name'
  puts '   layout_bounds [show|hide]:   show or hide layout bounds'
  puts '   list_packages:   list all installed packages'
  puts '   max_bright:      set display to max brightness'
  puts '   night mode [on|off|auto]:      turn device night mode to on, off, or auto'
  puts '   permissions [package]: list permissions for package (highlighted in larger dumpsys)'
  puts '   processor : print information about deivce processor(s)'
  puts '   pull_apks [destination] : download apks from device to optional destination or current directory'
  puts '   reboot:          reboot the device'
  puts '   screenshot [destination] :   capture screenshot and save to optional destination or current directory'
  puts '   settings_app:    start system settings app'
  puts '   talkback [on|off]:      turn Talkback on or off'
  puts '   uninstall_package [package]: remove installed package'
  puts '   version_name [package]: print package version name'
end
# rubocop:enable Metrics/AbcSize
# TODO: get this to line up nicely
