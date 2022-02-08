# frozen_string_literal: true

def print_manual
  puts 'Usage: ax [command]'
  puts 'commands: '
  puts '   add_wifi [ssid] [password]:   add wifi to network configs'
  puts '   help:            print this help manual'
  puts '   list_packages:   list all installed packages'
  puts '   max_bright:      set display to max brightness'
  puts '   permissions [package]: list permissions for package (highlighted in larger dumpsys)'
  puts '   reboot:          reboot the device'
  puts '   settings_app:    start system settings app'
  puts '   uninstall_package [package]: remove installed package'
end

# TODO: get manual entry from each command
