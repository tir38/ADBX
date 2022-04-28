# frozen_string_literal: true

require_relative 'add_wifi'
require_relative 'clear_app_data'
require_relative 'disable_audio'
require_relative 'display'
require_relative 'help'
require_relative 'launch_system_settings'
require_relative 'launch_app'
require_relative 'layout_bounds'
require_relative 'list_packages'
require_relative 'max_bright'
require_relative 'night_mode'
require_relative 'permissions'
require_relative 'processor'
require_relative 'pull_apks'
require_relative 'reboot_and_wait'
require_relative 'screenshot'
require_relative 'talkback'
require_relative 'uninstall_package'
require_relative 'version_name'

module Commands
  KNOWN_COMMANDS = [
    AddWifi,
    ClearAppData,
    DisableAudio,
    Display,
    Help,
    LaunchApp,
    LaunchSystemSettings,
    LayoutBounds,
    ListPackages,
    MaxBright,
    NightMode,
    Permissions,
    Processor,
    PullApks,
    RebootAndWait,
    Screenshot,
    Talkback,
    UninstallPackage,
    VersionName
  ].freeze

  KNOWN_COMMAND_NAMES = KNOWN_COMMANDS.map(&:name)
end
