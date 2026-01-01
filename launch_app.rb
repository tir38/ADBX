# frozen_string_literal: true

require_relative 'validate_package'
require_relative 'find_config'

class LaunchApp
  def self.name
    'launch_app'
  end

  def self.perform(*args)
    cli_package_name = nil
    options = OptionParser.new do |option|
      # find package name from optional
      option.on("--package PACKAGE", "Package name") { |value| cli_package_name = value }
    end
    options.parse(args)

    package_name = get_package(cli_package_name)
    return unless validate_package(package_name)

    # https://developer.android.com/studio/test/other-testing-tools/monkey
    # use monkey to send a single random event to app
    # For some reason monkey will output some data to stderr, use capture3 to also grab that (i.e. show nothing to user)
    #  --pct-syskeys 0  ensures this will work for devices with no physical keys
    Open3.capture3("adb shell monkey --pct-syskeys 0 -p #{package_name} 1")
  end

  def self.similar_sounding_commands
    %w[app start start_app]
  end
end
