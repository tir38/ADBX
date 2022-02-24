# frozen_string_literal: true

require_relative 'add_wifi'
require_relative 'help'
require_relative 'launch_system_settings'
require_relative 'launch_app'
require_relative 'layout_bounds'
require_relative 'list_packages'
require_relative 'max_bright'
require_relative 'permissions'
require_relative 'pull_apks'
require_relative 'reboot_and_wait'
require_relative 'uninstall_package'

module Commands
  KNOWN_COMMANDS = [
    AddWifi,
    Help,
    LaunchApp,
    LaunchSystemSettings,
    LayoutBounds,
    ListPackages,
    MaxBright,
    Permissions,
    PullApks,
    RebootAndWait,
    UninstallPackage
  ].freeze

  KNOWN_COMMAND_NAMES = KNOWN_COMMANDS.map(&:name)
end
