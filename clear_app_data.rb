# frozen_string_literal: true

require_relative 'packages'
require_relative 'find_config'

class ClearAppData
  def self.name
    'clear_app_data'
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

    puts "Clearing app data for #{package_name}"
    Open3.capture2("adb shell pm clear #{package_name}")
  end

  def self.similar_sounding_commands
    %w[remove delete cache]
  end
end
