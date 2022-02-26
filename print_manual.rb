# frozen_string_literal: true

def print_manual
  puts 'Usage: ax [command]'
  puts 'commands: '
  puts '   add_wifi [ssid] [password]:   add wifi to network configs'
  puts '   help:            print this help manual'
  puts '   launch_app [package]:  launch a specific application by package name'
  puts '   layout_bounds [show|hide]:   show or hide layout bounds'
  puts '   list_packages:   list all installed packages'
  puts '   max_bright:      set display to max brightness'
  puts '   permissions [package]: list permissions for package (highlighted in larger dumpsys)'
  puts '   pull_apks [destination] : download apks from device to optional destination or current directory'
  puts '   reboot:          reboot the device'
  puts '   screenshot [destination] :   capture screenshot and save to optional destination or current directory'
  puts '   settings_app:    start system settings app'
  puts '   uninstall_package [package]: remove installed package'
end

# TODO: get this to line up nicely
# TODO: get manual entry from each command
