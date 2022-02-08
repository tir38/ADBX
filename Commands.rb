require_relative "AddWifi.rb"
require_relative "Help.rb"
require_relative "LaunchSystemSettings"
require_relative "ListPackages.rb"
require_relative "MaxBright.rb"
require_relative "Permissions.rb"
require_relative "RebootAndWait.rb"
require_relative "UninstallPackage"

module Commands

  KNOWN_COMMANDS = [
    AddWifi,
    Help,
    LaunchSystemSettings,
    ListPackages,
    MaxBright,
    Permissions,
    RebootAndWait,
    UninstallPackage
  ]

  KNOWN_COMMAND_NAMES = KNOWN_COMMANDS.map { |command| command.name }
end

